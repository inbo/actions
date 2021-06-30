FROM rocker/verse

RUN  Rscript -e 'install.packages("remotes")'
RUN  Rscript -e 'remotes::install_cran("lintr")'
RUN  Rscript -e 'remotes::install_cran("covr")'
RUN  Rscript -e 'remotes::install_github("r-lib/pkgdown")'

COPY lint_pkg/lint_package.sh /lint_package.sh
COPY lint_src/lint_src.sh /lint_src.sh
COPY pkgdown_covr/pkgdown.sh /pkgdown.sh

ENTRYPOINT ["/lint_package.sh"]
