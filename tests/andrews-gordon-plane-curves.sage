load('tests/hilbert-series-up-to.sage')

def andrews_gordon(n, s, N):
    """Compute AG_{n, s}(t) truncated to N terms."""
    T.<t> = PowerSeriesRing(QQ, default_prec=N)
    H = prod((1 - t^i)^(-1) for i in range(1, N))
    P = prod((1 - t^i) for i in range(1, N) if i % (2*n + 1) in [0, s, 2*n + 1 - s])
    return (H * P).polynomial()

def search_plane_curves(N, n_max):
    """Systematic search over candidate plane curves."""
    R.<x, y> = PolynomialRing(QQ)

    # Precompute all AG targets
    targets = {}
    for n in range(1, n_max + 1):
        for s in range(1, n + 1):
            targets[(n, s)] = andrews_gordon(n, s, N)

    # Family 1: X^a * Y^b (Skipped for now)
    # candidates = []
    # for a in range(1, 5):
    #     for b in range(1, 5):
    #         candidates.append((f"x^{a}*y^{b}", R.ideal(x^a * y^b)))

    # Family 2: X^a + Y^b
    candidates = []
    for a in range(2, 6):
        for b in range(2, 6):
            candidates.append((f"x^{a}+y^{b}", R.ideal(x^a + y^b)))

    print(f"Starting search with N={N}, n_max={n_max}")
    print(f"Testing {len(candidates)} candidates...")
    
    for name, I in candidates:
        try:
            print(f"Testing I=({name})...")
            hp = hilbert_series_focused_jet_algebra(I, N)
            print(f"  HP = {hp}")
            for (n, s), ag in targets.items():
                if hp == ag:
                    print(f"  MATCH: I=({name}) <-> AG_{{{n},{s}}}(t)")
        except Exception as e:
            print(f"  Error processing I=({name}): {e}")

if __name__ == "__main__":
    search_plane_curves(N=6, n_max=5)
