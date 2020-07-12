# check_src

This Github action runs `checklist::check_source()` and fails when it encounters problems in the code.

Add a `.yaml` file like the example below to the `.github/workflows` folder of your project.

```
on: [push]

name: check-source

jobs:
  check_src:
    runs-on: ubuntu-latest
    name: "Check coding style"
    steps:
      - uses: inbo/actions/check_src@master
        with:
          path: my_path
```
