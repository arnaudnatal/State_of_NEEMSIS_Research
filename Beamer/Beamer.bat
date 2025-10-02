arara %~n0.tex

pandoc -s %~n0.tex --filter pandoc-crossref --citeproc --csl="https://raw.githubusercontent.com/citation-style-language/styles/master/apa-6th-edition.csl" --reference-doc reference.docx -o %~n0.docx