target = TeachingLP
package = TeachingLP_1.0.tar.gz
R_FILES := $(wildcard $(target)/R/*.R)

test_pivotm.out: $(R_FILES) ~/ownCloud.UCA/mmarquez/program/TeachingLP/test_pivotm.R
	clear
	Rscript test_pivotm.R | tee test_pivotm.out
~/R_LIBS/TeachingLP: $(package)
	R CMD INSTALL $(package)
$(package): $(R_FILES)
	R -e "library('roxygen2'); roxygenize('$(target)')"
	R CMD build $(target)
%.tex: %.Rnw
	R CMD Sweave --encoding=utf8 $<
%.pdf: %.tex
	pdflatex --interaction=nonstopmode $<
