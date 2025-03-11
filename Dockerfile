FROM islasgeci/base:1.0.0
COPY . /workdir

RUN Rscript -e "install.packages(c('janitor'), repos='http://cran.rstudio.com')"