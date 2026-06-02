# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repository Is

A XeLaTeX thesis for a Final Year Project (PFE) at ESI (École Nationale Supérieure d'Informatique, Alger). The thesis covers **LOGIQ**, a Business Intelligence Decision Support Information System for logistics operations, built in partnership with Ourquilane. **This is a LaTeX document project, not a software project** — there is no test suite, linter, or runtime.

## Read the Guides First

Before editing **any** chapter content, read the authoritative writing guides in `guide/` (recommended order `00` → `03` → `02` → `01`). They — not this file or the README — hold the binding scope, structure, page budget, and style rules.

| File | Authority over |
|---|---|
| `guide/00_README_pfe_guide.md` | Global rules: language, readability, **corrected scope** (§0.5), references (APA), page budget (§0.6), LaTeX hygiene, writing order, do-not list |
| `guide/01_state-of-the-art_guide.md` | Part I — Chapter 1 (Data-Driven Decision Making), Chapter 2 (Logistics in the Data Age) |
| `guide/02_contribution_guide.md` | Part II — Chapters 3–6, General Introduction/Conclusion, appendices |
| `guide/03_visuals_guide.md` | The three visual modes, the `\visualplaceholder` macro, figure rules |
| `guide/thesis-technical-recap.md` | Source of truth for the built solution (Part II) |
| `guide/thesis.md` | Original PFE information form (reference) |

**Scope correction (overrides older descriptions):** the two delivered business axes are **On-Demand Dedicated Transport** and **Parcel Delivery** (classic e-commerce express) — *not* "Parcel Cost Control". Each dashboard page has exactly three sub-pages: **Operations / Cost & Profitability / Performance**. There is **no Pricing page**. See `guide/00_README_pfe_guide.md` §0.5.

**Route Analysis** is out of scope for this version and appears only as future work, in neutral terms (data not available within project scope). Never mention GPS, confidentiality, or withheld data. See `guide/00_README_pfe_guide.md` §0.4.

**Page budget:** 110 pages body + 15 pages appendix = 125 max. Prefer visuals, charts, and tables over dense prose.

> **Missing `docs/` design docs.** `guide/00_README_pfe_guide.md` §1, `guide/02_contribution_guide.md`, and `guide/thesis-technical-recap.md` point to detailed design docs in a `docs/` directory (`dw-doc.md`, `etl-dagster-doc.md`, `mock-data-doc.md`, `architecture.md`, `deployment.md`) as the source for **exact** figures (table counts, event totals, etc.). **That directory is not in this repo.** Until it is added, follow the guides' fallback: use qualitative figures and mark every uncertain number with `% TODO(achraf): confirm` — do not invent exact counts.

## Build Commands

```bash
# Full build (XeLaTeX → Biber → XeLaTeX × 2); reads .latexmkrc automatically
latexmk main

# Clean all build artifacts
latexmk -C main
```

Final PDF: `out/main.pdf`. Intermediate aux files: `build/`. (`.latexmkrc` sets `$out_dir = 'out'`, `$aux_dir = 'build'`, `$pdf_mode = 5` for XeLaTeX, and Biber.)

> **XeLaTeX is required** — `pdflatex` will not work. The document uses `fontspec` (system fonts: Times New Roman, Arial, Courier New) and `polyglossia` (Arabic abstract). Requires MiKTeX with those Windows fonts installed.

Manual sequence if `latexmk` is unavailable:
```
xelatex main && biber build/main && xelatex main && xelatex main
```

In VS Code (LaTeX Workshop): open `main.tex`, build with `Ctrl+Alt+B` — the extension reads `.latexmkrc`.

## Architecture

`main.tex` is the single entry point. It loads config in order — `config/packages.tex` (all `\usepackage`), `config/settings.tex` (fonts, margins, spacing, colors, headers, `\graphicspath`), `config/commands.tex` (custom commands + thesis metadata) — then `\include`s content.

### Content flow

`main.tex` pulls in front matter, then `\part{}` + a per-part dispatcher that `\include`s each chapter:

- `mainmatter/part1/part1.tex` → chapter1, chapter2
- `mainmatter/part2/part2.tex` → chapter3, chapter4, chapter5 (chapter6 once written)

> The guides scope **six** chapters. Part II is Chapter 3 (Analysis & Methodology), Chapter 4 (Design & Architecture), Chapter 5 (**Implementation & Deployment**), and Chapter 6 (**Testing, Validation & Results**). Chapter 6 may not exist yet — when writing it, create `mainmatter/part2/chapter6/` (with a `figures/` subdir), register it in `part2.tex`, and add its `figures/` path to `\graphicspath` in `config/settings.tex`. Don't assume a file exists — check the dispatcher.

Each chapter lives in its own directory with a `figures/` subdirectory. All figure directories are pre-registered in `config/settings.tex` via `\graphicspath`, so `\includegraphics{filename}` works with no path prefix. Shared figures live in `assets/global-figures/`, logos in `assets/logos/`.

### Custom commands (`config/commands.tex`)

| Command | Usage |
|---|---|
| `\fig[width]{file}{caption}{label}` | Insert a figure (default width `0.8\textwidth`); auto-prefixes label with `fig:` |
| `\uchapter{Title}` | Unnumbered chapter that still appears in the TOC |
| `\todo{text}` | Red `[TODO: …]` draft marker — see marker conventions below |
| `\visualplaceholder{shows}{how to produce}{caption}` | Framed box for a pending visual — **must be added** (see below) |
| `\thesisTitle`, `\thesisAuthor`, `\thesisSupervisorA/B`, `\thesisYear`, `\thesisOption` | Thesis metadata — change once here, reused everywhere |
| `\ie`, `\eg`, `\etc` | Italic Latin abbreviations |

> `\visualplaceholder` is referenced by `guide/03_visuals_guide.md` but is **not yet defined** in `commands.tex`. Add it there (the macro definition is in the visuals guide §2) before using it. It may require `\usepackage{capt-of}` for `\captionof` if not already loaded.

### Bibliography

`references.bib` at the repo root, via `biblatex` with the **Biber** backend, **APA** style, **`nyt`** sorting (`\usepackage[backend=biber, style=apa, sorting=nyt]{biblatex}` in `config/packages.tex`). `nyt` (name → year → title) yields the alphabetical-by-author ordering APA requires. Add entries to `references.bib` and cite with `\cite{key}`; the bibliography is emitted by `\printbibliography` in `main.tex`.

> When citing a **new** source, add its BibTeX entry to `references.bib` **in the same change**. Never leave a `\cite{key}` without a matching entry, and never invent an author/year — if a claim needs a citation you don't have, write the sentence and add `% TODO(achraf): add citation`.

## Marker Conventions

Three distinct markers, each with one job — do not mix them:

| Marker | Use for | Visible in PDF? |
|---|---|---|
| `% TODO(achraf): …` | **Uncertain numbers / facts** to confirm (e.g. exact table counts, event totals, measured performance) | No — silent LaTeX comment |
| `\visualplaceholder{…}{…}{…}` | **Pending visuals** that must come from the live platform or be hand-drawn (dashboard screenshots, full ERD, etc.) | Yes — framed box |
| `\todo{…}` | **Prose to revisit** (a sentence to rework, a section to expand) | Yes — red inline marker |

Keep uncertain numbers as silent `% TODO` comments so no unverified figure ever renders in the PDF.

### Visual modes (tag every figure in the source)

Separately from the markers above, `guide/03_visuals_guide.md` defines **three source-comment tags** — put one on every figure/chart/diagram/table so it is trackable:

| Tag (LaTeX comment) | Meaning | When |
|---|---|---|
| `% [VISUAL-IMPLEMENT]` | Claude produces real LaTeX now (**default**, the bulk) | All `booktabs` tables; TikZ diagrams (architecture, ETL flow, schema fragments, SCD2, etc.); `pgfplots` charts |
| `% [VISUAL-FETCH]` | Download a generic reference image manually into `figures/` | Sparingly, mostly Part I textbook illustrations |
| `% [VISUAL-PLACEHOLDER]` | Render the `\visualplaceholder` framed box for a pending visual | Anything from the live platform (dashboard screenshots, real ERD) or hand-drawn |

Maintain a running **`FIGURES_TODO.md`** at the repo root listing every `[VISUAL-PLACEHOLDER]` and every `[VISUAL-FETCH]` to source, so there is one checklist of visuals still to produce (columns: `ID | chapter | mode | what it shows | how to produce | status`). `[VISUAL-IMPLEMENT]` items are made inline and need not be tracked.

## Conventions

- **English, British spelling** (`optimise`, `modelling`, `colour`) — pick it once and stay consistent, matching the technical recap. Clear, simple academic language; no flowery prose. Define every acronym on first use.
- **No dense walls of text.** Cap paragraphs at ~4–6 lines; after at most 2–3 prose paragraphs, break with a list, a `booktabs` table, a figure, or a subheading. Never more than ~½ page of uninterrupted prose. Visuals and scannable structure are always preferred. See `guide/00_README_pfe_guide.md` §0.2.
- Every figure/table needs a `\caption`, a `\label`, and **at least one in-text reference**. Tables use `booktabs` (no vertical rules). Diagrams use `tikz`; charts use `pgfplots`.
- `esiblue` (`RGB 0,84,166`) is defined but **reserved for logos/figures** — never use it in text or headings.
- Code listings use the `thesis` style (`\lstset{style=thesis}` in `settings.tex`); keep any inline snippet short (≤10 lines) — no full code dumps.
- Document is `report`, 12pt, A4, `oneside`; line spacing 1.5× (`\onehalfspacing`).
- Front matter uses roman page numbers; main matter switches to arabic.
- Paragraph and margin specifics live in `settings.tex` — change spacing there globally, not per-file.
- After writing each chapter, run the per-chapter self-check in `guide/00_README_pfe_guide.md` §0.8 and a trial `latexmk main`; fix errors before moving on.

## Not Thesis Content

Do not treat these as chapters to write or "fix": `guide/` (writing guides and source-of-truth docs — read-only reference), `build/` and `out/` (generated artefacts), `assets/` (figures/logos), and `FIGURES_TODO.md` (a tracking checklist). Thesis prose lives only under `frontmatter/`, `mainmatter/`, and `backmatter/`.
