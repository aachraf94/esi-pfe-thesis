# .latexmkrc — Build configuration
# Run: latexmk  (from project root)

# Use XeLaTeX to produce PDF
$pdf_mode = 5;
$xelatex = 'xelatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';

# Separate aux/build files from final PDF
$out_dir = 'out';
$aux_dir = 'build';

# Use Biber (not legacy bibtex)
$bibtex_use = 2;

# Make all sub-directories discoverable for \input / \include
ensure_path('TEXINPUTS', './/');
