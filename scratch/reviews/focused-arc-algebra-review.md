# Review of `focused-arc-algebra.tex` (Full Document)

**Date**: 2026-05-02  
**References used**: `refs/boundary-minimal-models.tex`, `refs/arXiv-1101.4950v2/` (Bruschek–Mourtada–Schepers)

---

## Overview

The document has two main parts:

1. **Lines 25–137**: Algebraic definitions → jet algebra → focused arc algebra → coordinate presentation → two examples → a conjecture.
2. **Lines 140–184**: Scheme-theoretic perspective on arc spaces, $K$-valued points, the reparametrization action $t \mapsto \lambda t$, and the intrinsic definition of the weight grading.

The previous review (conversation `f1c113e4`) covered lines 25–137. This review covers the **entire document**, incorporating the previous findings and adding analysis of lines 140–184 against both references.

---

## Part I: Algebra and Examples (L25–137)

### 1. Definitions (L25–39)

| Line | Status | Notes |
|------|--------|-------|
| L25 | ✅ | $\mathbb{N}$-graded ring definition correct. |
| L27 | ✅ | $k \hookrightarrow A$ convention (faithful $k$-algebra) is fine. |
| L28–29 | ✅ | "$1 \in A_0$ is automatic" — correct and good addition. |
| L38–39 | ✅ | $\partial(A_n) \subseteq A_{n+1}$ consistent with arc space convention. |

### 2. Jet Algebra and Focused Arc Algebra (L41–72)

| Line | Issue | Severity |
|------|-------|----------|
| L42 | $JA$ introduced without definition or reference. Should reference the universal property construction: for any differential algebra $B$ and algebra map $A \to B$, there is a unique differential algebra map $JA \to B$. See `boundary-minimal-models.tex` Appendix B (L1282–1307) or Arakawa's construction. | 🟡 Missing def |
| L43 | $(A)_\partial = JA$ — notation $(A)_\partial$ undefined. Means "smallest differential subalgebra containing $A$". Cf. `boundary-minimal-models.tex` Remark 4 (L1309–1315). | 🟡 Missing def |
| L46 | Grading definition correct: weight = sum of derivative orders. Consistent with both references. | ✅ |
| L53 | $(JA)_0 = A$ — correct. | ✅ |
| L59–63 | $J^{\mathfrak{p}}A = JA \otimes_A \kappa(\mathfrak{p})$ — matches Definition 3.1 of arXiv paper exactly: "$J_\infty(X) \otimes_{J_0(X)} \kappa(\mathfrak{p})$". | ✅ |
| L72 | $\dim((J^{\mathfrak{p}}A)_0) = 1$ — correct, since $(JA)_0 = A$ and $A \otimes_A \kappa(\mathfrak{p}) \cong \kappa(\mathfrak{p})$. ArXiv paper confirms: "the weight zero part...is always a one-dimensional $\kappa(\mathfrak{p})$-vector space" (§3, after Def 3.1). | ✅ |

### 3. Coordinate Presentation (L74–117)

| Line | Issue | Severity |
|------|-------|----------|
| L77 | $A = k[X_1,\dots,X_n]/(F_1,\dots,F_m)$ with $F_r(0)=0$ — standard setup. | ✅ |
| L86–92 | Identifying $JA$ with arcs $x(t) \in k[[t]]^n$ satisfying $F_r(x(t))=0$. This is the functorial description from arXiv §2 (Prop 2.1). The derivation $\partial(t^i) = t^{i+1}$ is multiplication by $t$, consistent with $D(y_i) = y_{i+1}$ in arXiv §5. | ✅ |
| L93–97 | Writing $A = \{x \in k^n \mid F_r(x) = 0\}$ conflates the ring with its variety of $k$-points. Minor but could confuse. | 🟡 Expository |
| L99–107 | Taylor expansion to get $JA = k[X_j^{(i)}]/(G_r^{(i)})$ — matches arXiv §2 exactly. | ✅ |
| L103 | Subscript notation: $G_r^{(i)} \in k[X_j^{(i)} \mid i \in \mathbb{N}, j = 1,\dots,n]$. Both $i$ and $j$ vary, but same letter $i$ used for the superscript index and the running index. Could be clarified. | 🟡 Notation |
| L116 | **Typo**: denominator has $r = 1,\dots,n$ but should be $r = 1,\dots,m$ (number of relations, not variables). | 🔴 Error |

### 4. Examples (L119–133)

#### Example 1 (L119–125): $A = k[X]$

