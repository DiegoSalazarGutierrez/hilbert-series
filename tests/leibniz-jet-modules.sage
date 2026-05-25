from sage.all import *

def andrews_gordon(n, s, N):
    """Compute AG_{n, s}(t) truncated to N terms."""
    T = PowerSeriesRing(QQ, 't', default_prec=N)
    t = T.gen()
    H = prod((1 - t^i)^(-1) for i in range(1, N))
    P = prod((1 - t^i) for i in range(1, N) if i % (2*n + 1) in [0, s, 2*n + 1 - s])
    return (H * P).polynomial()

def compute_leibniz_jet_module_hp(n, s, N):
    """
    Computes the Hilbert series of the Leibniz Jet Module J^0 M 
    where M = k[X]/(X^s) over A = k[X]/(X^n).
    Uses the dummy variable trick to compute module HP via ideal HP.
    """
    # Variables: x1..x{N-1}, v0..v{N-1}
    x_vars = [f"x{i}" for i in range(1, N)]
    v_vars = [f"v{i}" for i in range(N)]
    var_names = x_vars + v_vars
    
    weights = [i for i in range(1, N)] + [i for i in range(N)]
    
    # Use weighted degree reverse lexicographic order for efficient Grobner basis
    T_order = TermOrder('wdegrevlex', weights)
    R = PolynomialRing(QQ, var_names, order=T_order)
    
    x = [0] + list(R.gens()[:N-1])
    v = list(R.gens()[N-1:])
    
    T_series = PowerSeriesRing(R, 't', default_prec=N+1)
    t = T_series.gen()
    
    # X(t) = x1*t + x2*t^2 + ... (focused arc algebra, so x0 = 0)
    Xt = sum(x[i]*t^i for i in range(1, N))
    
    # Base ring relations: (X(t))^n = 0
    Xn = Xt^n
    base_rels = [Xn[l] for l in range(N)]
    
    # Module relations: (X(t))^s * v(t) = 0
    Xs = Xt^s
    vt = sum(v[i]*t^i for i in range(N))
    Xsv = Xs * vt
    mod_rels = [Xsv[l] for l in range(N)]
    
    # Kill quadratic terms in v to isolate the linear part (the module)
    quad_rels = [v[i]*v[j] for i in range(N) for j in range(i, N)]
    
    # Ideal J for V/J = R_base + M
    J = R.ideal(base_rels + mod_rels + quad_rels)
    
    # Ideal I_R for R_base itself (just the base ring, kill all v's)
    I_R = R.ideal(base_rels + v)
    
    try:
        basis_J = J.normal_basis()
        basis_IR = I_R.normal_basis()
        
        def weight(monomial):
            exps = monomial.degrees()
            return sum(e * w for e, w in zip(exps, weights))
        
        T_poly = PolynomialRing(QQ, 't')
        t_poly = T_poly.gen()
        
        HP_J = sum(t_poly^weight(m) for m in basis_J)
        HP_IR = sum(t_poly^weight(m) for m in basis_IR)
        
        # The module's Hilbert series is the difference
        HP_M = HP_J - HP_IR
        
        # Truncate to precision N
        return HP_M.truncate(N)
    except Exception as e:
        return f"Error: {e}"

def search_leibniz_modules(N, n_max):
    print(f"Starting Leibniz Jet Module search with N={N}, n_max={n_max}")
    
    targets = {}
    for n in range(2, n_max + 1):
        for s in range(1, n + 1):
            targets[(n, s)] = andrews_gordon(n, s, N)
    
    for n in range(2, n_max + 1):
        for s in range(1, n): # Only test s < n
            print(f"Testing n={n}, s={s}...")
            hp = compute_leibniz_jet_module_hp(n, s, N)
            print(f"  HP = {hp}")
            
            # Check for matches
            match_found = False
            for (target_n, target_s), ag in targets.items():
                if hp == ag:
                    print(f"  MATCH: Leibniz({n}, {s}) <-> AG_{{{target_n},{target_s}}}(t)")
                    match_found = True
            
            if not match_found:
                print(f"  (No match. Expected AG_{{{n},{s}}}(t) = {targets[(n, s)]})")

if __name__ == "__main__":
    search_leibniz_modules(N=6, n_max=3)
