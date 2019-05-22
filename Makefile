.PHONY: lint critique

lint: nda.json
	npx -q -p commonform-cli commonform lint $<

critique: nda.json
	npx -q -p commonform-cli commonform critique $<

.INTERMEDIATE: nda.json

nda.json: nda.md
	cat $< | npx -q commonmark-to-commonform | npx json form > $@
