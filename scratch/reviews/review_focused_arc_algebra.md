# Review: `focused-arc-algebra.tex`

**Date:** 2026-05-09  
**File:** [focused-arc-algebra.tex](../../notes/focused-arc-algebra.tex)  
**Reference:** [BMS (arXiv:1101.4950v2)](../../refs/arXiv-1101.4950v2)

---

## Overall Assessment

The document gives a self-contained development of focused arc algebras, starting from graded rings and building up to the jet algebra construction, the focused arc algebra via base change, and the scheme-theoretic weight grading. The mathematical content is largely correct and well-organized, but there are several issues ranging from notational bugs to incomplete sections. The document also reflects a productive working process — the final sections read as research notes rather than polished exposition.

---

## Issues Found

### 1. Hilbert-Poincaré Series Notation Inconsistency (Line 36)

> [!WARNING]
> **Bug:** The series is defined as $HP_A(t)$ on line 32 but then referenced as $H_A(t)$ on line 36.

```diff
- If each $A_n$ is finite dimensional, then $H_A(t) \in \mathbb{N}[[t]]$.
+ If each $A_n$ is finite dimensional, then $HP_A(t) \in \mathbb{N}[[t]]$.
```

### 2. Jet Algebra Not Formally Defined (Lines 42–43)

[Lines 42–43](../../notes/focused-arc-algebra.tex#L42-L43) introduce $JA$ as "the jet algebra of $A$" and claim $A \hookrightarrow JA$ with $(A)_\partial = JA$. But the jet algebra is not defined until [equations (9)/(11) on lines 144–184](../../notes/focused-arc-algebra.tex#L144-L184), and the universal property is never stated. This creates a forward-reference problem: the grading in [line 46](../../notes/focused-arc-algebra.tex#L46) and the claim $(JA)_0 = A$ on [line 53](../../notes/focused-arc-algebra.tex#L53) rely on properties that haven't been established yet.

> [!TIP]
> Consider restructuring so that the abstract characterization (lines 42–53) comes *after* the explicit coordinate construction (lines 96–148), or at minimum add a forward reference: "We will construct $JA$ explicitly below (see equation~\eqref{eq:9})."

### 3. Weight vs. Degree Terminology (Lines 46, 52)

The grading defined in [line 46](../../notes/focused-arc-algebra.tex#L46) uses the total order of the derivation as the grading index (i.e., $n_1 + \dots + n_s = n$). This matches what BMS calls "weight" (see [section_3, line 5](../../refs/arXiv-1101.4950v2/section_3_ArcsAndRogersRamanujanIdentities.tex#L5): *"We prefer to use the terminology 'weight' instead of 'degree' here"*). The notes use "$\mathbb{N}$-grading" without explicitly calling it a weight grading. This is fine for notes, but worth being aware of for any future formalization.

### 4. Missing `\theoremstyle{definition}` (Lines 9–16)

The document has `\theoremstyle{remark}` for remarks and examples, but there is no `\theoremstyle{definition}` — all of the initial material (graded rings, algebras, Hilbert series, etc.) is presented inline without numbered definition environments. This is a stylistic choice and fine for notes, but inconsistent with the use of numbered `example` environments later.

### 5. The Two Derivation Conventions (Lines 96–101 vs. 176–188)

The document correctly presents two conventions:

| Convention | Derivation | Equation |
|:---|:---|:---|
| "Divided power" ([eq. 4](../../notes/focused-arc-algebra.tex#L97-L100)) | $\partial X_j^{(i)} = (i+1)X_j^{(i+1)}$ | Requires $\text{char}(k) = 0$ |
| "Simple" ([eq. 11](../../notes/focused-arc-algebra.tex#L178-L181)) | $\partial X_j^{(i)} = X_j^{(i+1)}$ | Works in any characteristic |

And correctly states the isomorphism $X_j^{(i)} \mapsto i! X_j^{(i)}$ in characteristic zero ([line 188](../../notes/focused-arc-algebra.tex#L188)).

**However:** BMS Section 2 uses the "simple" derivation $D(x_s^{(i)}) = x_s^{(i+1)}$ throughout (see [section_2, line 22](../../refs/arXiv-1101.4950v2/section_2_ArcsAndRogersRamanujanIdentities.tex#L22) and [line 42](../../refs/arXiv-1101.4950v2/section_2_ArcsAndRogersRamanujanIdentities.tex#L42)). Then in the proof of Proposition 2.1 (equations by deriving), they show that using the substitution $x_i \mapsto x_i^{(0)}/0! + x_i^{(1)}/1! \cdot t + \dots$ recovers the "divided power" coefficients.

> [!NOTE]
> The notes correctly explain why $\partial X_j^{(i)} = (i+1)X_j^{(i+1)}$ arises from requiring $\partial(F(X(t))) = \partial_t(F(X(t)))$. This motivation ([lines 103–117](../../notes/focused-arc-algebra.tex#L103-L117)) is one of the strongest parts of the document.

### 6. Typo in Equation (11) (Line 180)

```latex
\partial X^{(i)}_j = X^{(i + 1)}_j
```

This is correct for the "simple" derivation. No issue here — just confirming consistency.

### 7. Example 2: Rogers-Ramanujan Identity (Lines 168–174)

The claim ([lines 168–174](../../notes/focused-arc-algebra.tex#L168-L174)) is:

$$HP_{J^0A}(t) = \prod_{\substack{i \in \mathbb{Z}_+, \\ i \equiv 1, 4 \bmod 5}} \frac{1}{1-t^i}, \quad A = k[X]/(X^2).$$

This is **correct** and matches [BMS Theorem 5.1](../../refs/arXiv-1101.4950v2/section_5_ArcsAndRogersRamanujanIdentities.tex#L384-L392) specialized to $n = 2$:

$$HP_{J_\infty^0(X)}(t) = \prod_{\substack{i \ge 1 \\ i \not\equiv 0, 2, 3 \bmod 5}} \frac{1}{1-t^i}$$

Since $i \not\equiv 0, 2, 3 \pmod{5}$ is equivalent to $i \equiv 1, 4 \pmod{5}$, the formulas agree. ✅

### 8. The `f^{(l)}_r` Evaluation (Lines 151–158)

The focused arc algebra is computed by setting $X_j^{(0)} = 0$ and working with $i \in \mathbb{Z}_+$ variables. The notation $f_r^{(l)} = F_r^{(l)}|_{X_j^{(0)}=0}$ matches BMS's notation exactly (see [section_3, line 19](../../refs/arXiv-1101.4950v2/section_3_ArcsAndRogersRamanujanIdentities.tex#L19)).

> [!NOTE]
> The constraint should be $l \in \mathbb{Z}_+$ (not $l \in \mathbb{N}$) for the generators of $J^0A$, because $f_r^{(0)} = F_r^{(0)}|_{X_j^{(0)}=0} = F_r(0, \dots, 0) = 0$ by assumption (eq. 3), so the $l=0$ generator is trivial. This is correctly handled: [line 152](../../notes/focused-arc-algebra.tex#L152) uses $l \in \mathbb{Z}_+$ and [line 157](../../notes/focused-arc-algebra.tex#L157) uses $l \in \mathbb{Z}_+$.

### 9. Scheme-Theoretic Weight Grading (Lines 190–233)

This section correctly presents the intrinsic definition of the weight grading via the $k^\times$-action on arc spaces. It matches [BMS Remark 3.2](../../refs/arXiv-1101.4950v2/section_3_ArcsAndRogersRamanujanIdentities.tex#L39-L43).

**One issue:** BMS writes $\lambda \in k^\times$, whereas your notes write "for all extensions $k \to K$ of $k$, $\lambda \in K$" ([line 228](../../notes/focused-arc-algebra.tex#L228)). As your own exposition in [formal_vs_function_rings.md](../expositions/formal_vs_function_rings.md) establishes:

- If $\text{char}(k) = 0$ (which is assumed throughout the jet algebra construction), then $\lambda \in k^\times$ suffices and no extensions are needed.
- Extensions are only needed over finite fields.

The notes' final paragraph ([lines 249–250](../../notes/focused-arc-algebra.tex#L249-L250)) correctly identifies this tension:

> *"it'd be better to write $\lambda \in K$ because $\lambda \in k^\times$ is not enough in general and if they already assume $\text{char}(k) = 0$, then $K$ is not needed at all!"*

> [!IMPORTANT]
> Since the document assumes $\text{char}(k) = 0$ ([line 101](../../notes/focused-arc-algebra.tex#L101)), the definition on [lines 224–228](../../notes/focused-arc-algebra.tex#L224-L228) is **more general than necessary**. Consider either:
> 1. Simplifying to $\lambda \in k^\times$ (since char 0 is assumed), or
> 2. Keeping the general formulation but adding a remark that it simplifies in characteristic zero.

### 10. Conjecture Section (Lines 235–238)

This section is clearly a placeholder ([lines 235–238](../../notes/focused-arc-algebra.tex#L235-L238)):

```latex
CONJECTURE: $A = k[X]/F(X)$, where $F(X) = X^k + a_{k - 1}X^{k - 1} + \dots + a_iX^i$, $i \ge 1$.
\begin{equation*}
  J^0A = \text{identity of Gordon-Ramanujan-Poincare with k, i} 
\end{equation*}
```

> [!WARNING]
> **Variable clash:** The conjecture uses $k$ both as the base field and as the degree of $F(X)$. This should be changed to avoid ambiguity — perhaps use $d$ for the degree:
> $F(X) = X^d + a_{d-1}X^{d-1} + \dots + a_iX^i$.

The intended conjecture appears to be a generalization of [BMS Theorem 5.1](../../refs/arXiv-1101.4950v2/section_5_ArcsAndRogersRamanujanIdentities.tex#L384-L392), which handles $F(X) = X^n$ (where $a_{n-1} = \dots = a_1 = 0$ and $i = n$). For the general case, the "identity of Gordon-Ramanujan-Poincaré" would need to be stated precisely — presumably it involves Gordon's generalization with parameters depending on $d$ and $i$.

### 11. Summary Section (Lines 240–250)

This reads as working notes rather than polished exposition. The numbered list ([lines 245–248](../../notes/focused-arc-algebra.tex#L245-L248)) is accurate and valuable — it clearly summarizes why the functor-of-points approach is needed. However:

- The final sentence ([line 250](../../notes/focused-arc-algebra.tex#L250)) mixes informal commentary with the mathematical content.
- The exclamation mark at the end of [line 249](../../notes/focused-arc-algebra.tex#L249) and informal tone throughout suggest this section hasn't been revised.

---

## Summary of Required Fixes

| # | Severity | Line(s) | Issue |
|:--|:---------|:--------|:------|
| 1 | **Bug** | [36](../../notes/focused-arc-algebra.tex#L36) | `H_A(t)` should be `HP_A(t)` |
| 10 | **Bug** | [235](../../notes/focused-arc-algebra.tex#L235) | Variable clash: `k` used as both field and exponent |
| 2 | Structure | [42–53](../../notes/focused-arc-algebra.tex#L42-L53) | Jet algebra used before defined |
| 9 | Clarity | [224–228](../../notes/focused-arc-algebra.tex#L224-L228) | Overly general definition for char 0 context |
| 10 | Incomplete | [235–238](../../notes/focused-arc-algebra.tex#L235-L238) | Conjecture is a placeholder |
| 11 | Polish | [240–250](../../notes/focused-arc-algebra.tex#L240-L250) | Summary section needs revision |

## What's Working Well

- **Motivation of the derivation** ([lines 103–117](../../notes/focused-arc-algebra.tex#L103-L117)): The explanation of *why* $\partial X_j^{(i)} = (i+1)X_j^{(i+1)}$ is the right definition is clear and rigorous.
- **Two conventions** ([lines 176–188](../../notes/focused-arc-algebra.tex#L176-L188)): Presenting both conventions and their isomorphism is very useful.
- **Focused arc algebra construction** ([lines 55–72](../../notes/focused-arc-algebra.tex#L55-L72), [150–158](../../notes/focused-arc-algebra.tex#L150-L158)): The base-change definition and its explicit coordinate realization are clean and match BMS exactly.
- **Examples** ([lines 160–174](../../notes/focused-arc-algebra.tex#L160-L174)): Both examples are correct and give concrete anchor points.
