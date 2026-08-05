# render_quarto

Render a quarto document in a repository.

## Minimal `quarto.yml`

Place this content in a `.github/workflows/quarto.yml` file

```yaml
on:
  push:
    branches-ignore:
      - gh-pages

jobs:
  quarto:
    runs-on: ubuntu-24.04
    name: check-package
    env:
      RSPM: "https://packagemanager.posit.co/cran/__linux__/noble/latest"
      QUARTO_SOURCE: "source/report"
      QUARTO_OUTPUT: "output/report"
    permissions:
      contents: read
    steps:
      - name: "Render quarto"
        uses: inbo/actions/quarto_render@main

   publish:
    name: deploy-gh-pages
    runs-on: ubuntu-24.04
    needs: quarto
    if: github.ref == 'refs/heads/main'
    permissions:
      contents: write
    steps:
      - name: "Deploy gh-pages"
        uses: inbo/actions/quarto_publish@main
```

## inputs

- **path**
    - Path which contains the quarto document.
      This path is relative to the root of the repository.
    - default: `"."`
- **output**
    - Path which contains the quarto document.
      This path is relative to the root of the repository.
    - default: `"."`
- **extra_repositories**
    - Additional repositories to use. A space separated list of URLs.
      For example: `"https://inbo.r-universe.dev https://cranhaven.r-universe.dev"`
    - default: `"https://cranhaven.r-universe.dev https://inbo.r-universe.dev"`
- **texlive**
    - Additional TeX Live packages to install.
      A space or newline separated list of package names.
      For example: `"babel-dutch babel-french babel-german"`
      Or as a multiline list:
      ```yaml
      texlive: |
        babel-dutch
        babel-french
        babel-german
      ```
    - default: `""`
- **`cmd`** is optional and defaults to `""`.
  When non-empty, the commands are run in a bash shell before installing R dependencies.
  The action tries to install all packages used in the quarto document.
  This will fail in case you use packages which are not available in any of the CRAN like repositories.
  In case installing the dependencies fails, install them via this `cmd` input.
  E.g. `Rscript -e 'pak::pkg_install("jeroen/sodium")'` to install the `sodium` package from `https://github.com/jeroen`.
  Or `sudo apt-get install -y libsodium-dev` to install a missing Linux library.

## Full example of `quarto.yml`

This full, minimal example prepares the quarto machinery and renders the quarto document.
When running on the `main` branch, it will update the `gh-pages` branch with the latest output.

```yaml
on:
  push:
    branches-ignore:
      - gh-pages

jobs:
  quarto:
    runs-on: ubuntu-24.04
    name: check-package
    env:
      RSPM: "https://packagemanager.posit.co/cran/__linux__/noble/latest"
      QUARTO_SOURCE: "source/report"
      QUARTO_OUTPUT: "output/report"
    permissions:
      contents: read
    steps:
      - name: "Render quarto"
        uses: inbo/actions/quarto_render@main
        with:
          path: "source/report"
          output: "output/report"
          texlive: |
            babel-dutch
            babel-french
            babel-german
          extra_repositories: |
            https://cranhaven.r-universe.dev
            https://inbo.r-universe.dev
          cmd: |
            sudo apt-get install -y libsodium-dev
            Rscript -e 'pak::pkg_install("jeroen/sodium")'

  publish:
    name: deploy-gh-pages
    runs-on: ubuntu-24.04
    needs: quarto
    if: github.ref == 'refs/heads/main'
    permissions:
      contents: write
    steps:
      - name: "Deploy gh-pages"
        uses: inbo/actions/quarto_publish@main
```
