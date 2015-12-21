PDFC=pdflatex
BIBC=bibtex
GREP=grep -Hn

.PHONY: all clean tidy proposal check

all: proposal

clean: tidy
	rm -rf *.pdf

tidy:
	rm -f *.aux
	rm -f *.bbl
	rm -f *.blg
	rm -f *.log
	rm -f *.out

proposal: proposal.pdf

proposal.pdf: proposal.tex fitness.bib
	${PDFC} proposal.tex
	${BIBC} proposal
	${PDFC} proposal.tex
	${PDFC} proposal.tex

check:
	${GREP} CITATION *.tex || true
	${GREP} TODO *.tex || true
	${GREP} FIXME *.tex || true

