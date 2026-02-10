# render_quarto

Render a quarto document in a repository.

## inputs

- **path**
    - Path which contains the quarto document.
      This path is relative to the root of the repository.
    - default: `"."`
- **output**
    - Path which contains the quarto document.
      This path is relative to the root of the repository.
    - default: `"."`

## Full example

This full, minimal example prepares the quarto machinery and renders the quarto document.
When running on the `main` branch, it will update the `gh-pages` branch with the latest output.

Note that you need to update `QUARTO_SOURCE` and `QUARTO_OUTPUT` in the yaml below.
`QUARTO_SOURCE` is the folder with the root of your quarto document.
`QUARTO_OUTPUT` is the folder that contains the rendered document.

```
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
      - name: "Prepare quarto"
        uses: inbo/actions/quarto_prepare@composite
        with:
          path: ${{ env.QUARTO_SOURCE }}
      - name: "Render quarto"
        uses: inbo/actions/quarto_render@composite
        with:
          path: ${{ env.QUARTO_SOURCE }}
          output: ${{ env.QUARTO_OUTPUT }}

   publish:
    name: deploy-gh-pages
    runs-on: ubuntu-24.04
    needs: quarto
    if: github.ref == 'refs/heads/main'
    permissions:
      contents: write
    steps:
      - name: "Deploy gh-pages"
        uses: inbo/actions/quarto_publish@composite
```
