def weighted_deg(exponents, n_vars):
    return sum(exponents[k] * (k // n_vars + 1) for k in range(len(exponents)))

def hilbert_series_true_head(n_val, s_val, N):
    R.<x> = PolynomialRing(QQ)
    
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
        is_in_y = True
        for var in pol.variables():
            if str(var).startswith('e_'):
                is_in_y = False
                break
        if is_in_y:
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

print(f"=== Running Sanity Checks for True Head Module (up to degree {N-1}) ===")
for n_val, s_val in pairs:
    print(f"\nTesting n={n_val}, s={s_val}:")
    ag_series = andrews_gordon(n_val, s_val, N)
    try:
        hm_series = hilbert_series_true_head(n_val, s_val, N)
        match = (hm_series == ag_series)
        print("  Andrews-Gordon:", ag_series)
        print("  True Head:     ", hm_series)
        print("  Match?         ", match)
    except Exception as e:
        print("  Error computing true head:", e)
