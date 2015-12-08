PDF := tilelvreqs_argonne.pdf
BIB := tilelvreqs.bib

.PHONY: all clean

all: $(PDF)

$(PDF): %.pdf: %.tex $(BIB)
	@pdflatex -interaction=batchmode $* && \
	bibtex -terse $* && \
	pdflatex -interaction=batchmode $* && \
	pdflatex -interaction=batchmode $* || \
	echo "\033[0;31mCompilation failed\033[0m"
	@awk '/ Warning:/{a=1}/^$$/{a=0}a' $*.log | sed "s/.*Warning.*/\x1b[33m&\x1b[0m/"
	@awk '/^!/{a=1}/^l\./{print;a=0}a' $*.log | sed "s/^!.*/\x1b[31m&\x1b[0m/"

clean:
	@rm -fv *.aux *.toc *.out *.log *.nav *.snm \
		*.bbl *.blg *-blx.bib *.run.xml $(PDF)
