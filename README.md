# Hilbert Series and Rogers-Ramanujan Identities

## Project Overview
One of the most important results of [BMS](#references) is the demonstration of the connection between the Hilbert series of the fat point $X^n = 0$ for $n = 1, 2, \dots$ to the Rogers-Ramanujan series.
In short, we have

$$
\mathrm{HP}_{J^0_{X^n}}(t) = \prod_{i = 1, i \not\equiv 0, n, n + 1 \bmod 2n + 1}^\infty\frac{1}{1 - t^i}.
$$

This identity depends only on a single parameter $n = 1, 2, \dots$, yet the full generalization by Andrews-Gordon of the Rogers-Ramanujan identity depends on two parameters $n = 1, 2, \dots, s = 1, \dots, n$.

$$
\sum_{k = (k_1, \dots, k_{n - 1}) \in \mathbb{N}^{n - 1}}t^{kB^{(n)}_{n - 1}}\frac{t^{\frac{1}{2}kG^{(n)}k^T + kB^{(n)}_{n - s}}}{(t)_{k_1}\dots(t)_{k_{n - 1}}} = \left(\prod^{\infty}_{i = 1, i \not\equiv 0, \pm s \mod 2n + 1}\frac{1}{1 - t^i}\right).
$$

In other words, we have only used the generalization for $n = 1, 2, \dots$ and $s = n$.
Our main goal is to 'complete' the results of [BMS](#references) by using the remaining identities.

This probably involves understanding [BMS](#references) while generalizing some results to modules.
Maybe something related to the jet module of algebras $JM = JR \otimes_R M$, where $M$ is an $R$-module, or something related to curves in two variables $X, Y$.
I will probably need to use the theory of Gröbner bases for modules, as it seems to be the main tool in [BMS](#references).
It is good to verify all results in [BMS](#references) first, using SageMath or Mathematica, before attempting to generalize them.
Then I will try to do educated guesses for the missing parts of the results.

## Directory Structure

```
hilbert-series/
├── .git/                    # Git repository
├── .vscode/                 # VS Code settings
├── docs/                    # Research documents
├── misc/                    # Miscellaneous files
├── notes/                   # .tex math notes to write down definitions, proofs, ideas, conjectures, etc.
├── refs/                    # .tex math papers used as references
├── scratch/                 # AI-generated content & prompt logs
│   ├── explanations/        # Explanations curated by me
│   └── reviews/             # Reviews of the project, notes/ and src/ files
├── src/                     # main paper LaTeX files
│   ├── bibliography.bib     # BibTeX references
│   └── main.tex             # Main paper
├── tests/                   # SageMath / Mathematica experiments
├── .gitignore               # Ignores all LaTeX auxiliary files and some folders
├── AGENTS.md                # Instructions/notation conventions for LLMs
├── LICENSE.md               # Licensing for your text and code
└── README.md                # Project overview and goals
```

## Goals

1. Fully understand the results in [BMS](#references)
2. Verify all results in [BMS](#references) using SageMath or Mathematica
3. Try to generalize some results to modules like jet modules or Gröbner bases for modules, or in other directions like curves in two variables $X, Y$
4. Try to do educated guesses for the missing parts of the results
5. Prove these generalized results
6. Write a paper about these generalized results
7. Try to publish the paper

## References

1. **[BMS]** Bruschek, C., Mourtada, H., & Schepers, J. (2013). *Arc spaces and Rogers-Ramanujan identities*. Discrete Mathematics, 313(17), 1743-1759. [arXiv:1101.4950 [math.AG]](https://arxiv.org/abs/1101.4950)