$H_{J^0A}(t) = \prod_{i \ge 1}(1-t^i)^{-1}$. Since $J^0(k[X]) = k[X^{(1)}, X^{(2)}, \dots]$ with $\deg(X^{(i)}) = i$, the Hilbert series is the partition generating function. **Correct.** Matches arXiv Prop 3.3 (smooth point, $d=1$).

#### Example 2 (L127–133): $A = k[X]/(X^2)$

$H_{J^0A}(t) = \prod_{i \equiv 1,4 \pmod{5}}(1-t^i)^{-1}$. This is the main theorem of arXiv-1101.4950v2 (Theorem 5.1) for $n=2$: $\HP_{J^0_\infty(X)}(t) = \prod_{i \not\equiv 0,2,3 \pmod{5}}(1-t^i)^{-1}$, which equals $\prod_{i \equiv 1,4 \pmod{5}}(1-t^i)^{-1}$. **Correct.**

In the vertex algebra context (`boundary-minimal-models.tex`), this corresponds to $R_{\text{Vir}_{2,5}} \cong \mathbb{C}[L_{-2}]/(L_{-2}^2)$ (Example 6, L973), and the Hilbert series matches $\ch_{L(c_{2,5}, h_{1,1})}(q)$ (Lemma 4, L651–657).

| Issue | Severity |
|-------|----------|
| **Missing characteristic assumption**: The relations in $J^0A$ for $X^2=0$ involve coefficients like $2y_1y_2$. Over $\text{char}(k) = 2$, these vanish, changing the Gröbner basis. The arXiv paper assumes $\text{char}(k) = 0$ throughout (§3). `boundary-minimal-models.tex` works over $\mathbb{C}$. The notes should state $\text{char}(k) = 0$. | 🟠 Missing hyp |
| **Missing reference**: This deep result (first Rogers-Ramanujan identity via arc spaces) needs a citation. Primary: Bruschek–Mourtada–Schepers (arXiv:1101.4950). Vertex algebra side: `boundary-minimal-models.tex` Theorem 3. | 🟡 Missing ref |

### 5. Conjecture (L135–138)

> $A = k[X]/F(X)$, $F(X) = X^k + a_{k-1}X^{k-1} + \cdots + a_iX^i$, $i \ge 1$.
> $J^0A = \text{identity of Gordon-Ramanujan-Poincaré with } k, i$

**Analysis**: The arXiv paper proves the result for $F(X) = X^n$ (Theorem 5.1): $\HP_{J^0_\infty}(t) = \prod_{j \not\equiv 0, n, n+1 \pmod{2n+1}}(1-t^j)^{-1}$, which is Gordon's identity with parameters $s = n, i = 1$ (in the notation of `boundary-minimal-models.tex` eq. (1)).

| Issue | Severity |
|-------|----------|
| Needs precise statement. "Gordon-Ramanujan-Poincaré identity" is not standard terminology. | 🟡 Clarify |
| The conjecture is likely **not** true in full generality as stated. The Hilbert series of $J^0(k[X]/(F))$ depends on $F$, not just on $k$ and $i$. The arXiv paper only proves the case $F = X^n$ (pure power). | 🟠 Needs care |

---

## Part II: Scheme-Theoretic Perspective (L140–184)

This section develops the intrinsic/functorial viewpoint on arc spaces and the weight grading. It closely parallels Remark 3.2 of the arXiv paper.

### 6. $K$-Valued Points (L140–155)

| Line | Issue | Severity |
|------|-------|----------|
| L140 | "$X$ $k$-scheme ($X \to \text{Spec}(k)$) (not necessarily of finite type)" — fine as a note, but phrased telegraphically. | 🟡 Expository |
| L141 | "$k \to K$ a extension" — typo: "an extension". | 🟡 Typo |
| L144 | $X(K) = \text{Hom}_k(\text{Spec}(K), X) = \{(x, i) \mid x \in X, i: k(x) \to K\}$ — correct description of $K$-valued points. The letter $i$ clashes with the index $i$ used earlier; consider using $\iota$ or $\phi$ for the embedding $k(x) \to K$. | 🟡 Notation clash |
| L146–155 | The evaluation map $f_K: X(K) \to K$ is correctly defined. The factorization through $\mathcal{O}_{X,x} \to k(x)$ is standard. | ✅ |

### 7. Arc Space Functorial Definition (L157–162)

| Line | Issue | Severity |
|------|-------|----------|
| L158,160 | Uses $\text{Spec}(K[[t]])$ but should use $\text{Spf}(K[[t]])$ (formal spectrum). The arXiv paper states: "The arc space $X_\infty$ represents the functor...that associates to a $k$-algebra $A$ the set $\text{Hom}_k(\text{Spf}(A[[t]]), X)$" (§2). Using $\text{Spec}$ includes the generic point of $K[[t]]$, which is incorrect for arcs. | 🔴 Error |

