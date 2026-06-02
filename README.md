# Decision Support Information System for Logistics Operations and Cost Analysis

> Système d'information décisionnel pour l'analyse des opérations et des coûts logistiques
>
> Codename: **LOGIQ**

---

## Part 1 — The Project (PFE)

### Identification

| | |
|---|---|
| **Thesis code** | 26/2852 |
| **Specialties** | Systèmes Intelligents et Données (SID) · Systèmes d'Information et Technologies (SIT) |
| **Academic year** | 2025 / 2026 |
| **Institution** | École Nationale Supérieure d'Informatique (ESI), Oued Smar, Alger |
| **Author** | ABDELKEBIR Achraf · Matricule: 21/0298 · la_abdelkebir@esi.dz |
| **Academic supervisor** | Mr. ABBAS Mohamed Amir (ESI) |
| **Company supervisor** | Mrs. RIHANE Yasmine · Ourquilane, Hydra, Alger · yasmine.rihane.ourquilane@gmail.com |

---

### Context

This PFE is carried out in partnership with **Ourquilane**, a logistics company based in Hydra, Alger. The project designs and deploys **LOGIQ**, a **Business Intelligence-oriented Decision Support Information System (DSIS)** for logistics management within a multi-site logistics network operating across Algeria.

The system centralizes data from heterogeneous internal source systems into a **Data Warehouse** as its core, fed by an automated **ETL pipeline**, and exposes insights through **analytical dashboards** and a **proactive alert mechanism** to support decision-makers.

### Problem Statement

Existing decision support solutions in logistics rarely handle in an integrated way:
- On-demand / dedicated transport demand tracking and cost analysis
- Parcel-delivery operations, cost, and performance monitoring
- Decision-oriented visualization and proactive alerting

This project proposes a complete, pragmatic, and scalable BI solution that bridges academic and professional needs, tailored to real logistics constraints at Ourquilane.

### Objectives

- Design and deploy a centralized **Data Warehouse**
- Build a reliable and automated **ETL pipeline**
- Develop interactive **analytical dashboards**
- Implement a **proactive KPI alert mechanism**
- Address hierarchized business needs following MoSCoW prioritization

### Business Scope (MoSCoW)

The platform delivers **two business axes**, treated as **two financially independent perimeters** — they share operational infrastructure (staff, agencies, delivery centres) but their costs and revenues are never mixed.

**Must Have — On-Demand / Dedicated Transport (B2B)**
- Dedicated transport in three service types: *Dedicated Trip*, *Courier*, *Handling*
- Analysis of expressed demand and evaluation of associated cost
- Cost & profitability monitoring

**Should Have — Parcel Delivery (classic e-commerce express)**
- Monitoring of the parcel lifecycle at scale
- Logistics cost and profitability tracking per the parcel perimeter
- Operational and performance monitoring

**Could Have — Route Analysis** *(future work)*
- Integration with a route-optimization solver (e.g. Google OR-Tools)
- Comparison between actual and optimized routes
- Results as maps and comparative KPI tables
- *Deferred to future work: the route/trajectory data and optimization reference it requires were not available within the project scope. The warehouse's geographic dimensions are designed to support this extension later.*

Each delivered axis is exposed as **one dashboard page with three sub-pages**: **Operations**, **Cost & Profitability**, **Performance**. The interface also includes an **Overview** page, an **Alerts** page, **user settings**, and an **Administration** module, with navigation filtered by the user's role (RBAC).

### Expected Results

1. **Business Intelligence layer** — Data source exploitation (APIs and existing systems), Data Warehouse design and implementation, ETL pipeline, dynamic dashboards and reports.
2. **Alert system** — Proactive, multi-channel alerts on sensitive KPIs.
3. **Business analysis axes** — Full coverage of the two delivered MoSCoW axes above.

### Keywords

`Business Intelligence` · `Data Warehouse` · `ETL` · `Dashboard` · `Decision Alert` · `Logistics` · `On-Demand Transport` · `Parcel Delivery` · `RBAC`

### Timeline

