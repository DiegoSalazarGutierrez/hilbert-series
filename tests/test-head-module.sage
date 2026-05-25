def weighted_deg(exponents, n_vars):
    return sum(exponents[k] * (k // n_vars + 1) for k in range(len(exponents)))

def hilbert_series_head_module(n_val, s_val, N):
    R.<x> = PolynomialRing(QQ)
    I = R.ideal(x^n_val)
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
    # Add the head module relation: (X^{(1)})^s = 0
    I0_gens.append(y_vars[0]**s_val)
    
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
    # The allowed parts are those NOT congruent to 0, s, or -s mod 2n+1
    return prod((1 - t^i)^(-1) for i in range(1, N) if i % (2*n + 1) not in [0, s, 2*n + 1 - s]).polynomial()

for n_val, s_val in [(2, 2), (3, 3), (3, 2), (4, 4), (4, 3), (4, 2)]:
    N = 10
    print(f"Testing n={n_val}, s={s_val}, up to degree {N-1}")
    ag_series = andrews_gordon(n_val, s_val, N)
    hm_series = hilbert_series_head_module(n_val, s_val, N)
    print("Andrews-Gordon:", ag_series)
    print("Head Module:   ", hm_series)
    print("Match?         ", ag_series == hm_series)
    print("-" * 40)
