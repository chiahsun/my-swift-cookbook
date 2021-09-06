FILE=dict
asciidoctor -b docbook $FILE.adoc
pandoc -f docbook -t gfm $FILE.xml -o $FILE.md
open $FILE.md
