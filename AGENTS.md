# Rules

The following rules are listed in descending order of priority, from most to least important.

* All the AI generated content must be done on the `scratch/` directory unless explicitly authorized
* Use semantic linefeeds for all `.tex` and `.md` files
* Don't write in `scratch/explanations/`
* Don't use `git` commands unless explicitly authorized
* The content of the `refs/` directory is meant to be used as references, not to be edited
* The content of the `notes/` directory is informal and does not need references, but the math should be correct
* The content of the `src/` directory is for the main paper, should be formal and needs references
* Links in `.md` files must use relative paths (e.g., `../notes/file.tex#L42`), not absolute `file:///` URIs
* You should not edit files outside of `scratch/` unless explicitly authorized
* When writing a review, overwrite the previous review or create a new `.md` file
* After the LLM modifies a `.tex` file, run `pdflatex`
* The workflow is write → commit → review → correct → commit → write → commit → ...