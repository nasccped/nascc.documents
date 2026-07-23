TYPST_DIR=./typst
TYPST_FILE=$(TYPST_DIR)/builder.typ

all:
	@echo "make en-resume: builds the english version of resume ($(TYPST_FILE))"
	@echo "make pt-resume: builds the portuguese version of resume ($(TYPST_FILE))"

en-resume: $(TYPST_FILE)
	typst compile $< $(TYPST_DIR)/output-en.pdf --input lang="en"

pt-resume: $(TYPST_FILE)
	typst compile $< $(TYPST_DIR)/output-pt.pdf --input lang="pt"

.PHONY: en-resume all pt-resume
