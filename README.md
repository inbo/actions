# actions

A set of GitHub actions

- `check_pkg`: a strict and rigorous check of an R package.
  Based on [`checklist::check_package()`](https://inbo.github.io/checklist/reference/check_package.html).
- `check_project`: a strict and rigorous check of a project with R, R markdown and Sweave files.
  Based on [`checklist::check_project()`](https://inbo.github.io/checklist/reference/check_project.html).
- `lint_pkg`: check the coding style of an R package using `lintr::lint_package()`.
- `lint_src`: check the coding style of R scripts, Rmarkdown files or Sweave files using `lintr::lint_dir()`.
- `pkgdown_covr`: check code coverage, build a pkgdown website and deploy it to a gh-pages branch.
- `protocol_check`: check the protocol in [inbo/protocolsource](https://github.com/inbo/protocolsource) and update the version number if needed.
  Not relevant for other purposes.
- `protocol_update`: add the new protocol to `.zenodo.json` and the general `NEWS.md` in [inbo/protocolsource](https://github.com/inbo/protocolsource).
  Not relevant for other purposes.
- `protocol_website`: render protocol and add website to inbo/protocols.
  Not relevant for other purposes.
- `render_inbomd`: render the INBOmd examples.
  Not relevant for other purposes.
- `render_indicator`: render the INBO indicators.
  Not relevant for other purposes.
- `render_nara`: render the NARA background documents.
  Not relevant for other purposes.
