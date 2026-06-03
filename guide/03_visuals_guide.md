# 03 — Visuals Guide

> The visual system for the whole thesis. Read this before writing any chapter. **Visuals, charts, and
> tables are always preferable to dense prose** (see §0.2 in `00_README_pfe_guide.md`). Every chapter
> should be visually rich.

---

## 1. The three visual modes
For **every** figure / chart / diagram / table, pick ONE mode and tag it in the LaTeX source with a
comment so it is trackable:

### `[VISUAL-IMPLEMENT]` — generate it now (DEFAULT, prefer this)
Claude produces real LaTeX output immediately. Use for:
- **All tables** → the project grid style (see §3): `tabularx` with vertical rules, a coloured
  `tblheader` header row, and `\rowcolors` striping.
- **Diagrams drawable in TikZ** → architecture layers, ETL flow, star/constellation schema fragments,
  layered warehouse stack, SCD-Type-2 illustration, alerting flow, deployment topology, DIKW pyramid,
  BI value chain, parcel lifecycle, use-case diagram, reading map.
- **Charts with representative numbers** → `pgfplots` (mark "illustrative" when numbers are synthetic).

### `[VISUAL-FETCH]` — download a real reference image
A generic textbook illustration to fetch from the web. Use sparingly, mostly in Part I. Output:
- a one-line **caption**,
- a suggested **search query**,
- a note: *download manually and place in `figures/`*.
Examples: generic Kimball star-schema illustration; decision pyramid; a Dagster asset-graph screenshot
(generic). **Do not** embed copyrighted logos beyond the institutional ESI logo.

### `[VISUAL-PLACEHOLDER]` — framed box for a pending visual
For visuals that must come from the **live platform** (dashboard screenshots, real ERD export) or be
**hand-drawn**. Render a framed box containing: *(a)* what it shows, *(b)* how to produce it (screenshot
the running app / draw manually / Claude Design / export from dbdiagram.io), *(c)* the final caption.

### Default preference order
1. `[VISUAL-IMPLEMENT]` for tables, schemas, architecture/flow diagrams (the bulk of the thesis).
2. `[VISUAL-PLACEHOLDER]` for anything depending on the live UI.
3. `[VISUAL-FETCH]` only for generic textbook illustrations in Part I.

---

## 2. The placeholder macro (add once to `config/commands.tex`)
```latex
% Framed placeholder for a pending visual
\usepackage{capt-of}  % if not already loaded, for \captionof
\newcommand{\visualplaceholder}[3]{%
  % #1 = what it shows, #2 = how to produce it, #3 = caption
  \begin{center}
  \fbox{\parbox{0.9\linewidth}{\centering\vspace{1em}
    \textbf{[ VISUAL PLACEHOLDER ]}\\[0.6em]
    \textit{Shows:} #1\\[0.4em]
    \textit{How to produce:} #2\\[1em]}}
  \end{center}
  \captionof{figure}{#3}}
```
Usage:
```latex
\visualplaceholder
  {The Operations sub-page of the Parcel Delivery axis}
  {Screenshot the running platform}
  {Operations dashboard — Parcel Delivery axis}
\label{fig:dash-parcel-ops}
```

---

## 3a. Colour palette (use named colours, never ad-hoc RGB)

Figures and charts should look like they belong to one document. A shared, professional palette is
defined **once** in `config/settings.tex` — always use these named colours in `tikz`/`pgfplots`
instead of writing `\definecolor` inline or forcing `esiblue` everywhere.

> `esiblue` (RGB 0,84,166) is **reserved for logos and the institutional identity** — it is fine in a
> figure, but it is *not* the default diagram colour. For ordinary diagrams reach for **`figblue`**
> (steel blue) as the primary, and bring in the other hues only to carry meaning.

**Core hues** (fills, strokes, bars):

| Name | RGB | Use for |
|---|---|---|
| `figblue` | 70,130,180 | primary / structure (steel blue) |
| `figteal` | 38,166,154 | secondary |
| `figgreen` | 102,187,106 | positive · success · "delivered" |
| `figamber` | 255,167,38 | attention · highlight |
| `figorange` | 210,120,20 | warning · cost · "return" |
| `figslate` | 120,144,156 | neutral · arrows · de-emphasis |

**Pale tints** (light-filled nodes, band backgrounds — pair each with its core hue for text/stroke):

| Name | RGB | Pairs with |
|---|---|---|
| `figbluetint` | 225,238,247 | `figblue` |
| `figgreentint` | 229,245,231 | `figgreen` |
| `figtealtint` | 234,249,244 | `figteal` |
| `figambertint` | 255,243,224 | `figamber` / `figorange` |
| `figlavtint` | 238,232,247 | (lavender accent) |
| `figbluelight` | 232,240,252 | `figblue` |

**Conventions:**
- **Assign colour by meaning, not decoration.** Reuse the same hue for the same idea across the whole
  thesis (e.g. green = success/delivered, orange = cost/return, slate = neutral arrows).
- **Sequence/tiers:** step through `figblue → figteal → figbluetint` (or core hue → its tint) rather
  than inventing three new blues.
