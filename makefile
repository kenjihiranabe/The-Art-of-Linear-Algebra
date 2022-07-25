TITLE=The-Art-of-Linear-Algebra
ILLUST=Illustrations

all: $(TITLE).pdf

PS=ViewingMatrix-4Ways.ps\
	VectorTimesVector.ps\
	MatrixTimesVector.ps\
	VectorTimesMatrix.ps\
	4-Subspaces.ps\
	MatrixTimesMatrix.ps\
	5-Factorizations.ps\
	CR1.ps\
	CR2.ps\
	LU1.ps\
	LU2.ps\
	Pattern11-22.ps\
	Pattern12.ps\
	Pattern3.ps\
	Pattern4.ps\
	QR.ps\
	EVD.ps\
	SVD.ps

$(ILLUST).ps: $(ILLUST).pptx
	@echo "*** Print out $< to PostScript(.ps), then make again ***"


ViewingMatrix-4Ways.ps: $(ILLUST).ps
	psselect -p 2 $< $@
VectorTimesVector.ps: $(ILLUST).ps
	psselect -p 3 $< $@
MatrixTimesVector.ps: $(ILLUST).ps
	psselect -p 4 $< $@
VectorTimesMatrix.ps: $(ILLUST).ps
	psselect -p 5 $< $@
4-Subspaces.ps: $(ILLUST).ps
	psselect -p 6 $< $@
MatrixTimesMatrix.ps: $(ILLUST).ps
	psselect -p 7 $< $@
Pattern11-22.ps: $(ILLUST).ps
	psselect -p 8 $< $@
Pattern12.ps: $(ILLUST).ps
	psselect -p 9 $< $@
Pattern3.ps: $(ILLUST).ps
	psselect -p 10 $< $@
Pattern4.ps: $(ILLUST).ps
	psselect -p 11 $< $@
5-Factorizations.ps: $(ILLUST).ps
	psselect -p 12 $< $@
CR1.ps: $(ILLUST).ps
	psselect -p 13 $< $@
CR2.ps: $(ILLUST).ps
	psselect -p 14 $< $@
LU1.ps: $(ILLUST).ps
	psselect -p 15 $< $@
LU2.ps: $(ILLUST).ps
	psselect -p 16 $< $@
QR.ps: $(ILLUST).ps
	psselect -p 17 $< $@
EVD.ps: $(ILLUST).ps
	psselect -p 18 $< $@
SVD.ps: $(ILLUST).ps
	psselect -p 19 $< $@

EPS=$(PS:.ps=.eps)

%.pdf: out/%.dvi
	dvipdfmx -p a4 -q $<

echo:
	@echo "eps = $(EPS)"

out/%.dvi: %.tex $(EPS)
	uplatex -synctex=1 -halt-on-error -silent -file-line-error -output-directory=out $<

$(EPS): $(PS)

%.eps: %.ps
	ps2eps -B -l -f $<

clean:
	rm -f *.dvi $(PS) *.out *.log *.fls *.aux *.toc *.synctex.gz *.fdb_latexmk
