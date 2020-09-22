NAME:=main

# To update, run: latex-process-inputs -makefilelist main.tex
TEX_FILES = \
$(NAME).tex

PDFS := paper.pdf
TEMP_TXTS := $(patsubst %.pdf,%.txt,$(PDFS))
OUTPUTS_SPELL := $(TEMP_TXTS)

.DEFAULT_GOAL := pdf

pdf:
#	latexmk -bibtex -pdf $(NAME)
	latexmk -pdf $(NAME)

final: pdf
	@echo '******** Did you spell-check the paper? ********'
	pdffonts $(NAME).pdf; fi

clean:
	-rm -f *aux *bbl *blg *log *.dvi $(NAME).pdf *.fdb_latexmk *.fls *.out *.spl

check: $(TEMP_TXTS)
	cat $^ | aspell list --extra-dicts=./okwords.en.pws | sort | uniq

%.txt: paper.pdf
	pdftotext $<

%.err: %.txt
	cat $^ | aspell list --extra-dicts=./okwords.en.pws | sort | uniq

.PHONY: all

tags: TAGS
TAGS: ${TEX_FILES}
	etags ${TEX_FILES}
