LATEX=pdflatex
LATEXOPT=--shell-escape
NONSTOP=--interaction=nonstopmode

LATEXMK=latexmk
LATEXMKOPT=-pdf
CONTINUOUS=-pvc

MAIN=hamman_rasm_precip
SUP=hamman_rasm_precip_sup
SOURCES=$(MAIN).tex Makefile
FIGURES=$(shell find figs/* -type f)

all: $(MAIN).pdf

.refresh:
	touch .refresh

$(MAIN).pdf: $(MAIN).tex .refresh $(SOURCES) $(FIGURES)
		$(LATEXMK) $(LATEXMKOPT) $(CONTINUOUS) -pdflatex="$(LATEX) $(LATEXOPT) $(NONSTOP) %O %S" $(MAIN)

$(SUP).pdf: $(SUP).tex .refresh $(SOURCES) $(FIGURES)
		$(LATEXMK) $(LATEXMKOPT) $(CONTINUOUS) -pdflatex="$(LATEX) $(LATEXOPT) $(NONSTOP) %O %S" $(SUP)

force:
		touch .refresh
		rm $(MAIN).pdf
		$(LATEXMK) $(LATEXMKOPT) $(CONTINUOUS) \
		    -pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(MAIN)

clean:
		$(LATEXMK) -C $(MAIN)
		rm -f $(MAIN).pdfsync
		rm -rf *~ *.tmp
		rm -f *.bbl *.blg *.aux *.end *.fls *.log *.out *.fdb_latexmk

once:
		$(LATEXMK) $(LATEXMKOPT) -pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(MAIN)
		$(LATEXMK) $(LATEXMKOPT) -pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(SUP)

sup:
	$(LATEXMK) $(LATEXMKOPT) -pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(SUP)


debug:
		$(LATEX) $(LATEXOPT) $(MAIN)

.PHONY: clean force once all
