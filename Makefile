PDFC=pdflatex
BIBC=bibtex
GREP=grep -Hn

.PHONY: all clean proposal check

all: proposal

clean:
	rm -f *.aux *.log

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

