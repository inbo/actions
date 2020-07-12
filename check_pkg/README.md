# check_pkg

This Github action runs `checklist::check_package()` and fails when it encounters linters in the code.

Add a `.yaml` file like the example below to the `.github/workflows` folder of your project.

```
on: [push]

name: check-pkg

jobs:
  check_package:
    runs-on: ubuntu-latest
    name: Check package
    steps:
      - uses: inbo/actions/check_pkg@master
        with:
          - path: my_path
```
