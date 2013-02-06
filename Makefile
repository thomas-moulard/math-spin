DOC=slides.tex
DOCPDF=$(subst .tex,.pdf,$(DOC))
PDF=xpdf

.PHONY: all pdf clean distclean genimages
.SUFFIXES: .png .svg

$(DOCPDF): *.tex

all: $(DOCPDF)

pdf: $(DOCPDF)
	@$(PDF) $(DOCPDF)

publish: $(DOCPDF)
	@scp $(DOCPDF) \
	$USER@lrde.epita.fr:www/seminar_05-07.pdf \
	> /dev/null \
	&& echo "PDF has been successfully published.";

.svg.png: $<
	inkscape $< --export-png=$*.png -d 400 -b white
	convert -background "#ffffff" +matte $*.png -negate -white-threshold 1 -colorspace GRAY -colors 255  -negate $*-mask.png

include share/make/share.mk
include share/make/tex.mk
include share/make/handout.mk