FROM islasgeci/base:1.0.0
COPY . /workdir

RUN pip install --upgrade pip && pip install \
    jinja-render

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      wget \ 
      graphviz \ 
      texlive-latex-extra \ 
      lmodern \ 
      perl && \ 
      /rocker_scripts/install_pandoc.sh && \
      install2.r rmarkdown
  
RUN Rscript -e "install.packages('remotes')"
  
RUN Rscript -e "remotes::install_version('lavaan', '0.6.14')"
  
ENV RSTUDIO_PANDOC=/usr/lib/rstudio/bin/pandoc
  
WORKDIR /workdir

RUN Rscript -e "install.packages(c('janitor'), repos='http://cran.rstudio.com')"

RUN make install