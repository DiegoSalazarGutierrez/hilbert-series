def weighted_deg(exponents, n_vars):
    return sum(exponents[k] * (k // n_vars + 1) for k in range(len(exponents)))

def hilbert_series_full_head_module(n_val, s_val, N):
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
    
    S0 = PolynomialRing(QQ, [f'y0_{i}' for i in range(1, N)])
    y_vars = [S0(f'y0_{i}') for i in range(1, N)]
    
    subs_dict = {x_vars[0]: 0}
    for i in range(1, N):
        subs_dict[x_vars[i]] = y_vars[i - 1]
        
    I0_gens = [pol.subs(subs_dict) for pol in I_n_coeffs]
    
    # Add ALL components of (X^s)^{(l)}
    for pol in I_s_coeffs:
        subbed = pol.subs(subs_dict)
        if subbed != 0:
            I0_gens.append(subbed)
            
    I0 = S0.ideal(I0_gens)
    
    B0 = [I0.normal_basis(d) for d in range(N)]
    hilbert_series = 0
    for d in range(N):
        for b in B0[d]:
            w = weighted_deg(b.exponents()[0], n)
            if w < N:
                hilbert_series += t^w
    return hilbert_series

def andrews_gordon(n, s, N):
    T.<t> = PowerSeriesRing(QQ, default_prec=N)
    return prod((1 - t^i)^(-1) for i in range(1, N) if i % (2*n + 1) not in [0, s, 2*n + 1 - s]).polynomial()

n_val, s_val = 3, 2
N = 10
print(f"Testing n={n_val}, s={s_val}, up to degree {N-1}")
ag_series_3_2 = andrews_gordon(3, 2, N)
ag_series_2_2 = andrews_gordon(2, 2, N)
hm_series_full = hilbert_series_full_head_module(n_val, s_val, N)
print("AG 3,2:   ", ag_series_3_2)
print("AG 2,2:   ", ag_series_2_2)
print("Full Head:", hm_series_full)
print("Match 3,2?", hm_series_full == ag_series_3_2)
print("Match 2,2?", hm_series_full == ag_series_2_2)
