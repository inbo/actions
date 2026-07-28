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
      RSPM: "https://packagemanager.posit.co/cran/__linux__/noble/latest"
    permissions:
      contents: read
    steps:
      - name: "Check package with checklist"
        uses: inbo/actions/check_pkg@main
        with:
          path: "."
          extra_repositories: "https://cranhaven.r-universe.dev https://inbo.r-universe.dev"
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
          path: "."
```

## Notes

- **`RSPM`** must be set in the calling workflow, not in this action, because the correct URL depends on the Ubuntu version the workflow runs on.
  Use the matching Posit Package Manager URL for your runner:
  - `ubuntu-24.04` → `https://packagemanager.posit.co/cran/__linux__/noble/latest`
  - `ubuntu-22.04` → `https://packagemanager.posit.co/cran/__linux__/jammy/latest`
- **`path`** is optional and defaults to `"."`.
- **`extra_repositories`** is optional and defaults to `"https://cranhaven.r-universe.dev https://inbo.r-universe.dev"`.

Your code might depend on a package which is not available on CRAN or in one of the `extra_repositories`.
In that case, you have two options.
- Use [`checklist::checklist$set_pak()`](https://inbo.github.io/checklist/reference/checklist.html#method-checklist-set_pak) to add the dependencies to the `checklist.yml`.
- Use `renv` to manage your project's dependencies and include a `renv.lock` file in your repository.
