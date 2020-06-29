#!/bin/sh -l

echo 'repository:' $1
echo 'ref:' $2
echo 'path:' $4

echo '\nGetting the code...\n'
git clone --quiet https://$3@github.com/$1 lint
cd lint
git checkout --quiet $2
cd $4
echo '\nInstalling the package...\n'
Rscript -e 'remotes::install_local(quiet = TRUE)'
echo '\nChecking linters in package...\n'
Rscript --no-save --no-restore -e 'lintr::lint_package()' > ../output.Rout
if [ -s ../output.Rout ] ; then
  cat ../output.Rout;
  echo '\nPlease check the coding style\n';
  exit 1
else
  echo '\nYour code is lint free. Good job!\n';
fi
