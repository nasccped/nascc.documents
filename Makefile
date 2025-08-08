JSON_FMT=./tools/json-fmt.sh
SH_FMT=./tools/sh-fmt.sh
WATCH_PDF=./tools/pdf-watch.sh
TEMP_DIR=temp

CYAN=\e[96m
RESET=\e[0m

all:
	@echo    "Usage: make [Options]"
	@echo    ""
	@echo    "Options:"
	@echo -e "      $(CYAN)json$(RESET)  Format all json files"
	@echo -e "      $(CYAN)sh$(RESET)    Format all sh files"
	@echo -e "      $(CYAN)pdf$(RESET)   Generate pdf files using typst"
	@echo -e "      $(CYAN)watch$(RESET) Generate pdf in watch mode (temp dir)"

json:
	$(JSON_FMT)

sh:
	$(SH_FMT)

pdf:
	@echo -e "@$(CYAN)todo$(RESET)"
	@echo "This will be implemented soon..."

watch: $(TEMP_DIR)
	$(WATCH_PDF)

$(TEMP_DIR):
	@mkdir $@

.PHONY: all json sh pdf watch
