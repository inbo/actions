# check_deploy

This Github action deploys the pkgdown site of an R package to GitHub Pages.
This requires to run `checklist::check_package()` first.

Add a `.yaml` file like the example below to the `.github/workflows` folder of your project.

```
on:
  push:
    branches-ignore:
      - ghpages

name: "check package with checklist"

jobs:
  check-package:
    runs-on: ubuntu-24.04
    name: check-package
    env:
      CODECOV_TOKEN: ${{ secrets.CODECOV_TOKEN }}
      GITHUB_PAT: ${{ secrets.GITHUB_TOKEN }}
      RSPM: "https://packagemanager.rstudio.com/cran/__linux__/noble/latest"
    permissions:
      contents: read
    steps:
      - name: "Check package with checklist"
        uses: inbo/actions/check_pkg@composite
  deploy-pages:
    name: deploy-gh-pages
    runs-on: ubuntu-24.04
    needs: check-package
    if: github.ref == 'refs/heads/main' || github.ref == 'refs/heads/master'
    permissions:
      contents: write
    steps:
      - name: "Tag and deploy gh-pages"
        uses: inbo/actions/check_deploy@composite
```
