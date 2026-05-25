def weighted_deg(exponents, n_vars):
    return sum(exponents[k] * (k // n_vars + 1) for k in range(len(exponents)))

def hilbert_series_naive_head(n_val, s_val, N):
    """Computes HP series of J^0A / ((X^{(1)})^s)"""
    n = 1
    S = PolynomialRing(QQ, [f'x0_{j}' for j in range(N)])
    x_vars = [S(f'x0_{j}') for j in range(N)]
    T.<t> = PolynomialRing(S)
    
    sub_poly = sum(x_vars[i]*t^i for i in range(N))**n_val
    I_coeffs = sub_poly.coefficients()
    
    S0 = PolynomialRing(QQ, [f'y0_{i}' for i in range(1, N)])
    y_vars = [S0(f'y0_{i}') for i in range(1, N)]
    
    subs_dict = {x_vars[0]: 0}
    for i in range(1, N):
        subs_dict[x_vars[i]] = y_vars[i - 1]
        
    I0_gens = [pol.subs(subs_dict) for pol in I_coeffs]
    I0_gens.append(y_vars[0]**s_val)
    
    I0 = S0.ideal(I0_gens)
    B0 = [I0.normal_basis(d) for d in range(N)]
    
    hilbert_series = 0
    t_var = PolynomialRing(QQ, 't').gen()
    for d in range(N):
        for b in B0[d]:
            w = weighted_deg(b.exponents()[0], n)
            if w < N:
                hilbert_series += t_var^w
    return hilbert_series

def hilbert_series_true_head(n_val, s_val, N):
    """Computes HP series of the image of v^{(0)} in J^0_partial M"""
    n = 1
    S = PolynomialRing(QQ, [f'x0_{j}' for j in range(N)])
    x_vars = [S(f'x0_{j}') for j in range(N)]
    T.<t> = PolynomialRing(S)
    
    x_series = sum(x_vars[i]*t^i for i in range(N))
    
    sub_poly_n = x_series**n_val
    I_n_coeffs = sub_poly_n.coefficients()
    
    sub_poly_s = x_series**s_val
    I_s_coeffs = sub_poly_s.coefficients()
    
    e_vars_str = [f'e_{i}' for i in range(1, N)] + ['e_0']
    y_vars_str = [f'y0_{i}' for i in range(1, N)]
    
    S_full = PolynomialRing(QQ, e_vars_str + y_vars_str, order='lex')
    
    y_vars_full = [S_full(v) for v in y_vars_str]
    e_0 = S_full('e_0')
    e_higher = [S_full(f'e_{i}') for i in range(1, N)]
    e_vars = [e_0] + e_higher
    
    subs_dict_full = {S(f'x0_{i}'): y_vars_full[i-1] for i in range(1, N)}
    subs_dict_full[S('x0_0')] = 0
    
    J_gens = [pol.subs(subs_dict_full) for pol in I_n_coeffs]
    s_coeffs_subbed = [pol.subs(subs_dict_full) for pol in I_s_coeffs]
    
    for l in range(s_val, N + s_val - 1):
        rel = 0
        for k in range(0, l - s_val + 1):
            if k < len(e_vars) and (l-k) < len(s_coeffs_subbed):
                rel += s_coeffs_subbed[l-k] * e_vars[k]
        J_gens.append(rel)
        
    J = S_full.ideal(J_gens)
    
    Ann_e0_full = J.quotient(S_full.ideal([e_0]))
    gb = Ann_e0_full.groebner_basis()
    
    S0 = PolynomialRing(QQ, y_vars_str)
    Ann_gens_S0 = []
    for pol in gb:
        if not any(str(var).startswith('e_') for var in pol.variables()):
            Ann_gens_S0.append(S0(pol))
            
    Ann_e0 = S0.ideal(Ann_gens_S0)
    B0 = [Ann_e0.normal_basis(d) for d in range(N)]
    
    hilbert_series = 0
    t_var = PolynomialRing(QQ, 't').gen()
    for d in range(N):
        for b in B0[d]:
            w = weighted_deg(b.exponents()[0], n)
            if w < N:
                hilbert_series += t_var^w
    return hilbert_series

def andrews_gordon(n, s, N):
    T.<t> = PowerSeriesRing(QQ, default_prec=N)
    return prod((1 - t^i)^(-1) for i in range(1, N) if i % (2*n + 1) not in [0, s, 2*n + 1 - s]).polynomial()

N = 8
pairs = [(2, 2), (3, 2), (3, 3), (4, 2), (4, 3)]

print(f"=== Verification of Conjecture 6.2 up to degree {N-1} ===")
for n_val, s_val in pairs:
    print(f"\nTesting n={n_val}, s={s_val}:")
    
    ag_series = andrews_gordon(n_val, s_val, N)
    print("  [1] Andrews-Gordon Series:           ", ag_series)
    
    try:
        hm_naive = hilbert_series_naive_head(n_val, s_val, N)
        match_naive = (hm_naive == ag_series)
        print(f"  [2] Naive Head J^0A / (X^(1))^{s_val}:     {hm_naive} (Match: {match_naive})")
    except Exception as e:
        print("  [2] Naive Head Error:", e)

    try:
        hm_true = hilbert_series_true_head(n_val, s_val, N)
        match_true = (hm_true == ag_series)
        print(f"  [3] True Head Im(\eta) annihilator:  {hm_true} (Match: {match_true})")
    except Exception as e:
        print("  [3] True Head Error:", e)
    
    print("-" * 60)
