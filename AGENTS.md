# Rules

* All the AI generated content must be done on the `scratch/` directory unless explicitly authorized (e.g., a request to fix a typo in a specific file).
* Use semantic line breaks for all `.tex` and `.md` files.
* Don't use `git` commands unless explicitly authorized.
* The content of the `refs/` directory is meant to be used as references, not to be edited.
* The content of the `notes/` directory is informal and does not need references, but the math should be correct.
* The content of the `src/` directory is for the main paper, should be formal and needs references.
* Links in `.md` files must use relative paths (e.g., `../notes/file.tex#L42`), not absolute `file:///` URIs.
* The workflow is write → review → correct → commit → write → review → ... (the commit step is strictly manual).
* Use `\operatorname` or `\operatorname*` when defining a function or mathematical operator (e.g., $\operatorname{rank}$, $\operatorname{Tr}$, $\operatorname{diag}$, $\operatorname*{argmin}$, $\operatorname{Var}$).
* Use `\mathrm` for labels, descriptive subscripts, units, and non-operator symbols (e.g., $E_{\mathrm{kin}}$, $\mathrm{d}x$, $\mathrm{e}$, $\mathrm{kg}$).
* Don't use `\DeclareMathOperator` in `.tex` files. It can cause poor model support.