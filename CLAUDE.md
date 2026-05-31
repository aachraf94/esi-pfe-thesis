# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repository Is

A XeLaTeX thesis for a Final Year Project (PFE) at ESI (École Nationale Supérieure d'Informatique, Alger). The thesis covers a Business Intelligence Decision Support System for logistics operations, built in partnership with Ourquilane. **This is a LaTeX document project, not a software project.**

## Build Commands

```bash
# Full build (XeLaTeX → Biber → XeLaTeX × 2), run from repo root
latexmk main

# Clean all build artifacts
latexmk -C main
```

Output lands in `out/main.pdf`. Intermediate aux files go to `build/`.

> **XeLaTeX is required** — `pdflatex` will not work. The document uses `fontspec` (system fonts: Times New Roman, Arial, Courier New) and `polyglossia` (Arabic abstract support).

Manual build sequence (if `latexmk` is unavailable):
```
xelatex main && biber build/main && xelatex main && xelatex main
```

## Architecture

`main.tex` is the single entry point. It loads config in this order, then includes all content files:

1. `config/packages.tex` — all `\usepackage{}` declarations
2. `config/settings.tex` — fonts, margins, spacing, colors, headers/footers, chapter title style
3. `config/commands.tex` — custom commands and thesis-wide metadata

### Custom Commands (defined in `config/commands.tex`)

| Command | Usage |
|---|---|
| `\fig[width]{file}{caption}{label}` | Insert a figure (default width 80%) |
| `\uchapter{Title}` | Unnumbered chapter that still appears in TOC |
| `\todo{text}` | Red TODO marker for draft use |
| `\thesisTitle`, `\thesisAuthor`, etc. | Thesis metadata — change here, used everywhere |
| `\ie`, `\eg`, `\etc` | Italic Latin abbreviations |

### Content Layout

```
frontmatter/          cover, dedication, acknowledgements, abstracts (EN/FR/AR), abbreviations
mainmatter/
  introduction.tex
  part1/              State of the Art (chapters 1–2)
  part2/              Contribution (chapters 3–5)
  conclusion.tex
backmatter/annexes/   annexe_a.tex, annexe_b.tex
```

Each chapter directory has a `figures/` subdirectory. All figure paths are pre-registered in `config/settings.tex` via `\graphicspath`, so `\includegraphics{filename}` works without path prefixes.

### Bibliography

`references.bib` at the repo root. Uses `biblatex` with `biber` backend, IEEE citation style, citation order sorting. Add entries to `references.bib` and cite with `\cite{key}`.

## Key Conventions

- `esiblue` color (`RGB 0,84,166`) is defined but reserved for logos/figures only — do not use it in text or headings.
- Code listings use the `thesis` style defined in `settings.tex` (`\lstset{style=thesis}`).
- The document is `oneside` (single-sided), 12pt, A4.
- Paragraphs: 1.5em indent, 4pt skip, first paragraph after headings is also indented (French academic convention enforced globally).
- Line spacing: 1.5× (`\onehalfspacing`).
- Margins: 3cm top/bottom/left, 2.5cm right.
