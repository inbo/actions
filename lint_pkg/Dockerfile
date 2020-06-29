FROM rocker/verse

RUN  Rscript -e 'install.packages("lintr")'
RUN  Rscript -e 'install.packages("remotes")'

COPY lint_package.sh /lint_package.sh

ENTRYPOINT ["/lint_package.sh"]
