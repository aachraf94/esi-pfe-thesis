# Decision Support Information System for Logistics Operations and Cost Analysis

> Système d'information décisionnel pour l'analyse des opérations et des coûts logistiques

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

This PFE is carried out in partnership with **Ourquilane**, a logistics company based in Hydra, Alger. The project aims to design and deploy a **Business Intelligence-oriented Decision Support Information System (DSIS)** for logistics management within a multi-site logistics network.

The system centralizes data from heterogeneous sources (internal systems, APIs, historical records) into a **Data Warehouse** as its core, fed by an **ETL pipeline**, and exposes insights through **analytical dashboards** and a **proactive alert mechanism** to support decision-makers.

### Problem Statement

Existing decision support solutions in logistics rarely handle in an integrated way:
- Transport demand tracking and cost analysis
- Parcel-level cost control (Colis Cost Control)
- Decision-oriented visualization and alerting

This project proposes a complete, pragmatic, and scalable BI solution that bridges academic and professional needs, tailored to real logistics constraints at Ourquilane.

### Objectives

- Design and deploy a centralized **Data Warehouse**
- Build a reliable and automated **ETL pipeline**
- Develop interactive **analytical dashboards**
- Implement a **proactive KPI alert mechanism**
- Address hierarchized business needs following MoSCoW prioritization

### Business Scope (MoSCoW)

**Must Have — Transport Demand Management**
- Analysis of expressed transport demands
- Evaluation of associated costs
- Pricing support to measure profitability

**Should Have — Colis Cost Control (CCC)**
- Tracking logistics costs per parcel
- Support for service pricing
- Detection and monitoring of profitability drifts

**Could Have — Tour Analysis**
- Integration with an optimization solver (e.g. Google OR-Tools)
- Comparison between real and optimized delivery tours
- Results as maps and comparative KPI dashboards

### Expected Results

1. **Business Intelligence layer** — Data source exploitation (APIs and existing systems), Data Warehouse design and implementation, ETL pipeline, dynamic dashboards and reports.
2. **Alert system** — Proactive alerts on sensitive KPIs.
3. **Business analysis axes** — Full coverage of the three MoSCoW axes above.

### Keywords

`Business Intelligence` · `Data Warehouse` · `ETL` · `Dashboard` · `Decision Alert` · `Logistics` · `Transport Demand` · `Colis Cost Control (CCC)` · `Pricing`

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
├── config/
│   ├── packages.tex            # All \usepackage{} declarations
│   ├── settings.tex            # Fonts, margins, spacing, colors, headers
│   └── commands.tex            # Custom commands & shortcuts (\fig, \todo, …)
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
│   │   │   ├── chapter1.tex    # Chapter 1: Data-driven Decision Making
│   │   │   └── figures/
│   │   └── chapter2/
│   │       ├── chapter2.tex    # Chapter 2: Logistics
│   │       └── figures/
│   │
│   ├── part2/                  # Part II — Contribution
│   │   ├── part2.tex           # Chapter dispatcher for Part II
│   │   ├── chapter3/
│   │   │   ├── chapter3.tex    # Chapter 3: Analysis & Methodology
│   │   │   └── figures/
│   │   ├── chapter4/
│   │   │   ├── chapter4.tex    # Chapter 4: Design & Architecture
│   │   │   └── figures/
│   │   └── chapter5/
│   │       ├── chapter5.tex    # Chapter 5: Implementation & Results
│   │       └── figures/
│   │
│   └── conclusion.tex          # General Conclusion & Perspectives
│
├── backmatter/
│   └── annexes/
│       ├── annexe_a.tex
│       └── annexe_b.tex
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
  Chapter 1: Data-driven Decision Making
  Chapter 2: Logistics
─────────────────────────────────────────────────────────────────
Part II — Contribution
  Chapter 3: Analysis of the Existing System & Methodology
  Chapter 4: Design & Architecture
  Chapter 5: Implementation & Results
─────────────────────────────────────────────────────────────────
General Conclusion & Perspectives
Bibliography
─────────────────────────────────────────────────────────────────
Annexes
  Annexe A · Annexe B
```

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