> [!WARNING]
> The distinction between $\text{Spec}$ and $\text{Spf}$ matters here. A morphism $\text{Spec}(K[[t]]) \to X$ is a $K[[t]]$-valued point of $X$ (which sees all primes of $K[[t]]$, including the generic point), while $\text{Spf}(K[[t]]) \to X$ is a formal arc (which only sees the maximal ideal $(t)$). The arc space parametrizes the latter.

### 8. Reparametrization Action and Weight Grading (L164–184)

| Line | Issue | Severity |
|------|-------|----------|
| L164–168 | The endomorphism $\varphi_\lambda: K[[t]] \to K[[t]]$, $t \mapsto \lambda t$. Correct. Matches arXiv Remark 3.2 exactly. | ✅ |
| L170–173 | The $K^\times$-action via $(\lambda, \gamma) \mapsto \gamma \circ \text{Spec}(\varphi_\lambda)$. Correct modulo the Spec/Spf issue above. | ✅ (modulo Spf) |
| L175–179 | Homogeneity condition: $f_K(\lambda \cdot (x,i)) = \lambda^d f_K(x,i)$. This matches arXiv Remark 3.2. However, $f$ is on $J_\infty X$ and the points should be in $J_\infty X(K)$, not $X(K)$. The text at L179 writes $(x,i) \in X(K)$. | 🔴 Error |
| L181–184 | Reformulation $f_K(x(\lambda t)) = \lambda^d f_K(x(t))$ — clearer and correct. | ✅ |
| L181 | Missing punctuation after "the following". | 🟡 Typo |

---

## Summary of Issues

### Errors

| # | Location | Description |
|---|----------|-------------|
| 1 | L116 | Index range: $r = 1,\dots,n$ should be $r = 1,\dots,m$. |
| 2 | L158,160,172 | $\text{Spec}(K[[t]])$ should be $\text{Spf}(K[[t]])$. |
| 3 | L175,179 | Homogeneity domain: $(x,i)$ should be in $J_\infty X(K)$, not $X(K)$. |

### Missing Hypotheses

| # | Location | Description |
|---|----------|-------------|
| 4 | Global | $\text{char}(k) = 0$ needed (both references assume this). |

### Missing Definitions / References

| # | Location | Description |
|---|----------|-------------|
| 5 | L42 | $JA$ needs definition or reference (universal property). |
| 6 | L43 | $(A)_\partial$ notation undefined. |
| 7 | L127–133 | Example 2 needs reference (Bruschek–Mourtada–Schepers). |
| 8 | L135–138 | Conjecture needs precise statement and caveats. |

### Notation / Expository

| # | Location | Description |
|---|----------|-------------|
| 9 | L93–97 | Ring vs $k$-points conflation. |
| 10 | L103 | Letter $i$ ambiguity. |
| 11 | L141 | "a extension" → "an extension". |
| 12 | L144 | Letter $i$ for embedding clashes with index. Use $\iota$. |
| 13 | L181 | Missing punctuation. |

---

## Dictionary Across All Three Documents

| `focused-arc-algebra.tex` | arXiv-1101.4950v2 | `boundary-minimal-models.tex` |
|---|---|---|
| $k$-algebra $A$ | coordinate ring of $X$ | Zhu $C_2$-algebra $R_V$ |
| Jet algebra $JA$ | $J_\infty(X)$ | Jet algebra $JR_V$ |
| Focused arc algebra $J^0A$ | $J^0_\infty(X)$ | $JR_V \otimes_{R_V} R_M$ |
| $\partial$ with $\partial(A_n) \subseteq A_{n+1}$ | Derivation $D$, $D(y_i)=y_{i+1}$ | Translation $T$, $[H,T]=T$ |
| $A = k[X]/(X^s)$ | $n$-fold point $y^s = 0$ | $R_{\text{Vir}_{2,2s+1}} = \mathbb{C}[L_{-2}]/(L_{-2}^s)$ |
| $H_{J^0A}(t)$ | $\HP_{J^0_\infty(X)}(t)$ | $\ch(q)$, Andrews-Gordon product |
| Reparametrization (L164–173) | Remark 3.2 ($k^\times$-action) | Hamiltonian $H$ with $[H,\partial]=\partial$ |

> [!NOTE]
> The mathematical content is **solid overall**. The critical fixes are: (1) Spec → Spf, (2) the index typo at L116, and (3) the domain of the homogeneity condition at L175–179. The remaining issues are about missing context (definitions, references, characteristic).
