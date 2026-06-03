# 00 — LOGIQ Thesis Writing Guide (Master / Global Rules)

> **What this is.** The master file of a 4-part writing guide for the PFE manuscript
> *"Decision Support Information System for the Analysis of Logistics Operations and Costs."*
> Hand all four files to Claude CLI. This file holds the **global rules that apply to every chapter**.
> The other three files hold chapter-by-chapter instructions.

## The guide set
| File | Covers |
|---|---|
| `00_README_pfe_guide.md` | **(this file)** global rules: language, scope, references, length, LaTeX hygiene, writing order |
| `01_state-of-the-art_guide.md` | Part I — Ch.1 (Data-Driven Decision Making), Ch.2 (Logistics in the Data Age) |
| `02_contribution_guide.md` | Part II — Ch.3–Ch.6, General Intro & Conclusion |
| `03_visuals_guide.md` | the visual system, tags, the placeholder macro, and the figures checklist |

**Read order for Claude CLI:** `00` → `03` (so the visual rules are known) → `02` → `01`.

---

## 0. GLOBAL RULES (apply to EVERY chapter)

### 0.1 Language & tone
- **English**, clear and simple academic register. Short sentences. One idea per sentence.
- **No complicated vocabulary, no flowery prose.** Prefer "uses" over "leverages", "build" over
  "architect", "shows" over "elucidates".
- Define every acronym on first use: *Business Intelligence (BI)*, then "BI" thereafter.
- Neutral third-person voice ("the platform", "the solution", "this work"). Avoid "I". "We" is fine
  sparingly for design decisions.
- Pick **British spelling** (to match the technical recap: "optimise", "modelling") and stay consistent.

### 0.2 Readability & structure — NO dense walls of text
**Dense prose blocks are not acceptable where the reader needs scannable structure.** Apply this on
every page:
- **Cap paragraphs at ~4–6 lines.** If a paragraph grows past that, split it or convert part of it
  into a list or a table.
- After at most **2–3 paragraphs of prose, break the rhythm** with one of: a bulleted list, a
  `booktabs` table, a figure, or a short subsection heading.
- Use lists for: enumerations, options, properties, steps, requirements, comparisons.
- Use tables for: anything with 2+ columns of structured facts (technique→why, system→domain,
  property→rationale, role→access).
- Each `\section` opens with **1–2 sentences** stating what the section does, then dives in — no long
  preamble.
- Prefer "lead sentence + list/table" over "long explanatory paragraph". Visuals and scannable
  structure are **always preferable** to thick prose (see `03_visuals_guide.md`).
- Never write more than ~½ page of uninterrupted prose without a list, table, figure, or subheading.

### 0.3 Referencing — APA 7th
- In-text: `(Kimball & Ross, 2013)`; narrative: `Kimball and Ross (2013) argue that...`.
- Every theoretical/factual claim in Part I must carry a citation.
- Reference list = APA-7, alphabetical by author. Seed bibliography = the entries already in
  `thesis.md` / `README.md`.
- Use `biblatex` with `style=apa` (repo is XeLaTeX + Biber). Every `\cite{key}` must resolve to a
  `references.bib` entry — when you cite something new, **append its BibTeX entry in the same edit**.
- **Never fabricate sources.** Missing citation → write the sentence and add
  `% TODO(achraf): add citation`. Never invent an author/year.

### 0.4 Confidentiality / scope rule (READ CAREFULLY)
- **Route Analysis is simply out of scope for this version.** Frame it as a *"Could have"* axis
  deferred to future work because the routing/optimisation-reference data was not available within the
  project scope.
- Do **NOT** write "GPS data is confidential", do **NOT** speculate about why data is missing, do
  **NOT** imply the company withheld anything. Neutral phrasing:
  > *"Route Analysis was positioned as a 'Could have' axis. It is left as future work because the
  > route/trajectory data and the optimisation reference it requires were not available within the
  > project scope. The warehouse's geographic dimensions were nonetheless designed to support this
  > extension without restructuring (see Future Work)."*
- It appears in exactly **two places**: one neutral line in the scope/MoSCoW section, and the Future
  Work section. Nowhere else. Do not foreground it.

### 0.5 Business scope — THE CORRECTED, AUTHORITATIVE VERSION
> This supersedes the old README/thesis.md scope. The MoSCoW *plan* mentioned "On-Demand Dedicated
> Transport + Parcel Cost Control"; the **delivered realisation** treats two axes:

The platform delivers **two business axes**, handled as **two financially independent perimeters**
(shared operational infrastructure — staff, agencies, delivery centres — but **costs and revenues are
never mixed**):

1. **On-Demand / Dedicated Transport** (Yalidine El Djazair Services, **B2B**) — dedicated transport
   in three service types: **Dedicated Trip, Courier, Handling**. Analyse expressed demand and evaluate
   associated cost & profitability.
2. **Parcel Delivery** — **classic e-commerce express parcel delivery**: the standard parcel lifecycle
   from creation to final resolution, at scale.

**Could have — Route Analysis:** future work (see §0.4).

**Dashboard structure — IMPORTANT (corrected):** each of the two axes has **one page** with exactly
**three sub-pages**:
- **Operations**
- **Cost & Profitability**
- **Performance**

