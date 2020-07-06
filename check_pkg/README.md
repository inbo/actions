# lint_pkg

This Github action runs `lintr::lint_package()` and fails when it encounters linters in the code.

Add a `.yaml` file like the example below to the `.github/workflows` folder of your project.

```
on: [push]

name: check-linters

jobs:
  check_linters:
    runs-on: ubuntu-latest
    name: Check for linters in the code
    steps:
      - uses: inbo/actions/lint_pkg@master
```
