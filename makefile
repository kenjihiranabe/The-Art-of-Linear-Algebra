ART=The-Art-of-Linear-Algebra
ILLUST=Illustrations
WORLD=MatrixWorld
MAP=MapofEigenvalues
#PSSELECT=psselect -p
PSSELECT=psselect
PS2EPS=ps2eps -B -l -f -R=-

# two product target files
all: $(ART).pdf $(ART)-j.pdf

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
	SVD.ps\
	$(MAP).ps\
	$(WORLD).ps


PSJ=$(PS:%.ps=%-j.ps)

%.ps: %.pptx
	@echo "*** .pptx is new !! Print out $< to PostScript(.ps, without version name), then make again ***"

# split illlustration.ps file into pages and name them
ViewingMatrix-4Ways.ps: $(ILLUST).ps
	$(PSSELECT) 2 $< $@
ViewingMatrix-4Ways-j.ps: $(ILLUST)-j.ps
	$(PSSELECT) 2 $< $@
#
VectorTimesVector.ps: $(ILLUST).ps
	$(PSSELECT) 3 $< $@
VectorTimesVector-j.ps: $(ILLUST)-j.ps
	$(PSSELECT) 3 $< $@
#
MatrixTimesVector.ps: $(ILLUST).ps
	$(PSSELECT) 4 $< $@
#
MatrixTimesVector-j.ps: $(ILLUST)-j.ps
	$(PSSELECT) 4 $< $@
#
VectorTimesMatrix.ps: $(ILLUST).ps
	$(PSSELECT) 5 $< $@
VectorTimesMatrix-j.ps: $(ILLUST)-j.ps
	$(PSSELECT) 5 $< $@
#
4-Subspaces.ps: $(ILLUST).ps
	$(PSSELECT) 6 $< $@
4-Subspaces-j.ps: $(ILLUST)-j.ps
	$(PSSELECT) 6 $< $@
#
MatrixTimesMatrix.ps: $(ILLUST).ps
	$(PSSELECT) 7 $< $@
MatrixTimesMatrix-j.ps: $(ILLUST)-j.ps
	$(PSSELECT) 7 $< $@
#
Pattern12.ps: $(ILLUST).ps
	$(PSSELECT) 8 $< $@
Pattern12-j.ps: $(ILLUST)-j.ps
	$(PSSELECT) 8 $< $@
#
Pattern11-22.ps: $(ILLUST).ps
	$(PSSELECT) 9 $< $@
Pattern11-22-j.ps: $(ILLUST)-j.ps
	$(PSSELECT) 9 $< $@
#
Pattern3.ps: $(ILLUST).ps
	$(PSSELECT) 10 $< $@
Pattern3-j.ps: $(ILLUST)-j.ps
	$(PSSELECT) 10 $< $@
#
Pattern4.ps: $(ILLUST).ps
	$(PSSELECT) 11 $< $@
Pattern4-j.ps: $(ILLUST)-j.ps
	$(PSSELECT) 11 $< $@
#
5-Factorizations.ps: $(ILLUST).ps
	$(PSSELECT) 12 $< $@
5-Factorizations-j.ps: $(ILLUST)-j.ps
	$(PSSELECT) 12 $< $@
#
CR1.ps: $(ILLUST).ps
	$(PSSELECT) 13 $< $@
CR1-j.ps: $(ILLUST)-j.ps
	$(PSSELECT) 13 $< $@
#
CR2.ps: $(ILLUST).ps
	$(PSSELECT) 14 $< $@
CR2-j.ps: $(ILLUST)-j.ps
	$(PSSELECT) 14 $< $@
#
LU1.ps: $(ILLUST).ps
	$(PSSELECT) 15 $< $@
LU1-j.ps: $(ILLUST)-j.ps
	$(PSSELECT) 15 $< $@
#
LU2.ps: $(ILLUST).ps
	$(PSSELECT) 16 $< $@
LU2-j.ps: $(ILLUST)-j.ps
	$(PSSELECT) 16 $< $@
#
QR.ps: $(ILLUST).ps
	$(PSSELECT) 17 $< $@
QR-j.ps: $(ILLUST)-j.ps
	$(PSSELECT) 17 $< $@
#
EVD.ps: $(ILLUST).ps
	$(PSSELECT) 18 $< $@
EVD-j.ps: $(ILLUST)-j.ps
	$(PSSELECT) 18 $< $@
#
SVD.ps: $(ILLUST).ps
	$(PSSELECT) 19 $< $@
SVD-j.ps: $(ILLUST)-j.ps
	$(PSSELECT) 19 $< $@
#
$(WORLD).ps: $(ILLUST).ps
	$(PSSELECT) 20 $< $@
$(WORLD)-j.ps: $(ILLUST)-j.ps
	$(PSSELECT) 20 $< $@
#
$(MAP).ps: $(ILLUST).ps
	$(PSSELECT) 21 $< $@
$(MAP)-j.ps: $(ILLUST)-j.ps
	$(PSSELECT) 21 $< $@


EPS=$(PS:.ps=.eps)
EPSJ=$(PSJ:-j.ps=-j.eps)

%.pdf: out/%.dvi
	dvipdfmx -p a4 -q $<

out/$(ART).dvi: $(ART).tex $(EPS)
	uplatex -synctex=1 -halt-on-error -file-line-error -output-directory=out $(ART).tex

out/$(ART)-j.dvi: $(ART)-j.tex $(EPSJ)
	uplatex -synctex=1 -halt-on-error -file-line-error -output-directory=out $(ART)-j.tex

# uplatex -synctex=1 -halt-on-error -silent -file-line-error -output-directory=out $<
# see https://qiita.com/rainbartown/items/d7718f12d71e688f3573#comment-7c2f42254e84b43d3175

eps: $(EPS)
epsj: $(EPSJ)

%.eps: %.ps
	$(PS2EPS) $<

clean:
	rm -f *.dvi *.out *.log *.fls *.aux *.toc *.synctex.gz *.fdb_latexmk out/*

# just for testing and debugging
echo:
	@echo "eps = $(EPS)"
	@echo "epsj = $(EPSJ)"
