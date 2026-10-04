def weighted_deg(exponents, n):
    return sum(exponents[k] * (k // n + 1) for k in range(len(exponents)))

def hilbert_series_focused_jet_algebra(I, N):
    R = I.ring()
    n = len(R.gens())
    S0 = PolynomialRing(QQ, [f'y{i}_{j}' for i in range(1, N) for j in range(n)])
    T.<t> = PolynomialRing(S0)
    arcs = {R.gens()[j]: sum(S0(f'y{i}_{j}') * t^i for i in range(1, N)) for j in range(n)}
    I0_gens = []
    for F in I.gens():
        F_arc = F.subs(arcs)
        I0_gens.extend([F_arc[l] for l in range(1, N) if F_arc[l] != 0])
    I0 = S0.ideal(I0_gens)
    B0 = [I0.normal_basis(d) for d in range(N)]
    hilbert_series = 0
    for d in range(N):
        for b in B0[d]:
            if weighted_deg(b.exponents()[0], n) < N:
                hilbert_series += t^weighted_deg(b.exponents()[0], n)
    return hilbert_series

def fast_hilbert_series_focused_jet_algebra(I, N, p=32003):
    """
    Computes the Hilbert series of the focused jet algebra J^0(R/I) up to degree N-1
    using graded Macaulay matrix linear algebra (as used for x^2 y^2 up to N=27).
    """
    R_base = I.ring()
    n_vars = len(R_base.gens())
    F_p = GF(p) if p else QQ
    max_deg = N - 1
    if max_deg < 0:
        return PolynomialRing(QQ, 't')(0)

    # 1. Monomials by weight
    monomials_by_weight = {d: [] for d in range(max_deg + 1)}

    def gen_monomials(v_idx, idx, cur_w, cur_factors):
        if cur_w > max_deg:
            return
        if idx > max_deg:
            if v_idx + 1 < n_vars:
                gen_monomials(v_idx + 1, 1, cur_w, cur_factors)
            else:
                monomials_by_weight[cur_w].append(cur_factors)
            return
        max_pow = (max_deg - cur_w) // idx
        for p_pow in range(max_pow + 1):
            next_f = cur_factors + ((v_idx, idx, p_pow),) if p_pow > 0 else cur_factors
            gen_monomials(v_idx, idx + 1, cur_w + p_pow * idx, next_f)

    gen_monomials(0, 1, 0, ())
    mon_to_idx = {d: {m: i for i, m in enumerate(monomials_by_weight[d])} for d in range(max_deg + 1)}

    def mult_mon(m1, m2):
        d = {}
        for v_idx, idx, p_pow in m1:
            d[(v_idx, idx)] = d.get((v_idx, idx), 0) + p_pow
        for v_idx, idx, p_pow in m2:
            d[(v_idx, idx)] = d.get((v_idx, idx), 0) + p_pow
        res = []
        for (v_idx, idx) in sorted(d.keys()):
            res.append((v_idx, idx, d[(v_idx, idx)]))
        return tuple(res)

    # 2. Arcs & Relations
    var_names = [f'y_{i}_{j}' for j in range(n_vars) for i in range(1, max_deg + 1)]
    if not var_names:
        return PolynomialRing(QQ, 't')(1)
    R_arc = PolynomialRing(QQ, var_names)
    T_ser = PowerSeriesRing(R_arc, 'tau', default_prec=max_deg + 1)
    tau = T_ser.gen()

    arcs = {R_base.gens()[j]: sum(R_arc(f'y_{i}_{j}') * tau^i for i in range(1, max_deg + 1)) for j in range(n_vars)}

    F_rels = {}
    for F in I.gens():
        F_tau = F.subs(arcs)
        for l in range(1, max_deg + 1):
            poly_l = F_tau[l]
            if poly_l == 0:
                continue
            rel_terms = {}
            for coeff, mon in zip(poly_l.coefficients(), poly_l.monomials()):
                factors = []
                for v, p_pow in zip(R_arc.gens(), mon.exponents()[0]):
                    if p_pow > 0:
                        v_str = str(v)
                        parts = v_str.split('_')
                        i_idx = int(parts[1])
                        j_idx = int(parts[2])
                        factors.append((j_idx, i_idx, p_pow))
                factors.sort()
                rel_terms[tuple(factors)] = int(coeff)
            if l not in F_rels:
                F_rels[l] = []
            F_rels[l].append(rel_terms)

    # 3. Graded linear algebra
    hp = []
    for d in range(max_deg + 1):
        num_mons = len(monomials_by_weight[d])
        rel_vectors = []
        for l in range(1, d + 1):
            if l not in F_rels:
                continue
            w_m = d - l
            for m in monomials_by_weight[w_m]:
                for r_dict in F_rels[l]:
                    vec = {}
                    for m_rel, coeff in r_dict.items():
                        prod_mon = mult_mon(m, m_rel)
                        col = mon_to_idx[d][prod_mon]
                        vec[col] = (vec.get(col, 0) + coeff)
                    rel_vectors.append(vec)

        if not rel_vectors:
            rk = 0
        else:
            M = matrix(F_p, len(rel_vectors), num_mons, sparse=True)
            for r_idx, v in enumerate(rel_vectors):
                for col, val in v.items():
                    if (val % p != 0) if p else (val != 0):
                        M[r_idx, col] = val
            rk = M.rank()

        dim_d = num_mons - rk
        hp.append(dim_d)

    t_out = PolynomialRing(QQ, 't').gen()
    return sum(hp[d] * t_out^d for d in range(max_deg + 1))

def rogers_ramanujan(n, s, N):
    r"""
    Computes the Andrews-Gordon / generalized Rogers-Ramanujan series AG_{n, s}(t) truncated to degree N-1:
    AG_{n, s}(t) = \prod_{i=1, i \not\equiv 0, \pm s \pmod{2n+1}}^\infty \frac{1}{1 - t^i}
    where s in {1, ..., n}.
    """
    T.<t> = PowerSeriesRing(QQ, default_prec=N)
    modulus = 2 * n + 1
    excluded = {0, s % modulus, (-s) % modulus}
    H = prod((1 - t^i)^(-1) for i in range(1, N))
    return (H * prod((1 - t^i) for i in range(1, N) if i % modulus in excluded)).polynomial()