- **Contrast:** dark core-hue fill ⇒ white text; pale-tint fill ⇒ the matching core hue as text.
- **Arrows/connectors:** `figslate` (or `black!40`) so coloured nodes stay dominant.
- **Accessibility:** don't rely on colour alone — keep labels/shapes distinct so the figure survives
  greyscale printing. Aim for ≤ 4–5 hues per figure.
- The existing **table** colours (`tblheader`, `tblrowalt`, `tblstruct`, `tblanal`) are unchanged and
  remain the rule for tables (§3).

---

## 3. Figure & table rules (mandatory)
- Every figure/table needs: a `\caption`, a `\label`, and **at least one in-text reference**
  ("Figure 4.2 shows..."). A floating figure no sentence points to is a defect.
- **Tables — use the project grid style** (matches `To-copy/chapter1.tex`; colours `tblheader`,
  `tblrowalt`, `tblstruct`, `tblanal` are defined in `config/settings.tex`). Full-width `tabularx`,
  vertical rules between columns, `\hline` only at the top / under the header / at the bottom, a
  coloured `tblheader` header row in white bold, and automatic `\rowcolors` striping — do **not**
  hand-colour data rows. Template:
  ```latex
  \begin{table}[H]
  \centering
  \renewcommand{\arraystretch}{1.35}
  \rowcolors{2}{white}{tblrowalt}
  \begin{tabularx}{\linewidth}{|>{\raggedright\arraybackslash}p{3cm}|>{\raggedright\arraybackslash}X|>{\raggedright\arraybackslash}X|}
  \hline
  \rowcolor{tblheader}
  \textcolor{white}{\textbf{Col A}} & \textcolor{white}{\textbf{Col B}} & \textcolor{white}{\textbf{Col C}} \\
  \hline
  row & ... & ... \\
  \hline
  \end{tabularx}
  \caption{...}\label{tab:...}
  \end{table}
  ```
  For grouped/sectioned tables, shade sections with `tblstruct` / `tblanal` + `\multirow` instead of
  striping (see the C1 table in `To-copy/chapter1.tex`).
- Diagrams: `tikz` (+ `positioning`, `arrows.meta`); charts: `pgfplots`. Colour them from the shared
  palette in §3a (named `fig*` colours) — no inline `\definecolor`, no forced `esiblue`.
- Caption style: short, descriptive, sentence case. Number by chapter (LaTeX default).
- Keep each visual near its first reference; use `[H]` (the established convention) and fall back to
  `[htbp]` only if a float breaks the page.
- **Density target:** ~1 visual per 1.5–2 pages. If a section has 3+ paragraphs and no visual, ask
  whether a table or diagram would serve better (§0.2).

---

## 4. Figures checklist (maintain as `FIGURES_TODO.md`)
List every `[VISUAL-PLACEHOLDER]` and `[VISUAL-FETCH]` so Achraf has one checklist. Suggested columns:
`ID | chapter | mode | what it shows | how to produce | status`.

### Likely IMPLEMENT (TikZ / pgfplots / grid tables — Claude makes these directly)
- Decision process; decision-types table; decision-levels pyramid; information-needs table; DIKW
  pyramid; IS-type table; BI value chain; star schema; OLAP cube; building-blocks table (Ch.1)
- Three-flows diagram; parcel-lifecycle flow; transport service-types table; analytical-lenses table;
  integration-gap diagram (Ch.2)
- Source-systems table; MoSCoW table; pages→sub-pages map; use-case diagram; project timeline (Ch.3)
- Layered architecture; component table; two-DB routing; warehouse 4-layer stack; constellation
  fragment; techniques table; SCD2 illustration; ETL flow; ETL properties table; alerting flow; RBAC
  table; tech-stack table (Ch.4)
- Deployment topology (Ch.5)
- Simulated-systems table; seasonal-volume chart (illustrative); data-quality checks table; end-to-end
  validation chain (Ch.6)
- Capability-status table (Conclusion)

### Likely FETCH (generic textbook images — Part I)
- Optional generic asset-graph (Ch.4). *(The Ch.1 decision pyramid and star schema are now drawn in
  TikZ — see the IMPLEMENT list — so no longer fetched.)*

### Likely PLACEHOLDER (live platform / hand-drawn — Achraf produces)
- Company-context figure (Ch.3)
- Full DW constellation ERD (Ch.4 → Annexe A)
- Dashboard screenshots: per axis (Transport, Parcel Delivery) × three sub-pages
  (Operations / Cost & Profitability / Performance) (Ch.5) — **NO pricing sub-page**
- Results screenshots: alert firing; populated KPI page (Ch.6)
- Extended dashboard gallery (Annexe B)

---

## 5. Scope reminders that affect visuals
- Dashboard visuals show **two axes** only, each with **three sub-pages** (Operations / Cost &
  Profitability / Performance). **Never draw or label a "Pricing" page/sub-page.**
- The axes are **Dedicated Transport** and **Parcel Delivery** (not "Parcel Cost Control").
- No Route Analysis dashboard visual — it is future work (a row in the capability-status table is fine).
