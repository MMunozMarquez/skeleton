RmdFiles := $(wildcard *.Rmd)
HtmlFiles := $(patsubst %.Rmd,%.html,$(RmdFiles))

default: $(HtmlFiles)
	echo $(HtmlFiles)
	@echo All updated
%.html: %.Rmd makefile menu.html menu_es.html skeleton.css
	R -e "rmarkdown::render('$<')"
