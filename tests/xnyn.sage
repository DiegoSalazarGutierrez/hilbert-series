import time
import sys
load('tests/hilbert-series-up-to.sage')

print("================================================================================")
print("Testing Conjecture 4.2 for (x*y)^n with n = 3, 4 in focused arc algebra")
print("Target: HP(t) = (H(t) / (1 - t)) * AG_{n, 1}(t)")
print("================================================================================\n")

R.<x, y> = PolynomialRing(QQ)

def conjectured_series(n_val, max_deg):
    r"""Conjecture 4.2: HP_{J^0 A_n}(t) = (H(t)/(1-t)) * AG_{n, 1}(t)"""
    T.<t> = PowerSeriesRing(QQ, default_prec=max_deg + 1)
    H = prod(1 / (1 - t^i) for i in range(1, max_deg + 1))
    ag = rogers_ramanujan(n_val, 1, max_deg + 1)
    return ((H / (1 - t)) * ag).polynomial()

results = []

cases = [
    (3, 25),
    (4, 14),
]

for n_val, N_fast in cases:
    print(f"********************************************************************************")
    print(f"Case: I = ((x*y)^{n_val}) = (x^{n_val} * y^{n_val})")
    print(f"********************************************************************************")
    sys.stdout.flush()
    
    I = R.ideal(x^n_val * y^n_val)
    
    # 1. Baseline verification with hilbert_series_focused_jet_algebra (N = 6)
    N_orig = 6
    t0 = time.time()
    hp_orig = hilbert_series_focused_jet_algebra(I, N_orig)
    dt_orig = time.time() - t0
    target_orig = conjectured_series(n_val, N_orig - 1)
    match_orig = (hp_orig == target_orig)
    print(f"  [N = 6]  hilbert_series_focused_jet_algebra: match = {match_orig} (in {dt_orig:.3f}s)")
    sys.stdout.flush()
    
    # 2. Deep verification with fast_hilbert_series_focused_jet_algebra (N_fast)
    print(f"  [N = {N_fast}] fast_hilbert_series_focused_jet_algebra: computing degrees 0..{N_fast - 1}...")
    sys.stdout.flush()
    t0 = time.time()
    hp_fast = fast_hilbert_series_focused_jet_algebra(I, N_fast, p=32003)
    dt_fast = time.time() - t0
    target_fast = conjectured_series(n_val, N_fast - 1)
    match_fast = (hp_fast == target_fast)
    print(f"  [N = {N_fast}] Completed in {dt_fast:.2f}s! All {N_fast} coefficients match? : {match_fast}")
    sys.stdout.flush()
    
    results.append((n_val, N_fast, match_orig, dt_orig, match_fast, dt_fast))
    print()

print("================================================================================")
print("FINAL SUMMARY: Conjecture 4.2 Verification for (xy)^n")
print("================================================================================")
print(f"{'n':2s} | {'N_fast':6s} | {'N=6 Match':10s} | {'Time N=6':10s} | {'Deep Match':10s} | {'Time Deep'}")
print("-" * 65)
for n_val, N_fast, m_orig, t_orig, m_fast, t_fast in results:
    print(f"{n_val:2d} | {N_fast:6d} | {str(m_orig):10s} | {t_orig:8.3f}s  | {str(m_fast):10s} | {t_fast:8.2f}s")
print("================================================================================")
