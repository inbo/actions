FROM rocker/verse

RUN  Rscript -e 'install.packages("lintr")'
RUN  Rscript -e 'install.packages("remotes")'

COPY lint_pkg/lint_package.sh /lint_package.sh
COPY lint_src/lint_src.sh /lint_src.sh

ENTRYPOINT ["/lint_package.sh"]
