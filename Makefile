.DEFAULT_GOAL := help

.PHONY: help app docs

APP_PORT = 8086
DOCS_PORT = 6060
HOST = 0.0.0.0

help:
	@echo ""
	@echo "Available targets:"
	@echo "  make app    – run Shiny app on port $(APP_PORT)"
	@echo "  make docs   – preview Quarto docs on port $(DOCS_PORT)"
	@echo ""

app:
	R -e 'shiny::runApp(port = $(APP_PORT), host = "$(HOST)")'

docs:
	quarto preview index.qmd --port $(DOCS_PORT) --host $(HOST)

readme:
	quarto render index.qmd --to gfm --output README.md
