# check_project

This GitHub action runs `checklist::check_project()` and fails when it encounters problems in the code.

## Usage

Add a `.yaml` file like the minimal example below to the `.github/workflows` folder of your project.

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
- **`apt`** is optional and defaults to an empty string.
  It allows you to specify additional system packages to install, separated by spaces.
  These packages will be passed to `apt-get install` during the workflow.

Your code might depend on a package which is not available on CRAN or in one of the `extra_repositories`.
In that case, you have two options.
- Use [`checklist::checklist$set_pak()`](https://inbo.github.io/checklist/reference/checklist.html#method-checklist-set_pak) to add the dependencies to the `checklist.yml`.
- Use `renv` to manage your project's dependencies and include a `renv.lock` file in your repository.
