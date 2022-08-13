ART=The-Art-of-Linear-Algebra
ILLUST=Illustrations
WORLD=MatrixWorld
MAP=MapofEigenvalues

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

#$(ILLUST).ps: $(ILLUST).pptx
#$(WORLD).ps: $(WORLD)-v1.4.2.pptx
#	@echo "*** Print out $< to PostScript(.ps, without version name), then make again ***"
#$(MAP).ps: $(MAP)-v1.1.pptx
#	@echo "*** Print out $< to PostScript(.ps, without version name), then make again ***"

ViewingMatrix-4Ways.ps: $(ILLUST).ps
	psselect -p 2 $< $@
ViewingMatrix-4Ways-j.ps: $(ILLUST)-j.ps
	psselect -p 2 $< $@
#
VectorTimesVector.ps: $(ILLUST).ps
	psselect -p 3 $< $@
VectorTimesVector-j.ps: $(ILLUST)-j.ps
	psselect -p 3 $< $@
#
MatrixTimesVector.ps: $(ILLUST).ps
	psselect -p 4 $< $@
#
MatrixTimesVector-j.ps: $(ILLUST)-j.ps
	psselect -p 4 $< $@
#
VectorTimesMatrix.ps: $(ILLUST).ps
	psselect -p 5 $< $@
VectorTimesMatrix-j.ps: $(ILLUST)-j.ps
	psselect -p 5 $< $@
#
4-Subspaces.ps: $(ILLUST).ps
	psselect -p 6 $< $@
4-Subspaces-j.ps: $(ILLUST)-j.ps
	psselect -p 6 $< $@
#
MatrixTimesMatrix.ps: $(ILLUST).ps
	psselect -p 7 $< $@
MatrixTimesMatrix-j.ps: $(ILLUST)-j.ps
	psselect -p 7 $< $@
#
Pattern12.ps: $(ILLUST).ps
	psselect -p 8 $< $@
Pattern12-j.ps: $(ILLUST)-j.ps
	psselect -p 8 $< $@
#
Pattern11-22.ps: $(ILLUST).ps
	psselect -p 9 $< $@
Pattern11-22-j.ps: $(ILLUST)-j.ps
	psselect -p 9 $< $@
#
Pattern3.ps: $(ILLUST).ps
	psselect -p 10 $< $@
Pattern3-j.ps: $(ILLUST)-j.ps
	psselect -p 10 $< $@
#
Pattern4.ps: $(ILLUST).ps
	psselect -p 11 $< $@
Pattern4-j.ps: $(ILLUST)-j.ps
	psselect -p 11 $< $@
#
5-Factorizations.ps: $(ILLUST).ps
	psselect -p 12 $< $@
5-Factorizations-j.ps: $(ILLUST)-j.ps
	psselect -p 12 $< $@
#
CR1.ps: $(ILLUST).ps
	psselect -p 13 $< $@
CR1-j.ps: $(ILLUST)-j.ps
	psselect -p 13 $< $@
#
CR2.ps: $(ILLUST).ps
	psselect -p 14 $< $@
CR2-j.ps: $(ILLUST)-j.ps
	psselect -p 14 $< $@
#
LU1.ps: $(ILLUST).ps
	psselect -p 15 $< $@
LU1-j.ps: $(ILLUST)-j.ps
	psselect -p 15 $< $@
#
LU2.ps: $(ILLUST).ps
	psselect -p 16 $< $@
LU2-j.ps: $(ILLUST)-j.ps
	psselect -p 16 $< $@
#
QR.ps: $(ILLUST).ps
	psselect -p 17 $< $@
QR-j.ps: $(ILLUST)-j.ps
	psselect -p 17 $< $@
#
EVD.ps: $(ILLUST).ps
	psselect -p 18 $< $@
EVD-j.ps: $(ILLUST)-j.ps
	psselect -p 18 $< $@
#
SVD.ps: $(ILLUST).ps
	psselect -p 19 $< $@
SVD-j.ps: $(ILLUST)-j.ps
	psselect -p 19 $< $@
#
$(WORLD).ps: $(ILLUST).ps
	psselect -p 20 $< $@
$(WORLD)-j.ps: $(ILLUST)-j.ps
	psselect -p 20 $< $@
#
$(MAP).ps: $(ILLUST).ps
	psselect -p 21 $< $@
$(MAP)-j.ps: $(ILLUST)-j.ps
	psselect -p 21 $< $@


EPS=$(PS:.ps=.eps)
EPSJ=$(PSJ:-j.ps=-j.eps)

%.pdf: out/%.dvi
	dvipdfmx -p a4 -q $<


#$(ART).pdf: out/$(ART).dvi
#out/$(ART).dvi: $(EPS) $(ART).tex
#	uplatex -synctex=1 -halt-on-error -file-line-error -output-directory=out $<

out/$(ART).dvi: $(ART).tex $(EPS)
	uplatex -synctex=1 -halt-on-error -file-line-error -output-directory=out $(ART).tex

out/$(ART)-j.dvi: $(ART)-j.tex $(EPSJ)
	uplatex -synctex=1 -halt-on-error -file-line-error -output-directory=out $(ART)-j.tex

#out/%.dvi: %.tex
#	uplatex -synctex=1 -halt-on-error -file-line-error -output-directory=out $<

# uplatex -synctex=1 -halt-on-error -silent -file-line-error -output-directory=out $<
# https://qiita.com/rainbartown/items/d7718f12d71e688f3573#comment-7c2f42254e84b43d3175

eps: $(EPS)
epsj: $(EPSJ)

#$(EPS): $(PS)
#
#S(EPSJ): $(PSJ)

%.eps: %.ps
	ps2eps -B -l -f $<

clean:
	rm -f *.dvi *.out *.log *.fls *.aux *.toc *.synctex.gz *.fdb_latexmk out/*

echo:
	@echo "eps = $(EPS)"
	@echo "epsj = $(EPSJ)"