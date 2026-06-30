TYPST_FILE=./typst/builder.typ

all:
	@echo "make en-resume: builds the english version of resume ($(TYPST_FILE))"
	@echo "make pt-resume: builds the portuguese version of resume ($(TYPST_FILE))"

en-resume:
	typst compile $(TYPST_FILE) --root . --input lang="english"

pt-resume:
	typst compile $(TYPST_FILE) --root . --input lang="portuguese"

.PHONY: en-resume all pt-resume
