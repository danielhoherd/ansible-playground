.DEFAULT_GOAL := help

.PHONY: help
help: ## Print Makefile help.
	@grep -Eh '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[1;36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: install-hooks
install-hooks: ## Install git hooks.
	pip3 install --user --upgrade pre-commit \
	|| pip install --user --upgrade pre-commit
	pre-commit install -f --install-hooks
