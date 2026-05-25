from sage.all import *

def andrews_gordon(n, s, N):
    """Compute AG_{n, s}(t) truncated to N terms."""
    T = PowerSeriesRing(QQ, 't', default_prec=N)
    t = T.gen()
    H = prod((1 - t^i)^(-1) for i in range(1, N))
    P = prod((1 - t^i) for i in range(1, N) if i % (2*n + 1) in [0, s, 2*n + 1 - s])
    return (H * P).polynomial()

def compute_unfocused_conformal_hp(s, i, N):
    """
    Computes HP series of unfocused JR_V / (x^(0))^i
    with conformal weights w(x^(j)) = j+2.
    """
    # We only need variables up to weight N
    # The maximum index j such that w(x^(j)) < N is j < N-2.
    max_var = N - 2
    if max_var < 0:
        return 1
        
    var_names = [f"x{j}" for j in range(max_var + 1)]
    weights = [j + 2 for j in range(max_var + 1)]
    
    R = PolynomialRing(QQ, var_names, order=TermOrder('wdegrevlex', weights))
    x = R.gens()
    
    T_series = PowerSeriesRing(R, 't', default_prec=max_var + 1)
    t = T_series.gen()
    
    # x(t) = x0 + x1*t + x2*t^2 + ...
    xt = sum(x[j]*t^j for j in range(max_var + 1))
    
    # Base ring relations: (x(t))^s = 0
    xs = xt^s
    base_rels = [xs[l] for l in range(max_var + 1)]
    
    # Module relation: (x0)^i = 0
    # Wait, the paper says JR_V \otimes_{R_V} R_M.
    # R_M = C[x] / (x^i). So the relation is (x0)^i = 0.
    mod_rels = [x[0]^i]
    
    J = R.ideal(base_rels + mod_rels)
    
    try:
        basis_J = J.normal_basis()
        
        def weight(monomial):
            exps = monomial.degrees()
            return sum(e * w for e, w in zip(exps, weights))
        
        T_poly = PolynomialRing(QQ, 't')
        t_poly = T_poly.gen()
        
        HP = sum(t_poly^weight(m) for m in basis_J)
        return HP.truncate(N)
    except Exception as e:
        return f"Error: {e}"

if __name__ == "__main__":
    N = 15
    print("Testing unfocused tensor product with conformal weights")
    for s in [2, 3]:
        for i in range(1, s + 1):
            ag = andrews_gordon(s, i, N)
            hp = compute_unfocused_conformal_hp(s, i, N)
            print(f"s={s}, i={i}")
            print(f"  AG = {ag}")
            print(f"  HP = {hp}")
            print(f"  Match? {ag == hp}")
