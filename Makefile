.PHONY: help
help: ## 📋 Displays this list of targets with descriptions
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: import
import: ## 📦 Import probe application to MultiFlexi
	multiflexi-cli application import-json --file multiflexi/probe.multiflexi.app.json
	multiflexi-cli crprototype import-json --file=multiflexi/probe.multiflexi.credprototype.json


.PHONY: debs
debs: ## 📦 Build Debian package
	debuild -i -us -uc -b

.PHONY: clean
clean: ## 🧹 Clean build artifacts
	rm -rf debian/multiflexi-probe debian/.debhelper debian/files debian/*.log debian/*.substvars

.PHONY: dimage
dimage: ## 🐳 Build docker image
	podman build -f Containerfile . -t docker.io/vitexsoftware/multiflexi-probe

.PHONY: dimagex
dimagex: ## 🌐 Build and push multi-arch docker image
	docker buildx build -f Containerfile . --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag docker.io/vitexsoftware/multiflexi-probe

.PHONY: use
use: ## Install into multiflexi
	multiflexi-cli app import-json --file multiflexi/probe.multiflexi.app.json

.PHONY: test
test: ## 🧪 Test probe locally
	./multiflexi-probe /etc/fstab

.PHONY: validate-multiflexi-app
validate-multiflexi-app: ## ✓ Validate application JSON schema
	@if [ -d multiflexi ]; then \
		for file in multiflexi/*.multiflexi.app.json; do \
			if [ -f "$$file" ]; then \
				echo "Validating $$file"; \
				multiflexi-cli app validate-json --file="$$file"; \
			fi; \
		done; \
	else \
		echo "No multiflexi directory found"; \
	fi

.PHONY: helm-lint
helm-lint: ## ✓ Validate Helm chart
	helm lint helm/

.PHONY: helm-template
helm-template: ## 📋 Render Helm chart templates
	helm template multiflexi-probe helm/

.PHONY: helm-install
helm-install: ## 🚀 Install or upgrade Helm release in namespace multiflexi
	helm upgrade --install multiflexi-probe helm/ --namespace multiflexi --create-namespace

.PHONY: helm-package
helm-package: ## 📦 Package Helm chart
	@mkdir -p releases
	helm package helm/ --destination releases
