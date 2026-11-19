# Rules

* All AI-generated workspace files must be placed in the `scratch/` directory unless explicitly authorized (e.g., a request to fix a typo in a specific file); model artifacts may be used for reports, plans, and reviews.
* Use semantic line breaks for all `.tex` and `.md` files.
* Don't use `git` commands unless explicitly authorized.
* The content of the `refs/` directory is meant to be used as references, not to be edited.
* The content of the `notes/` directory is informal and does not need references, but the math should be correct.
* The content of the `src/` directory is for the main paper, should be formal and needs references.
* Links in workspace `.md` files must use relative paths (e.g., `../notes/file.tex#L42`), not absolute `file:///` URIs (links in model artifacts may use `file:///` URIs).
* The workflow is write → review → correct → commit → write → review → ... (the commit step is strictly manual).
* Use `\operatorname` or `\operatorname*` when defining a function or mathematical operator (e.g., $\operatorname{rank}$, $\operatorname{Tr}$, $\operatorname{diag}$, $\operatorname*{argmin}$, $\operatorname{Var}$).
* Use `\mathrm` for non-operator math symbols, units, and single-word descriptive subscripts/superscripts (e.g., $E_{\mathrm{kin}}$, $\mu_{\mathrm{min}}$, $\mathrm{d}x$, $\mathrm{e}$, $\mathrm{kg}$).
* Use `\textnormal` (not `\text`, which inherits theorem italics) for hyphenated or multi-word text labels in math mode such as category names (e.g., $k\textnormal{-Alg}$, $k\textnormal{-DiffAlg}$).
* Don't use `\DeclareMathOperator` in `.tex` files. It can cause poor model support.