| Period | Milestone |
|---|---|
| Oct 2025 – Dec 2025 | Analysis and study of the existing situation |
| Jan 2026 – Feb 2026 | Solution design |
| Mar 2026 – May 2026 | Development, deployment, and testing |
| Jun 2026 | Technical documentation and user manual |

> Thesis writing started February 2026 and runs in parallel with the project.

### References

- Kimball, R., & Ross, M. (2013). *The Data Warehouse Toolkit.* Wiley.
- Inmon, W. H. (2005). *Building the Data Warehouse.* Wiley.
- Vassiliadis, P. (2009). A Survey of Extract–Transform–Load Technology. *IJDWM*, 5(3), 1–27.
- Few, S. (2006). *Information Dashboard Design.* O'Reilly.
- Hofmann, E., & Rüsch, M. (2017). Industry 4.0 and logistics. *Computers in Industry*, 89, 23–34.
- Chaudhuri, S., Dayal, U., & Narasayya, V. R. (2011). An Overview of BI Technology. *Communications of the ACM*, 54(8), 88–98.
- Günther, H.-O., & Tempelmeier, H. (2007). *BI in Logistics and Supply Chain Management.* Springer.
- Wang, Y., & Alexander, A. (2016). Dynamic Pricing and Revenue Management in Logistics. *IJLM*, 27(2), 345–367.
- Bose, R. (2008). Advanced Analytics. *Industrial Management & Data Systems*, 108(3), 314–338.
- Google OR-Tools (2024). *Open Source Optimization Tools.*

---

## Part 2 — The Thesis (LaTeX)

### Writing Guides (`guide/`)

The manuscript is written following a set of guides that hold the authoritative scope, structure, and
style rules. **Read these before editing any chapter** (recommended order: `00` → `03` → `02` → `01`).

| File | Purpose |
|---|---|
| `guide/00_README_pfe_guide.md` | Master / global rules: language, readability, corrected scope, references (APA), page budget, LaTeX hygiene, writing order, do-not list |
| `guide/01_state-of-the-art_guide.md` | Part I — Chapter 1 (Data-Driven Decision Making) and Chapter 2 (Logistics) |
| `guide/02_contribution_guide.md` | Part II — Chapters 3–6, General Introduction, General Conclusion, appendices |
| `guide/03_visuals_guide.md` | Visual system (the three visual modes), the `\visualplaceholder` macro, figure rules, figures checklist |
| `guide/thesis-technical-recap.md` | High-level technical recap of the built solution — source of truth for Part II |
| `guide/thesis.md` | Original Final-Year-Project information form (reference) |

> **Authoritative scope note.** Where older descriptions mention *"Parcel Cost Control"* as a delivered
> axis, the delivered realisation treats **Parcel Delivery** (classic e-commerce express). The
> delivered axes are **On-Demand Dedicated Transport** and **Parcel Delivery**; each dashboard page has
> three sub-pages — **Operations / Cost & Profitability / Performance** (there is **no Pricing page**).
> See `guide/00_README_pfe_guide.md` §0.5.

### Repository Structure

