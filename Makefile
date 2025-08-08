JSON_FMT=./tools/json-fmt.sh
SH_FMT=./tools/sh-fmt.sh

all:
	@echo "Usage: make [Options]"
	@echo ""
	@echo "Options:"
	@echo "      json  Format all json files"
	@echo "      sh    Format all sh files"
	@echo "      pdf   Generate pdf files using typst"

json:
	$(JSON_FMT)

sh:
	$(SH_FMT)

pdf:
	@echo -e "@\e[96mtodo\e[0m"
	@echo "This will be implemented soon..."

.PHONY: all json sh pdf
