# Figures to Source — Tracker

One checklist of every visual that is **not** auto-generated LaTeX, i.e. every `[VISUAL-PLACEHOLDER]`
(live-platform / hand-drawn) and `[VISUAL-FETCH]` (download a generic reference image). `[VISUAL-IMPLEMENT]`
items (TikZ / pgfplots / grid tables) are produced inline and are **not** tracked here.

Status legend: ☐ to do · ◐ in progress · ☑ done.

## Active (already rendered as a placeholder/fetch in the `.tex`)

| ID | Chapter | Mode | What it shows | How to produce | Status |
|----|---------|------|---------------|----------------|--------|
| C3-P3 | Ch.3 §3.2 | FETCH | Parcel lifecycle (`fig:ch3-parcel-lifecycle`) — six-stage forward flow Pickup → … → Delivery + reverse-return branch | Author-provided diagram embedded as `Parcel Lifecycle 1.png` | ☑ |
| C4-F1 | Ch.4 §4.2 | FETCH | Functional architecture (`fig:ch4-funcarch`) — one-directional value chain: sources → processing → consolidation → {presentation, alerts} → decision-maker | Author-provided diagram embedded as `functional-architecture.png` | ☑ |
| C4-P3 | Ch.4 §4.4 | IMPLEMENT/asset | LOGIQ brand logo (`fig:ch4-logiq-logo`) — light/primary + dark/reverse variants | Author-provided, embedded as `logos.png` | ☑ |
| C4-F2 | Ch.4 §4.4.2 | FETCH/asset | Global architecture — end-to-end data flow (operational stores → source platforms → APIs → ETL/Dagster → stores → services → dashboard); full landscape page | Author-provided diagram embedded as `global-architecture.png` | ☑ |
| C4-P2 | Ch.4 §4.6 (ETL) | FETCH/PLACEHOLDER | Asset (lineage) dependency graph (`fig:ch4-etl-lineage`) — each warehouse table as a node with edges to upstream assets | download generic asset-graph image OR screenshot the running orchestrator | ☐ |
| C5-P2 | Ch.5 §5.2.1 | PLACEHOLDER | Warehouse schema in pgAdmin by layer (`fig:ch5-pgadmin`) — staging / dimensions / facts / materialised-view panels | Author-provided pgAdmin screenshots embedded (`stg_tables_pgadmin4.png`, `Dim_tables_pgadmin4.png`, `fact_tables_pgadmin4.png`, `materialised_views_pgadmin4.png`) | ☑ |
| C5-P3 | Ch.5 §5.2.1 | PLACEHOLDER | `dim_employee` SCD Type 2 (`fig:ch5-scd2`) — surrogate key + `valid_from`/`valid_to` + `is_current` | Author-provided ERD screenshot embedded as `dim_employee_scd2.png` | ☑ |
| C5-P4 | Ch.5 §5.2.2 | PLACEHOLDER | Dagster asset graph by layer (`fig:ch5-asset-graph`) — staging → dimensions → facts → aggregates | Author-provided screenshot embedded as `stg_dim_fact_agg.png` | ☑ |
| C5-P5 | Ch.5 §5.2.2 | PLACEHOLDER | `fact_parcel_revenue` input/output lineage (`fig:ch5-lineage`) | Author-provided screenshot embedded as `fact_parcel_revenue_lineage.png` (renamed from spaced filename) | ☑ |
| C5-P6 | Ch.5 §5.2.3 | PLACEHOLDER | Dagster automation (`fig:ch5-automation`) — daily 01:00 UTC schedule + completion sensor | Author-provided screenshot embedded as `automation_dagster_scrennshot.png` | ☑ |
| C5-P1 | Ch.5 §5.5 | PLACEHOLDER | Dashboard screenshots — Parcel (`fig:ch5-dash-parcel`) & Transport (`fig:ch5-dash-transport`) axis pages, each × 3 views; **most valuable figures** | screenshot the running platform | ☐ |
| C6-P1 | Ch.6 §6.6 | PLACEHOLDER | Results screenshots — populated KPI page (`fig:ch6-result-kpi`) + alert firing (`fig:ch6-result-alert`) | screenshot the running platform | ☐ |
| C5-L1 | Ch.5 §5.1 | FETCH | Technology-stack logos in `tab:ch5-stack` (one PNG per technology, rendered via `\techlogo`) | download official logos as PNG into `assets/logos/tech/` — exact filenames listed in that folder's `README.md`. Missing files render a subtle text stub, so the build is never broken | ☑ |

## Planned (from `guide/02_contribution_guide.md` / `guide/03_visuals_guide.md` — not yet in the `.tex`)

| ID | Chapter | Mode | What it shows | How to produce | Status |
|----|---------|------|---------------|----------------|--------|
| C3-F1 | Ch.3 §3.1 | IMPLEMENT/asset | Ourquilane logo (`logo_dark.png`, `fig:ch3-ourquilane-logo`) | supplied & embedded | ☑ |
| C3-F2 | Ch.3 §3.1 | IMPLEMENT/asset | Yalidine logo (`Yalidine_logo.png`, `fig:ch3-yalidine-logo`) | supplied & embedded | ☑ |
| C3-P1 | Ch.3 §3.1 | PLACEHOLDER | Ourquilane organisation chart (organigramme) + company-context / network-position figure | Claude Design / PowerPoint | ☐ |
| C3-P2 | Ch.3 §3.3 | PLACEHOLDER | Use-case diagram (UML) — *only if drawn instead of TikZ* | draw.io / hand-drawn | ☐ |
| C4-P1 | Annexe A §A.4 | ~~PLACEHOLDER~~ → IMPLEMENT | Full DW constellation ERD (`fig:anx-dw-erd`) — 7 facts + 56 dims, colour-coded, landscape page | **Done as TikZ** in `annexe_a.tex` (no external export needed) | ☑ |
| AX-P1 | Annexe B | PLACEHOLDER | Extended dashboard gallery | screenshot the running platform | ☐ |
