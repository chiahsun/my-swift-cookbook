.PHONY: build view md 

all: build view

build:
	asciidoctor -v -t index.adoc

view:
	open index.html

# See: https://gist.github.com/cheungnj/38becf045654119f96c87db829f1be8e
%.xml: %.adoc
	asciidoctor -b docbook $<
	
%.md: %.xml
	pandoc -f docbook -t gfm $< -o $@

md: array.md dict.md subscriber.md future.md publisher.md swift-ui.md
