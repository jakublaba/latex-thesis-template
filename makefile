.DEFAULT_GOAL := pdf
.PHONY: help prepare clean pdf hot-reload

ROOT_DIR   := $(shell pwd)
TEX_DIR    := tex
BUILD_DIR  := $(ROOT_DIR)/.build
MAIN_FILE  := main.tex
OUTPUT_PDF := thesis.pdf

LATEXMK_FLAGS = -pdf -shell-escape \
                -jobname=thesis \
                -outdir=$(BUILD_DIR) \
                -auxdir=$(BUILD_DIR) \
                -e '$$out_dir = "$(BUILD_DIR)";' \
                -e '$$aux_dir = "$(BUILD_DIR)";'

pdf: prepare ## Compile the PDF (default)
	cd $(TEX_DIR) && latexmk $(LATEXMK_FLAGS) $(MAIN_FILE)
	@cp $(BUILD_DIR)/thesis.pdf $(ROOT_DIR)/$(OUTPUT_PDF)

hot-reload: prepare ## Live-reload as you type
	cd $(TEX_DIR) && latexmk -pvc $(LATEXMK_FLAGS) $(MAIN_FILE)

prepare:
	@mkdir -p $(BUILD_DIR)
	@cd $(TEX_DIR) && find . -type d -exec mkdir -p $(BUILD_DIR)/{} \;

clean: ## Clean up build artifacts
	rm -rf $(BUILD_DIR)
	rm -f $(OUTPUT_PDF)
	rm -rf $(TEX_DIR)/_minted*

help: ## Show this help menu
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'