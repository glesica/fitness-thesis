PDFC=pdflatex

.PHONY: all clean proposal

all: proposal

clean:
	rm -f *.aux *.log

proposal:
	pdflatex proposal.tex
	bibtex proposal
	pdflatex proposal.tex
	pdflatex proposal.tex

