.PHONY: build view md 

all: build view

build:
	asciidoctor -v -t index.adoc

view:
	open index.html

%.xml: %.adoc
	asciidoctor -b docbook $<
	
%.md: %.xml
	pandoc -f docbook -t gfm $< -o $@

md: dict.md 

