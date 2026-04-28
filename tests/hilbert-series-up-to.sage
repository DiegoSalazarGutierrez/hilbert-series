def my_weight2(my_tuple, N):
    return sum(my_tuple[k]*(k%(N-1) + 1) for k in range(len(my_tuple)))

def my_weight(my_tuple, n, N):
    return sum(my_tuple[i + N*j - 1]*i for j in range(n) for i in range(1, N))

def hilbert_series_focused_jet_algebra(R, F, N):
    n = len(R.gens())
    S = PolynomialRing(QQ, [f'x{i}_{j}' for j in range(n) for i in range(N)])
    x = [[S(f'x{i}_{j}')for j in range(n)] for i in range(N)]
    T.<t> = PolynomialRing(S)
    I = (F.subs({R.gens()[j]: sum(x[i][j]*t^i for i in range(N)) for j in range(n)})).coefficients()
    print(I)
    S0 = PolynomialRing(QQ, [f'y{i}_{j}' for i in range(1, N) for j in range(n)])
    y = [[S0(f'y{i}_{j}')for j in range(n)] for i in range(1, N)]
    subs_dict = {**{x[0][j]: 0 for j in range(n)}, **{x[i][j]: y[i - 1][j] for i in range(1, N) for j in range(n)}}
    print(subs_dict)
    I0 = ideal([pol.subs(subs_dict) for pol in I])
    print(I0)
    B0 = [I0.normal_basis(d) for d in range(N)]
    print(B0)
    result = 0
    for d in range(N):
        for b in B0[d]:
            if my_weight2(b.exponents()[0], N) < N:
                # print(my_weight(b.exponents()[0], N))
                result += t^my_weight2(b.exponents()[0], N)
    return result

R.<x> = PolynomialRing(QQ)
F = x^2
N = 25

# print(hilbert_series_jet_algebra(R, F, N))
hilbert_series_focused_jet_algebra(R, F, N)

1+3