```
esi-pfe-thesis/
│
├── main.tex                    # Master file — ties everything together
├── references.bib              # Bibliography (BibTeX / Biber)
├── .gitignore                  # Ignores build/ and out/ artefacts
├── .latexmkrc                  # Compiler configuration (XeLaTeX + Biber)
├── README.md                   # This file
│
├── guide/                      # Writing guides & source-of-truth documents
│   ├── 00_README_pfe_guide.md      # Master / global rules
│   ├── 01_state-of-the-art_guide.md # Part I writing guide
│   ├── 02_contribution_guide.md     # Part II writing guide
│   ├── 03_visuals_guide.md          # Visual system & figures checklist
│   ├── thesis-technical-recap.md    # Technical recap (source of truth for Part II)
│   └── thesis.md                    # Original PFE information form (reference)
│
├── config/
│   ├── packages.tex            # All \usepackage{} declarations
│   ├── settings.tex            # Fonts, margins, spacing, colors, headers
│   └── commands.tex            # Custom commands & shortcuts (\fig, \todo, \visualplaceholder, …)
│
├── frontmatter/
│   ├── cover.tex               # Title page
│   ├── dedication.tex          # Dedication
│   ├── acknowledgements.tex    # Acknowledgements
│   ├── abstract_en.tex         # Abstract (English)
│   ├── abstract_fr.tex         # Résumé (French)
│   ├── abstract_ar.tex         # ملخص (Arabic)
│   └── abbreviations.tex       # List of Abbreviations
│
├── mainmatter/
│   ├── introduction.tex        # General Introduction
│   │
│   ├── part1/                  # Part I — State of the Art
│   │   ├── part1.tex           # Chapter dispatcher for Part I
│   │   ├── chapter1/
│   │   │   ├── chapter1.tex    # Chapter 1: Data-Driven Decision Making
│   │   │   └── figures/
│   │   └── chapter2/
│   │       ├── chapter2.tex    # Chapter 2: Logistics
│   │       └── figures/
│   │
│   ├── part2/                  # Part II — Contribution
│   │   ├── part2.tex           # Chapter dispatcher for Part II
│   │   ├── chapter3/
│   │   │   ├── chapter3.tex    # Chapter 3: Analysis of the Existing System & Methodology
│   │   │   └── figures/
│   │   ├── chapter4/
│   │   │   ├── chapter4.tex    # Chapter 4: Design & Architecture
│   │   │   └── figures/
│   │   ├── chapter5/
│   │   │   ├── chapter5.tex    # Chapter 5: Implementation & Deployment
│   │   │   └── figures/
│   │   └── chapter6/          # (planned — not yet created)
│   │       ├── chapter6.tex    # Chapter 6: Testing, Validation & Results
│   │       └── figures/
│   │
│   └── conclusion.tex          # General Conclusion & Perspectives
│
├── backmatter/
│   └── annexes/
│       ├── annexe_a.tex        # Annexe A: full DW schema & table inventory
│       └── annexe_b.tex        # Annexe B: dashboard gallery, alert rules, data-quality checks, deployment
│
├── assets/
│   ├── logos/                  # ESI logo and other institutional logos
│   └── global-figures/         # Figures shared across chapters
│
├── build/                      # Auto-generated — all compilation artefacts
└── out/                        # Final PDF output (out/main.pdf)
```

### Document Order

```
Cover · Dedication · Acknowledgements · Abstract (EN / FR / AR)
Table of Contents · List of Figures · List of Tables · List of Abbreviations
─────────────────────────────────────────────────────────────────
General Introduction
─────────────────────────────────────────────────────────────────
Part I — State of the Art
  Chapter 1: Data-Driven Decision Making
  Chapter 2: Logistics
─────────────────────────────────────────────────────────────────
Part II — Contribution
  Chapter 3: Analysis of the Existing System & Methodology
  Chapter 4: Design & Architecture
  Chapter 5: Implementation & Deployment
  Chapter 6: Testing, Validation & Results
─────────────────────────────────────────────────────────────────
General Conclusion & Perspectives
Bibliography
─────────────────────────────────────────────────────────────────
Annexes
  Annexe A · Annexe B
```

> **Page budget:** 110 pages (body) + 15 pages (appendix) = 125 pages maximum. Visuals, charts, and
> tables are preferred over dense prose throughout. See `guide/00_README_pfe_guide.md` §0.6.

### Prerequisites

- [MiKTeX](https://miktex.org/) with XeLaTeX and `latexmk`
- Windows fonts installed: **Times New Roman**, **Arial**, **Courier New**

> This project requires **XeLaTeX** — standard `pdflatex` will not work due to `fontspec` and `polyglossia` (Arabic support).

### Build

```bash
# Full build (xelatex → biber → xelatex → xelatex), handled automatically
latexmk main
```

Output: `out/main.pdf` · Auxiliary files: `build/`

### Clean build artifacts

```bash
latexmk -C main
```

### VS Code (LaTeX Workshop)

The `.latexmkrc` at the root configures the engine automatically.

1. Install the **LaTeX Workshop** extension
2. Open `main.tex`
3. Use `Ctrl+Alt+B` to build — the extension picks up `.latexmkrc` automatically
