# check_project

This GitHub action runs `checklist::check_project()` and fails when it encounters problems in the code.

## Usage

Add a `checklist_projec.yaml` file like the minimal example below to the `.github/workflows` folder of your project.

```yaml
on:
  push:
    branches-ignore:
      - gh-pages

name: check-project

jobs:
  check-src:
    runs-on: ubuntu-24.04
    name: "Check project with checklist"
    env:
      GITHUB_PAT: ${{ secrets.GITHUB_TOKEN }}
      GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      RSPM: "https://packagemanager.posit.co/cran/__linux__/noble/latest"

    permissions:
      contents: read

    steps:
      - name: "Check project with checklist"
        uses: inbo/actions/check_project@main
```

## Notes

- **`RSPM`** must be set in the calling workflow, not in this action, because the correct URL depends on the Ubuntu version the workflow runs on.
  Use the matching Posit Package Manager URL for your runner:
  - `ubuntu-24.04` → `https://packagemanager.posit.co/cran/__linux__/noble/latest`
  - `ubuntu-22.04` → `https://packagemanager.posit.co/cran/__linux__/jammy/latest`
- **`path`** is optional and defaults to `"."`.
- **`extra_repositories`** is optional and defaults to `"https://cranhaven.r-universe.dev https://inbo.r-universe.dev"`.
- **`cmd`** is optional and defaults to `""`.
  When non-empty, the commands are run in a bash shell before the project check.
  The action try to install all packages used in the project.
  This will fail in case you use packages which are not available in any of the CRAN like repositories.
  In case installing the dependencies fails, install them via this `cmd` input.
  E.g. `Rscript -e 'pak::pkg_install("jeroen/sodium")'` to install the `sodium` package from `https://github.com/jeroen`.
  Or `sudo apt-get install -y libsodium-dev` to install a missing Linux library.

## `checklist_project.yaml` with options set.

```yaml
on:
  push:
    branches-ignore:
      - gh-pages

name: check-project

jobs:
  check-src:
    runs-on: ubuntu-24.04
    name: "Check project with checklist"
    env:
      GITHUB_PAT: ${{ secrets.GITHUB_TOKEN }}
      GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      RSPM: "https://packagemanager.posit.co/cran/__linux__/noble/latest"

    permissions:
      contents: read

    steps:
      - name: "Check project with checklist"
        uses: inbo/actions/check_project@main
        with:
          path: "."
          extra_repositories: "https://cranhaven.r-universe.dev https://inbo.r-universe.dev"
          cmd: |
            sudo apt-get install -y libsodium-dev
            Rscript -e 'pak::pkg_install("jeroen/sodium")'
```
