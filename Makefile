all: check coverage

.PHONY: \
    check \
    clean \
    coverage \
    format \
    init \
    install \
    setup \
    tests

define checkDirectories
	mkdir --parents $(@D)
endef

define renderLatex
	cd $(<D) && pdflatex $(<F)
	cd $(<D) && pdflatex $(<F)
endef

reports/duty.pdf: reports/duty.tex reports/tables/changed_percentaje.csv
	$(renderLatex)

reports/duty.tex: reports/non-tabular/results.json reports/templates/duty.tex
	jinja-render \
	--report-name "duty" \
	--summary-path "reports/non-tabular/results.json"

reports/non-tabular/results.json:
	$(checkDirectories)
	echo '{"rise_fbkf":10, "neto_fbkf":7174, "rise_neto_agriculture": 7804, "rise_agriculture": 0.63, "out_agriculture": 1240506, "changed_out_agriculture": 1248310, "rise_neto_all_industries": 10150}' > reports/non-tabular/results.json

reports/tables/changed_percentaje.csv: src/ejemplo_del_marioamor.R
	$(checkDirectories)
	Rscript --vanilla src/ejemplo_del_marioamor.R

check:
	R -e "library(styler)" \
      -e "resumen <- style_dir('R')" \
      -e "resumen <- style_dir('src')" \
      -e "resumen <- rbind(resumen, style_dir('tests'))" \
      -e "resumen <- rbind(resumen, style_dir('tests/testthat'))" \
      -e "any(resumen[[2]])" \
      | grep FALSE

clean:
	rm --force *.tar.gz
	rm --force --recursive tests/testthat/_snaps
	rm --force NAMESPACE

coverage: setup tests
	Rscript tests/testthat/coverage.R

format:
	R -e "library(styler)" \
      -e "style_dir('R')" \
      -e "style_dir('src')" \
      -e "style_dir('tests')" \
      -e "style_dir('tests/testthat')"

init: setup tests

setup: clean install

install:
	R -e "devtools::document()" && \
    R CMD build . && \
    R CMD check mip_0.0.1.tar.gz && \
    R CMD INSTALL mip_0.0.1.tar.gz

tests:
	Rscript -e "devtools::test(stop_on_failure = TRUE)"
