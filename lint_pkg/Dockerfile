FROM rocker/verse

RUN  Rscript -e 'install.packages("lintr")'
RUN  Rscript -e 'install.packages("remotes")'

COPY lint_package.sh /lint_package.sh

ENV NOT_CRAN='TRUE'

ENTRYPOINT ["/lint_package.sh"]
