# check_deploy

This Github action deploys the pkgdown site of an R package to GitHub Pages.
This requires to run `checklist::check_package()` first.

Add a `checklist_pkg.yml` file like the examples below to the `.github/workflows` folder of your project.

## Minimal `checklist_pkg.yml`

```yaml
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
      RSPM: "https://packagemanager.posit.co/cran/__linux__/noble/latest"
    permissions:
      contents: read
    steps:
      - name: "Check package with checklist"
        uses: inbo/actions/check_pkg@main
  deploy-pages:
    name: deploy-gh-pages
    runs-on: ubuntu-24.04
    needs: check-package
    if: github.ref == 'refs/heads/main'
    permissions:
      contents: write
    steps:
      - name: "Tag and deploy gh-pages"
        uses: inbo/actions/check_deploy@main
```

## Notes

- **`RSPM`** must be set in the calling workflow, not in this action, because the correct URL depends on the Ubuntu version the workflow runs on.
  Use the matching Posit Package Manager URL for your runner:
  - `ubuntu-24.04` → `https://packagemanager.posit.co/cran/__linux__/noble/latest`
  - `ubuntu-22.04` → `https://packagemanager.posit.co/cran/__linux__/jammy/latest`
- **`path`** is optional and defaults to `"."`.
  Note that you need to set `path` to the same value in both steps.
  Therefor we recommend to use a single environment variablen `PKG_PATH` as in the example below.
- **`extra_repositories`** is optional and defaults to `"https://cranhaven.r-universe.dev https://inbo.r-universe.dev"`.
- **`cmd`** is optional and defaults to `""`.
  When non-empty, the commands are run in a bash shell before the package check.
  The action uses `pak::local_install_dev_deps()` and `pak::local_install(dependencies = TRUE, upgrade = TRUE, ask = FALSE)` to install dependencies.
  In case installing the dependencies fails, install them via this `cmd` input.
  E.g. `Rscript -e 'pak::pkg_install("jeroen/sodium")'` to install the `sodium` package from `https://github.com/jeroen`.
  Or `sudo apt-get install -y libsodium-dev` to install a missing Linux library.

## `checklist_pkg.yml` with options set.

```yaml
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
      RSPM: "https://packagemanager.posit.co/cran/__linux__/noble/latest"
      PKG_PATH: "."
    permissions:
      contents: read
    steps:
      - name: "Check package with checklist"
        uses: inbo/actions/check_pkg@main
        with:
          path: ${{ env.PKG_PATH }}
          extra_repositories: |
            https://cranhaven.r-universe.dev
            https://inbo.r-universe.dev
          cmd: |
            sudo apt-get install -y libsodium-dev
            Rscript -e 'pak::pkg_install("jeroen/sodium")'
  deploy-pages:
    name: deploy-gh-pages
    runs-on: ubuntu-24.04
    needs: check-package
    if: github.ref == 'refs/heads/main'
    permissions:
      contents: write
    steps:
      - name: "Tag and deploy gh-pages"
        uses: inbo/actions/check_deploy@main
        with:
          path: ${{ env.PKG_PATH }}
```
