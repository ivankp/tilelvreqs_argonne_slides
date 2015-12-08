.PHONY: all clean

PDF := tilelvreqs_argonne.pdf

all: $(PDF)

$(PDF): %.pdf: %.tex
	@pdflatex -interaction=batchmode $* && \
	bibtex -terse $* && \
	sleep 0.1 && \
	pdflatex -interaction=batchmode $* && \
	pdflatex -interaction=batchmode $* || \
	echo -e "\033[0;31mCompilation failed\033[0m"
	@awk '/Warning/{a=1}/^$$/{a=0}a' $*.log | sed "s/.*Warning.*/\x1b[33m&\x1b[0m/"
	@awk '/^!/{a=1}/}$$/{print;a=0}a' $*.log | sed "s/^!.*/\x1b[31m&\x1b[0m/"

clean:
	@rm -fv *.aux *.toc *.out *.log *.nav *.snm *.bbl *.blg $(PDF)
