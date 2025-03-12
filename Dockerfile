FROM islasgeci/base:1.0.0
COPY . /workdir

RUN pip install --upgrade pip && pip install \
    jinja-render


RUN Rscript -e "install.packages(c('janitor'), repos='http://cran.rstudio.com')"

RUN make install