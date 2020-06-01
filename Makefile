default: build

########################################
### CI

ci: build

########################################
### Submodules

submodules:
	@echo "--> Installing submodules"
	git submodule init
	git submodule update

########################################
### Installation

install-swagger-markdown:
	@echo "--> Installing swagger-markdown"
	yarn global add swagger-markdown

########################################
### Build

build: build-markdown-http-docs
	@echo "--> Building docs site"
	mkdocs build

serve: build-markdown-http-docs
	@echo "--> Serving docs site"
	mkdocs serve

########################################
### Build other docs

build-markdown-http-docs:
	@echo "--> Generating markdown from swagger.yml"
	npx binance-chain/swagger-markdown -i swagger.yml -o docs/api-reference/dex-api/paths.md
	npx binance-chain/swagger-markdown -i swagger_testnet.yml -o docs/api-reference/dex-api/paths-testnet.md


build-swagger2markup: submodules
	@echo "--> Building swagger2markup-cli"
	cd utils/swagger2markup-cli && gradle assemble

########################################
### Swagger
swagger-docs: build-swagger2markup
	@echo "--> Generating dex-api docs from swagger.yml"
	java -jar ./utils/swagger2markup-cli/build/libs/swagger2markup-cli-1.3.3.jar convert -i ./swagger.yml -d ./docs/api-reference/dex-api -c ./utils/swagger2markup.config.properties

########################################

# To avoid unintended conflicts with file names, always add to .PHONY
# unless there is a reason not to.
# https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html
.PHONY: submodules build serve build-markdown-http-docs build-swagger2markup swagger-docs
