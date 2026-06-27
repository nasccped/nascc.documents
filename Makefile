TYPST_FILE=./resumes/resume_builder.typ
TYPST_DEF_VALUES=$(TYPST_FILE) --root .

all:
	@echo "make en-resume: builds the english version of resume ($(TYPST_FILE))"
	@echo "make pt-resume: builds the portuguese version of resume ($(TYPST_FILE))"

en-resume:
	typst compile $(TYPST_DEF_VALUES) --input lang="english"

pt-resume:
	typst compile $(TYPST_DEF_VALUES) --input lang="portuguese"

.PHONY: en-resume all