There is **NO Pricing sub-page** anywhere. Do not mention a pricing page, pricing dashboard, or
pricing sub-section in the realisation. (Pricing as a general logistics *concept* may still appear in
the Part I literature, but the built platform has no pricing page.)

Plus, outside the two axes: an **Overview** page, an **Alerts** page, **user settings**, and an
**Administration** module (users, roles, pipeline governance). Navigation is filtered by the user's
**role** (RBAC).

> Quick consistency check for Claude CLI: anywhere the old text says "Parcel Cost Control (PCC)" as a
> *delivered axis*, replace with **"Parcel Delivery"**. Anywhere a "Pricing" sub-page/section is
> implied in the realisation, **remove it**. Keep the three sub-pages: Operations / Cost & Profitability
> / Performance.

### 0.6 Length discipline (HARD CAP: 110 body pp + 15 appendix pp = 125)
Stay within budget. Targets:

| Section | Target pp |
|---|---|
| General Introduction | 3–4 |
| **Part I — State of the Art** | **~30** |
| Ch.1 Data-Driven Decision Making | 16–18 |
| Ch.2 Logistics in the Data Age | 12–14 |
| **Part II — Contribution** | **~70** |
| Ch.3 Analysis & Methodology | 14–16 |
| Ch.4 Design & Architecture | 22–26 |
| Ch.5 Implementation & Deployment | 18–22 |
| Ch.6 Testing, Validation & Results | 14–18 |
| General Conclusion & Perspectives | 3–4 |
| **Appendices (separate budget)** | **≤15** |

Visuals count toward pages → visual-dense means **tighter prose** (§0.2 helps). Aim ~1 visual per
1.5–2 pages. If a chapter overruns, compress Ch.4/Ch.5 prose first and push detail to appendices —
never silently cut required content.

### 0.7 Chapter structure (every chapter)
- New `chapterN.tex` per chapter under its folder, figures under each chapter's `figures/`.
- Add `chapter6/` for the new chapter; register it in `part2.tex` and `main.tex`.
- Headings: `\chapter` → `\section` → `\subsection`; avoid going deeper than `\subsubsection`.
- Each chapter opens with a 3–5 line **intro** (what the chapter does) and closes with a 3–5 line
  **conclusion/transition** (what's established + bridge to next chapter).
- After writing each chapter, run the self-check below and fix before moving on.

### 0.8 Per-chapter self-check (run every time)
- Language simple, no jargon creep?
- No paragraph over ~6 lines; prose broken up by lists/tables/figures per §0.2?
- Scope correct: two axes = Transport + Parcel Delivery; three sub-pages; **no Pricing page**?
- Route Analysis only in the two allowed places, neutral phrasing?
- Every figure/table has a `\label`, caption, and an in-text reference?
- Every `\cite` resolves to a `references.bib` entry?
- Within the page budget?
- `latexmk main` compiles clean?

---

## 1. SOURCES OF TRUTH
- **Technical content (Part II):** `thesis-technical-recap.md` (+ the `docs/` design docs:
  `dw-doc.md`, `etl-dagster-doc.md`, `mock-data-doc.md`, `architecture.md`, `deployment.md`).
- **Do not exceed the recap.** No invented endpoints, exact schemas, code, or numbers. Mark unknowns
  with `% TODO(achraf): confirm`.
- Some counts differ slightly between `docs/` files — Achraf should fix one canonical set of numbers
  before final quoting; until then use qualitative figures + `% TODO`.

---

## 2. WRITING ORDER FOR CLAUDE CLI
1. Read `03_visuals_guide.md`; add the `\visualplaceholder` macro to `config/commands.tex`; confirm
   `biblatex apa` is configured.
2. Create `mainmatter/part2/chapter6/`; register in `part2.tex` and `main.tex`.
3. Write Part II first (recap fully grounds it): **Ch.3 → Ch.4 → Ch.5 → Ch.6** — see
   `02_contribution_guide.md`.
4. Write Part I: **Ch.1 → Ch.2** — see `01_state-of-the-art_guide.md`. Append each new source to
   `references.bib` as you cite it.
5. Write **General Introduction** and **General Conclusion** (in `02_...`), then the three abstracts
   (EN/FR/AR) last, from the finished intro + conclusion.
6. Maintain a running `FIGURES_TODO.md` listing every `[VISUAL-PLACEHOLDER]` and `[VISUAL-FETCH]`.
7. After each chapter: §0.8 self-check + trial compile.

## 3. DO-NOT LIST (quick reference)
- No GPS / confidential / withheld-data mentions. Route Analysis = future work, data not available in
  scope.
- No "Parcel Cost Control" as a delivered axis → it's **Parcel Delivery**.
- No **Pricing** sub-page/section in the realisation.
- No dense prose walls (§0.2).
- No invented endpoints, schemas, code, authors, or numbers (`% TODO` instead).
- No complicated language.
- No exceeding 110 body / 15 appendix pages.
- No uncited figure; no `\cite` without a `references.bib` entry.
- Never mix transport and parcel finances.
- Don't introduce "simulation" before Ch.6 — in Ch.3 the five systems are the real source systems.
