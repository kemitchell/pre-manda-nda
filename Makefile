COMMONFORM=node_modules/.bin/commonform
PARSER=node_modules/.bin/commonmark-to-commonform
JSON=node_modules/.bin/json

.PHONY: lint critique docx pdf clean

lint: nda.json | $(COMMONFORM)
	$(COMMONFORM) lint $<

critique: nda.json | $(COMMONFORM)
	$(COMMONFORM) critique $<

docx: nda.docx

nda.docx: nda.json signatures.json styles.json | $(COMMONFORM)
	$(COMMONFORM) render -f docx --title "Pre-M&A Mutual Nondisclosure Agreement" --indent-margins --left-align-title -n outline --styles styles.json -s signatures.json $< --blank-text "_______________" > $@

pdf: nda.pdf

nda.pdf: nda.docx
	unoconv $<

.INTERMEDIATE: nda.json

nda.json: nda.md | $(PARSER) $(JSON)
	cat $< | $(PARSER) | $(JSON) form > $@

$(COMMONFORM) $(PARSER) $(JSON):
	npm install

clean:
	rm -f nda.json nda.docx nda.pdf
