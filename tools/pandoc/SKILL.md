---
name: pandoc-cli
description: Use Pandoc to convert documents between formats - Markdown, HTML, PDF, DOCX, LaTeX, EPUB, and dozens more.
---

# Pandoc

Universal document converter. Convert between Markdown, HTML, PDF, DOCX, LaTeX, EPUB, and 40+ formats.

- **Official site:** https://pandoc.org
- **Docs:** https://pandoc.org/MANUAL.html

## Common Commands

### Markdown Conversions
```bash
pandoc input.md -o output.html                        # Markdown to HTML
pandoc input.md -o output.pdf                         # Markdown to PDF (requires LaTeX)
pandoc input.md -o output.docx                        # Markdown to Word
pandoc input.md -o output.epub                        # Markdown to EPUB
pandoc input.md -s -o output.html                     # Standalone HTML (full page)
```

### HTML Conversions
```bash
pandoc input.html -o output.md                        # HTML to Markdown
pandoc input.html -o output.pdf                       # HTML to PDF
pandoc input.html -t gfm -o output.md                 # HTML to GitHub Flavored Markdown
```

### Word/Office
```bash
pandoc input.docx -o output.md                        # DOCX to Markdown
pandoc input.docx -o output.html                      # DOCX to HTML
pandoc input.md --reference-doc=template.docx -o output.docx  # Use Word template
```

### LaTeX
```bash
pandoc input.tex -o output.html                       # LaTeX to HTML
pandoc input.md -o output.tex                         # Markdown to LaTeX
pandoc input.md --pdf-engine=xelatex -o output.pdf    # PDF with XeLaTeX
```

### Options
```bash
pandoc input.md -s --toc -o output.html               # Table of contents
pandoc input.md -s --css=style.css -o output.html     # Custom CSS
pandoc input.md --template=my-template -o output.html # Custom template
pandoc input.md -V geometry:margin=1in -o output.pdf  # PDF margins
pandoc input.md --highlight-style=tango -o output.html # Code highlighting
pandoc input.md --metadata title="My Doc" -o output.html
```

### Multiple Inputs
```bash
pandoc ch1.md ch2.md ch3.md -o book.pdf               # Concatenate files
pandoc ch1.md ch2.md ch3.md --toc -o book.epub         # Book with TOC
```

### Format Detection
```bash
pandoc --list-input-formats                            # List input formats
pandoc --list-output-formats                           # List output formats
```

## Agent Best Practices

- Pandoc infers format from file extension - use `-f` and `-t` to be explicit
- Use `-s` (standalone) for complete documents, not fragments
- PDF output requires LaTeX (install with `brew install --cask mactex-no-gui`)
- Use `--toc` for automatic table of contents generation
- Use `--template` for consistent formatting across documents
- Pipe stdin/stdout: `echo "# Hello" | pandoc -f markdown -t html`
- Use `--wrap=none` to prevent line wrapping in output

## Example Workflows

### Convert project docs to HTML site
```bash
for f in docs/*.md; do
  pandoc "$f" -s --css=style.css -o "${f%.md}.html"
done
```

### Generate PDF report from Markdown
```bash
pandoc report.md -s --toc -V geometry:margin=1in -o report.pdf
```
