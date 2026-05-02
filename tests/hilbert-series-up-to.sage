def weighted_deg(exponents, N):
    return sum(exponents[k]*(k%(N - 1) + 1) for k in range(len(exponents)))

def hilbert_series_focused_jet_algebra(R, F, N):
    n = len(R.gens())
    S = PolynomialRing(QQ, [f'x{i}_{j}' for j in range(n) for i in range(N)])
    x = [[S(f'x{i}_{j}')for j in range(n)] for i in range(N)]
    T.<t> = PolynomialRing(S)
    I = (F.subs({R.gens()[j]: sum(x[i][j]*t^i for i in range(N)) for j in range(n)})).coefficients()
    S0 = PolynomialRing(QQ, [f'y{i}_{j}' for i in range(1, N) for j in range(n)])
    y = [[S0(f'y{i}_{j}')for j in range(n)] for i in range(1, N)]
    subs_dict = {**{x[0][j]: 0 for j in range(n)}, **{x[i][j]: y[i - 1][j] for i in range(1, N) for j in range(n)}}
    I0 = ideal([pol.subs(subs_dict) for pol in I])
    B0 = [I0.normal_basis(d) for d in range(N)]
    hilbert_series = 0
    for d in range(N):
        for b in B0[d]:
            if weighted_deg(b.exponents()[0], N) < N:
                hilbert_series += t^weighted_deg(b.exponents()[0], N)
    return hilbert_series

R.<x> = PolynomialRing(QQ)
F = x^2
N = 25

print(hilbert_series_focused_jet_algebra(R, F, N))