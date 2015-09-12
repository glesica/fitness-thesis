PDFC=pdflatex

.PHONY: all clean proposal

all: proposal

clean:
	rm -f *.aux *.log

proposal: proposal.pdf

proposal.pdf: proposal.tex fitness.bib
	pdflatex proposal.tex
	bibtex proposal
	pdflatex proposal.tex
	pdflatex proposal.tex

