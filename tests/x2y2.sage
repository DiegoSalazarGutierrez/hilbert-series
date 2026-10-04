import time
load('tests/hilbert-series-up-to.sage')

print("================================================================================")
print("Testing Conjecture for I = (x^2 * y^2) in focused arc algebra J^0(k[x, y]/I)")
print("Target: HP(t) = (H(t) / (1 - t)) * AG_{2, 1}(t)")
print("================================================================================\n")

R.<x, y> = PolynomialRing(QQ)
I = R.ideal(x^2 * y^2)

def conjectured_series(max_deg):
    r"""Conjecture 4.1 from notes/focused-arc-algebra.tex: (H(t)/(1-t)) * AG_{2,1}(t)"""
    T.<t> = PowerSeriesRing(QQ, default_prec=max_deg + 1)
    H = prod(1 / (1 - t^i) for i in range(1, max_deg + 1))
    ag = rogers_ramanujan(2, 1, max_deg + 1)
    return ((H / (1 - t)) * ag).polynomial()

# -----------------------------------------------------------------------------
# Part 1: Baseline verification with hilbert_series_focused_jet_algebra (N = 6)
# -----------------------------------------------------------------------------
N_orig = 6
print(f"--- 1. Baseline: hilbert_series_focused_jet_algebra up to degree {N_orig - 1} ---")
t0 = time.time()
hp_orig = hilbert_series_focused_jet_algebra(I, N_orig)
dt_orig = time.time() - t0
target_orig = conjectured_series(N_orig - 1)
match_orig = (hp_orig == target_orig)

print(f"Computed HP : {hp_orig}")
print(f"Conjectured : {target_orig}")
print(f"Match?      : {match_orig} (in {dt_orig:.3f}s)\n")

# -----------------------------------------------------------------------------
# Part 2: Deep verification with fast_hilbert_series_focused_jet_algebra (N = 27)
# -----------------------------------------------------------------------------
N_fast = 27
print(f"--- 2. Deep verification: fast_hilbert_series_focused_jet_algebra up to degree {N_fast - 1} ---")
print(f"Computing degrees 0 through {N_fast - 1} using graded Macaulay linear algebra...")

t0 = time.time()
hp_fast = fast_hilbert_series_focused_jet_algebra(I, N_fast, p=32003)
dt_fast = time.time() - t0
target_fast = conjectured_series(N_fast - 1)
match_fast = (hp_fast == target_fast)

print(f"\nCompleted in {dt_fast:.2f}s!")
print(f"All coefficients match up to degree {N_fast - 1}? : {match_fast}")
print("\nDegree-by-degree breakdown:")
print(f"{'d':2s} | {'Computed':10s} | {'Conjectured':11s} | {'Match?'}")
print("-" * 40)
for d in range(N_fast):
    c_comp = hp_fast[d]
    c_pred = target_fast[d]
    print(f"{d:2d} | {int(c_comp):10d} | {int(c_pred):11d} | {c_comp == c_pred}")
print("================================================================================")
