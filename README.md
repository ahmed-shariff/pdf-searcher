## pdf-searcher
A simple tool written in CL to search a set of pdf files for a given term.
I wound up putting this together coz I keep forgetting what articles I came across a perticular term, and I have the articles in pdf.

## Usage
I usually have pdf files stored in s single directory. Hence the script recursively reads all pdf files in the directory and looks for pdf files with the terms given.
```common-lisp
(pdf-searcher:find-pdf-files-with-mentions "path/to/directory/contining/pdf/files" "search term")
```
Note: This uses the `pdftotext` linux tool. so if you are using it, make sure you have it installed.