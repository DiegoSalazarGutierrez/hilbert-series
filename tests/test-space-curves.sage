load('tests/hilbert-series-up-to.sage')

# 3 variables
R3.<x, y, z> = PolynomialRing(QQ)

# A surface in A^3 (embedding dimension 3)
I_surface = R3.ideal(x^2 + y^2 + z^2)

# A space curve in A^3 (embedding dimension 3)
I_curve = R3.ideal([x*y, x*z, y*z])

# 4 variables
R4.<x, y, z, w> = PolynomialRing(QQ)
I_point4 = R4.ideal([x^2, y^2, z^2, w^2])

N = 5

print("Testing surface in A^3: x^2 + y^2 + z^2 = 0")
print("Expected start: 1 + 3*t + ...")
print(hilbert_series_focused_jet_algebra(I_surface, N))

print("\nTesting space curve in A^3: x*y=0, x*z=0, y*z=0")
print("Expected start: 1 + 3*t + ...")
print(hilbert_series_focused_jet_algebra(I_curve, N))

print("\nTesting fat point in A^4: x^2=0, y^2=0, z^2=0, w^2=0")
print("Expected start: 1 + 4*t + ...")
print(hilbert_series_focused_jet_algebra(I_point4, N))
