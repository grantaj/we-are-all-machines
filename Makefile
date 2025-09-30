PANDOC = pandoc
SRC    = main.tex
BIB    = main.bib
CSL    = chicago-notes-bibliography.csl
TPL    = template.html
FILTER = ignore-spacing.lua
CSS    = style.css

OUTDIR = docs
OUT    = $(OUTDIR)/index.html

all: $(OUT)

$(OUT): $(SRC) $(BIB) $(CSL) $(TPL) $(CSS) $(FILTER)
	@mkdir -p $(OUTDIR)/assets
	cp $(CSS) $(OUTDIR)/style.css
	cd $(OUTDIR) && $(PANDOC) ../$(SRC) \
	  --standalone \
	  --mathjax \
	  --citeproc \
	  --bibliography=../$(BIB) \
	  --csl=../$(CSL) \
	  --lua-filter=../$(FILTER) \
	  --metadata=suppress-bibliography=true \
	  --template=../$(TPL) \
	  --resource-path=..:../figures \
	  --extract-media=assets \
	  -o index.html
	@echo "Built -> $(OUT)"

clean:
	rm -rf $(OUTDIR)

.PHONY: all clean
