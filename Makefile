.PHONY: lint critique docx pdf

lint: nda.json
	npx -q -p commonform-cli commonform lint $<

critique: nda.json
	npx -q -p commonform-cli commonform critique $<

docx: nda.docx

nda.docx: nda.json signatures.json
	npx -q -p commonform-cli commonform render -f docx --title "Mutual Nondisclosure Agreement" --indent-margins --left-align-title -n outline --styles styles.json -s signatures.json $< > $@

pdf: nda.pdf

nda.pdf: nda.docx
	unoconv $<

.INTERMEDIATE: nda.json

nda.json: nda.md
	cat $< | npx -q commonmark-to-commonform | npx json form > $@
