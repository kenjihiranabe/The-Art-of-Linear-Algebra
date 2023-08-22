# This Makefile Works on Mac

# important target files to be published.
ART=The-Art-of-Linear-Algebra
ILLUST=Illustrations
WORLD=MatrixWorld
MAP=MapofEigenvalues

# PS->EPS options and page cutter from PostScript from PowerPoint.
PSSELECT=psselect
#PS2EPS=ps2eps -B -l -f
#vertical
PS2EPS=ps2eps -B -l -f -R=+
# horizontal
#PS2EPS=ps2eps -B -l -f -R=-

# the two product target files. "-j" means Japaense version.
all: $(ART).pdf $(ART)-j.pdf

# printout of all the pages of PowerPoint to PostScript
$(ILLUST).ps: $(ILLUST).pptx
	@echo "*** .pptx is new !! Print out $< to PostScript(.ps see PowerPointSetting.png for setting), then make again ***"
	open PowerPointSetting.png
	exit 1

$(ILLUST)-j.ps: $(ILLUST)-j.pptx
	@echo "*** .pptx is new !! Print out $< to PostScript(.ps see PowerPointSetting.png for setting), then make again ***"
	open PowerPointSetting.png
	exit 1

# the target should be $(EPS) but, avoided muti-loop of execution.
# so this target has to be kicked by hand after changing PowerPoint illustrations.
# the "page number to figure name" table is in the name-list.mak
eps-updated.touch: $(ILLUST).ps
	for i in {1..48}; do \
		$(PSSELECT) $$i $< figs/illust-p$$i.ps; \
		$(PS2EPS) figs/illust-p$$i.ps; \
		grep "^$$i " name-list.mak | cut -d ' ' -f 2 | sed -e's|^.*|figs/&.eps|' | xargs cp figs/illust-p$$i.eps ; \
	done
	ls -lR > $@

epsj-updated.touch: $(ILLUST)-j.ps
	for i in {1..46}; do \
		$(PSSELECT) $$i $< figs/illust-p$$i-j.ps; \
		$(PS2EPS) figs/illust-p$$i-j.ps; \
		grep "^$$i " name-list.mak | cut -d ' ' -f 2 | sed -e 's|^.*|figs/&-j.eps|' | xargs cp figs/illust-p$$i-j.eps ; \
	done
	ls -lR > $@

# THE tex compilation part.
%.pdf: out/%.dvi
	dvipdfmx -p a4 -q $<

# do uplatex twice to make table of contents and references.
out/$(ART).dvi: $(ART).tex eps-updated.touch
	uplatex -synctex=1 -halt-on-error -file-line-error -output-directory=out $(ART).tex
	uplatex -synctex=1 -halt-on-error -file-line-error -output-directory=out $(ART).tex

out/$(ART)-j.dvi: $(ART)-j.tex epsj-updated.touch
	uplatex -synctex=1 -halt-on-error -file-line-error -output-directory=out $(ART)-j.tex
	uplatex -synctex=1 -halt-on-error -file-line-error -output-directory=out $(ART)-j.tex

out/figs-catalog.dvi: figs-catalog.tex figs/epsinclude.tex
	uplatex -synctex=1 -halt-on-error -file-line-error -output-directory=out $<

.PHONY: figs/epsinclude.tex
figs/epsinclude.tex:
	cd figs; ls illust*.eps | grep -v 'japp' | grep -v -- '-j.eps' | sed -e 's/.*/\\includegraphics{&}\\\\&\\\\\n\n/' | sed 's/_/\\_/g' > epsinclude.tex
# note: for the options
# uplatex -synctex=1 -halt-on-error -silent -file-line-error -output-directory=out $<
# see https://qiita.com/rainbartown/items/d7718f12d71e688f3573#comment-7c2f42254e84b43d3175


# export illustrations to the book. (Linear Algebra for Everyone, Japanese edition 2022)
# list of figre pages and names are in name-list-book.mak
japp_eps: $(ILLUST)-j.ps
	for i in `sed '/^#/d' name-list-book.mak | cut -d ' ' -f 1`; do \
		grep "^$$i " name-list-book.mak | cut -d ' ' -f 2 | sed -e 's/_/=/' -e 's|^.*|figs/japp_&.eps|' | xargs cp figs/illust-p$$i-j.eps ; \
	done

japp_copy:
	cp figs/japp*.eps ../linear-algebra-for-everyone/translation/jfigs
	cp figs/MatrixWorld-j.eps ../linear-algebra-for-everyone/translation/jfigs/MatrixWorld-j.eps
	cp figs/japp*.eps ../linear-algebra-for-everyone/translation/figs
	cp figs/MatrixWorld-j.eps ../linear-algebra-for-everyone/translation/figs/MatrixWorld-j.eps

clean:
	rm -f *.dvi *.out *.log *.fls *.aux *.toc *.synctex.gz *.fdb_latexmk out/* *.p figs/*.ps

# may need this later ... (only commented lines below)
# now, all the eps filenames are moved to names-list.mak
# and updated timestamp is in .touch files.
# EPS=figs/ViewingMatrix-4Ways.eps\
# 	figs/VectorTimesVector.eps\
# 	figs/MatrixTimesVector.eps\
# 	figs/VectorTimesMatrix.eps\
# 	figs/4-Subspaces.eps\
# 	figs/MatrixTimesMatrix.eps\
# 	figs/5-Factorizations.eps\
# 	figs/A_CR.eps\
# 	figs/A_LU.eps\
# 	figs/A_QLQT.eps\
# 	figs/A_QR.eps\
# 	figs/A_USVT.eps\
# 	figs/CR1.eps\
# 	figs/CR2.eps\
# 	figs/LU1.eps\
# 	figs/LU2.eps\
# 	figs/Pattern11-22.eps\
# 	figs/Pattern12.eps\
# 	figs/Pattern3.eps\
# 	figs/Pattern4.eps\
# 	figs/QR.eps\
# 	figs/EVD.eps\
# 	figs/SVD.eps\
# 	figs/$(MAP).eps\
# 	figs/$(WORLD).eps
# EPSJ=$(EPS:%.eps=%-j.eps)
# $(EPS): eps-updated.touch
# $(EPSJ):  epsj-updated.touch

