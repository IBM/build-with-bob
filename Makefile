HUGO := /tmp/hugo
HUGO_VERSION := 0.147.9

# Download Hugo if not present
$(HUGO):
	curl -sL "https://github.com/gohugoio/hugo/releases/download/v$(HUGO_VERSION)/hugo_extended_$(HUGO_VERSION)_darwin-universal.tar.gz" \
		-o /tmp/hugo.tar.gz && tar -xzf /tmp/hugo.tar.gz -C /tmp hugo

## dev: Start local dev server at http://localhost:1313/build-with-bob/
dev: $(HUGO)
	$(HUGO) server --port 1313 --bind 127.0.0.1

## build: Build the site into ./public
build: $(HUGO)
	$(HUGO) --gc --minify

## deploy: Build and push to GitHub (triggers GitHub Pages deploy)
deploy: build
	git add -A
	git commit -m "Deploy: update site" || echo "Nothing to commit"
	git push origin main

## help: Show available commands
help:
	@grep -E '^## ' Makefile | sed 's/## //'

.PHONY: dev build deploy help
