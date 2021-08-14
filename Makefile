.PHONY: build view

all: build view

build:
	asciidoctor -v -t index.adoc

view:
	open index.html

