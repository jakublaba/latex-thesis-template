.DEFAULT_GOAL := pdf
.PHONY: help prepare clean pdf hot-reload

TEX_DIR = tex
BUILD_DIR = .build
PDF_NAME = thesis.pdf
MAIN_FILE = $(TEX_DIR)/main.tex

pdf: prepare ## Compile the PDF (default)
	latexmk -pdf -shell-escape -jobname=thesis -outdir=../$(BUILD_DIR) -auxdir=../$(BUILD_DIR) -cd $(MAIN_FILE)
	@cp $(BUILD_DIR)/thesis.pdf $(PDF_NAME)

hot-reload: prepare ## Live-reload as you type
	latexmk -pdf -pvc -shell-escape -jobname=thesis -outdir=../$(BUILD_DIR) -auxdir=../$(BUILD_DIR) -cd $(MAIN_FILE)

prepare:
	@mkdir -p $(BUILD_DIR)
	@find $(TEX_DIR) -type d | sed 's|^$(TEX_DIR)|$(BUILD_DIR)|' | xargs mkdir -p

clean: ## Clean up build artifacts
	rm -rf $(BUILD_DIR)
	rm -rf $(TEX_DIR)/_minted-*

help: ## Show this help menu
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'
