.PHONY: help
help: ## 📋 Displays this list of targets with descriptions
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: install
install: ## 📦 Install probe application to MultiFlexi
	multiflexi-json2app multiflexi/multiflexi_probe.multiflexi.app.json

.PHONY: validate
validate: ## ✓ Validate application JSON schema
	multiflexi-cli application validate-json --json multiflexi/multiflexi_probe.multiflexi.app.json

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

.PHONY: test
test: ## 🧪 Test probe locally
	./multiflexi-probe /etc/fstab
