# 02 — Contribution Guide (Part II + General Intro/Conclusion)

> Covers the **General Introduction**, **Ch.3–Ch.6**, and the **General Conclusion**. Read
> `00_README_pfe_guide.md` and `03_visuals_guide.md` first. Source of truth = `thesis-technical-recap.md`
> (+ `docs/`). Stay at **design / general-aspects** level — no code dumps, no invented detail. Apply the
> no-dense-prose rule (§0.2): short paragraphs, frequent lists/tables/figures.

> **Scope reminder (corrected — §0.5):** two delivered axes = **On-Demand Dedicated Transport** (B2B;
> Dedicated Trip / Courier / Handling) and **Parcel Delivery** (classic e-commerce express). Each axis
> page has **three sub-pages: Operations / Cost & Profitability / Performance** — **NO Pricing page**.
> Route Analysis = future work (neutral framing).

---

## GENERAL INTRODUCTION (3–4 pp)
Five short movements (≤1 short paragraph each, plus the objectives as a list):
1. **Context** — logistics in Algeria is data-rich but the data is scattered; decision-makers lack a
   unified, reliable view of operations and costs.
2. **Problem** — existing solutions rarely integrate transport-demand analysis, parcel monitoring, and
   decision-oriented visualisation in one place.
3. **Objectives (list)** — centralised Data Warehouse; reliable automated ETL; interactive dashboards;
   proactive alerting.
4. **Contribution & host** — LOGIQ, built with **Ourquilane** (Hydra, Alger): a full-stack open-source
   BI platform on the two business axes.
5. **Manuscript structure** — one sentence per chapter; end with a transition to Part I.
- `[VISUAL-IMPLEMENT]` (optional) a small TikZ "reading map" of the manuscript.

---

## CHAPTER 3 — Analysis of the Existing System & Methodology (14–16 pp)

### 3.0 Introduction
### 3.1 Host organisation
- Ourquilane (Hydra, Alger); the logistics activity; the multi-site network.
- `[VISUAL-PLACEHOLDER]` company-context figure → *Shows:* position in the parcel + transport network.
  *Produce:* Claude Design / PowerPoint.

### 3.2 Study of the existing situation
- The scattered source systems and the analytical gap; what decision-makers cannot do today.
- Present the **five internal source systems** at a **functional** level — *what each provides*, not
  internals. **Describe them as the real source systems** (simulation is introduced only in Ch.6).
- `[VISUAL-IMPLEMENT]` `booktabs` table: source system → domain it provides:
  - Core logistics system → geography, delivery centres, pricing grid, full parcel-event history
  - HR system → companies, agencies, employees, org hierarchy
  - Cash-box system → operating expenses, freelance-driver payments, reimbursements, transfers
  - Payroll system → monthly payslips
  - Transport system → dedicated B2B transport requests and their stops

### 3.3 Problem statement & requirements
- Restate the integration gap; derive functional requirements (short list).

### 3.4 Business scope & MoSCoW (corrected)
- **Must have — On-Demand Dedicated Transport** (B2B; Dedicated Trip / Courier / Handling).
- **Should have — Parcel Delivery** (classic e-commerce express).
- **Could have — Route Analysis** → one neutral line: future work, data not available in scope (§0.4).
- State the **two-independent-financial-perimeters** principle (costs/revenues never mixed).
- `[VISUAL-IMPLEMENT]` MoSCoW table (priority → axis → what it delivers).

### 3.5 Functional requirements
- The **two axis pages**, each with **three sub-pages: Operations / Cost & Profitability /
  Performance** (NO pricing). Plus Overview, Alerts, Settings, Administration.
- The **user/role model (RBAC)**: users imported from HR, activated by a super-admin, each assigned a
  role that controls dashboard access.
- `[VISUAL-IMPLEMENT]` use-case diagram (TikZ) **OR** `[VISUAL-PLACEHOLDER]` for a drawn UML.
- `[VISUAL-IMPLEMENT]` a small map of pages → sub-pages (tree/table) to make the structure scannable.

### 3.6 Methodology
- Development approach (iterative); the project timeline (from `thesis.md` schedule); tools.
- `[VISUAL-IMPLEMENT]` Gantt-style timeline (`pgfgantt` or a simple table).

### 3.7 Conclusion & transition to Design.

---

## CHAPTER 4 — Design & Architecture (22–26 pp) — heart of the thesis

### 4.0 Introduction
### 4.1 Global architecture
- Layered, service-oriented; **one-directional** data flow; **operational vs analytical** plane split.
- Component view: sources → integration (ETL) → storage (DW + operational DB) → application (REST API)
  → presentation (web dashboard); + a **message broker / cache** for background work.
- `[VISUAL-IMPLEMENT]` **layered architecture** TikZ diagram — *the single most important figure;
  make it clean and central.*
- `[VISUAL-IMPLEMENT]` `booktabs` component table (layer → component → role).

### 4.2 Two-database principle
- Operational DB (identity, roles, notifications, alert rules, ETL run history) vs analytical DW (all
  decision-support queries); the backend **transparently routes** queries; why (isolate heavy
  analytics, keep each store optimised, standard BI practice).
- `[VISUAL-IMPLEMENT]` small TikZ figure of the routing decision.

### 4.3 Data warehouse design (~8–10 pp — biggest section)
- **Layered design** — staging → dimensions → facts → aggregates (recap §4.1).
  - `[VISUAL-IMPLEMENT]` TikZ four-layer stack (role of each layer labelled).
- **Schema paradigm** — **constellation (fact-constellation)** schema + **snowflaked** dimensions; the
  *"no redundant data"* rule; controlled, justified denormalisation as the only exception (§4.2).
  - `[VISUAL-IMPLEMENT]` TikZ **constellation fragment**: 2 fact tables sharing conformed dimensions
    (time, geography, organisation, agency). Readable, not exhaustive.
  - `[VISUAL-PLACEHOLDER]` full DW ERD → *Shows:* complete constellation model. *Produce:* export from
    dbdiagram.io / draw.io using `docs/dw-doc.md`. (Move the full ERD to Annexe A.)
- **Advanced modelling techniques** — short subsection each, *what it is + where used here* (recap §4.3):
  - Conformed dimensions; **SCD Type 2** (agencies, employees) with surrogate key + validity window;
    junk dimensions (transport flags); role-playing dimensions (departure/arrival; date roles);
    natural vs surrogate keys; the **two financial perimeters**.
  - `[VISUAL-IMPLEMENT]` `booktabs` techniques table (technique → where/why).
  - `[VISUAL-IMPLEMENT]` small TikZ **SCD Type 2** illustration (old row + new row + validity dates).
- **Scale** — production-scale dimensioning (hundreds of millions of parcel-status events) justifying
  aggregates + incremental loading (§4.4). Qualitative figures; exact counts `% TODO`.

### 4.4 ETL pipeline design (~4–5 pp)
- **Asset-oriented orchestration** & lineage (each warehouse table = a data asset with declared deps).
- **Five stages** mapped onto the layers: extract → stage → transform/load dimensions → load facts →
  refresh aggregates.
- **Engineering properties**: incremental extraction; idempotent loads (insert-or-update); resilience
  (retry + exponential backoff); scheduling (nightly full + lighter dimension refresh); observability
  (lifecycle events to backend); **source decoupling** (depends only on the API contract).
- `[VISUAL-IMPLEMENT]` TikZ **ETL flow** (stages → layers).
- `[VISUAL-IMPLEMENT]` `booktabs` properties table (property → rationale).
- `[VISUAL-FETCH]` generic asset-graph illustration **OR** `[VISUAL-PLACEHOLDER]` real Dagster
  asset-graph screenshot.

### 4.5 Alerting design
- Threshold **rules** (metric, operator, threshold, severity, cooldown); scheduled evaluation by a
  background worker; **multi-channel** delivery (in-app + email, per-user preference); pipeline
  notifications surfaced through the same machinery (closes the loop).
- `[VISUAL-IMPLEMENT]` TikZ flow: rule → scheduled check → threshold crossed → alert → channel fan-out.

### 4.6 Security & access design
- Stateless token auth (rotation + revocation on logout); **RBAC** mapping roles → dashboard sections.
- `[VISUAL-IMPLEMENT]` small RBAC table (role → accessible sections).

### 4.7 Technology stack
- The open-source stack (recap §3) with one-line justification each; emphasise **free / open-source /
  no licensing cost**.
- `[VISUAL-IMPLEMENT]` `booktabs` stack table (concern → technology):
  FastAPI+PostgreSQL (source simulation, test) · Dagster (ETL) · PostgreSQL (DW + operational) ·
  Django + DRF (backend) · Celery + Redis (background) · Next.js/React/TS (frontend) ·
  ECharts/D3.js/Leaflet/Tremor (viz) · Docker Compose + Nginx + Let's Encrypt (deploy).

### 4.8 Conclusion & transition to Implementation.

---

## CHAPTER 5 — Implementation & Deployment (18–22 pp)
> From *how it was designed* to *how it was built and shipped*. General-aspects level; tiny snippets
> only if they clarify (≤10 lines, `listings`). No full code.

### 5.0 Introduction
### 5.1 Backend implementation
- REST API responsibilities: auth/session, RBAC authorisation, **read-only** analytics services over
  the **aggregate layer**, administration, alert engine.
- Transparent operational/analytical routing; **graceful degradation** of analytics endpoints (fall
  back to representative demo data when the warehouse is unavailable).
- `[VISUAL-PLACEHOLDER]` (optional) request-flow diagram.

### 5.2 Warehouse & ETL implementation
- How the four layers + asset graph were realised; nightly full refresh + lighter dimension refresh;
  lifecycle events emitted to the backend.

### 5.3 Alerting implementation
- Background worker evaluating active rules; notification machinery; per-user channel preferences.

### 5.4 Frontend / dashboard implementation
- Single-page dashboard; organised by the **two axes**, each with **Operations / Cost & Profitability /
  Performance** (NO pricing) + Overview + Alerts + Settings + Admin; **role-filtered navigation**.
- **Visualisation toolkit**: statistical charts (line, area, bar, stacked bar, pie/donut, scatter,
  heatmap, gauge, radar, Sankey); custom data-driven cost-flow/network diagrams; **interactive maps**;
  **KPI cards** with period-over-period deltas + severity colouring.
  - `[VISUAL-PLACEHOLDER]` **dashboard screenshots** (several — one per axis page at least).
    *Shows:* each axis page and its three sub-pages. *Produce:* screenshot the running app.
    **These are your most valuable figures — reserve space.**
- **Interactivity**: a **global filter bar** (period, service type, region, agency) synced across a
  page; saved **filter snapshots (bookmarks)**; real-time in-app notifications.

### 5.5 Deployment & infrastructure
- Containerisation (one orchestration definition; one-command bring-up); reverse proxy + automatic
  **HTTPS/TLS** (auto-renewed certs); **single modest VPS** topology (cost-effective); **named volumes**
  for persistence; automation (scheduled ETL + self-renewing certs). Only web ports public; internal
  services on a private network.
- `[VISUAL-IMPLEMENT]` TikZ **deployment topology** (containers behind reverse proxy on one VPS;
  private network; only web ports exposed).

### 5.6 Conclusion & transition to Testing & Results.

---

## CHAPTER 6 — Testing, Validation & Results (14–18 pp) — NEW CHAPTER
> The **test apparatus** belongs here (recap §10), plus the results that justify the project.

### 6.0 Introduction
- Because the real production systems could not be connected during development, a faithful **test
  environment** was built to exercise the full chain end to end. **Neutral framing** — do not
  editorialise about why (§0.4).

### 6.1 Simulated source systems
- A service simulating the **five internal systems** behind REST APIs reproducing the **same contract**
  (endpoints, shapes, auth, pagination, quirks). The ETL connects to the simulation **exactly as it
  would to production** — which is what makes validation meaningful.
- `[VISUAL-IMPLEMENT]` `booktabs` table: simulated system → domain provided (recap §10.1).

### 6.2 Realistic data generation
- **Real reference data** seeds dimensions (Algerian administrative geography; real agency/
  delivery-centre network; real company structure; real pricing grid). **Synthetic transactional
  data** on top. **Domain realism**: Algerian working calendar (Friday off; reduced weekends);
  seasonality (Ramadan, Eid, Black Friday, year-end); geographic volume by wilaya; salary by Algerian
  labour-law rates; full multi-status parcel lifecycle; cost/billing/operations consistency.
- `[VISUAL-IMPLEMENT]` illustrative pgfplots chart (e.g. seasonal volume) — mark "illustrative".

### 6.3 Scale of the test dataset
- Production scale: tens of thousands of parcels/day over a multi-year horizon → hundreds of millions
  of parcel-status events; tens of thousands of employee-months of payroll + matching expense/transport
  records. Qualitative figures; exact counts `% TODO`.

### 6.4 Data-quality validation
- Referential-integrity + business-rule check suite after every generation (cross-system references
  resolve; financial & distance identities hold; no events on the non-working day; identifier formats;
  test entities never leak). Dataset usable only when all checks pass → clean baseline.
- `[VISUAL-IMPLEMENT]` `booktabs` table: check category → what it verifies.

### 6.5 End-to-end validation
- Full chain exercised: **simulated sources → ETL → warehouse → API → dashboards → alerts**; frontend
  graceful-degradation verified independently.
- `[VISUAL-IMPLEMENT]` TikZ end-to-end validation chain (reuse architecture style).

### 6.6 Results
- What the platform delivers against the four objectives and the two axes:
  - dashboards answering the Operations / Cost & Profitability / Performance questions for each axis;
  - proactive alerting in action;
  - performance under realistic load (qualitative; measured numbers `% TODO`).
- `[VISUAL-PLACEHOLDER]` results screenshots (an alert firing; a populated KPI page).

### 6.7 Discussion
- Objectives met; both axes delivered in full; honest limitations.

### 6.8 Conclusion & transition to the General Conclusion.

---

## GENERAL CONCLUSION & PERSPECTIVES (3–4 pp)
1. **Summary** — the problem and how LOGIQ addresses it; the four objectives achieved; the two axes
   delivered as independent financial perimeters.
2. **Contributions (list)** — layered warehouse; constellation + conformed + snowflaked;
   SCD2 / junk / role-playing / controlled denorm; incremental idempotent observable ETL;
   operational/analytical separation; RBAC + stateless auth; proactive multi-channel alerting; faithful
   production-scale simulation + automated data-quality gate.
3. **Limitations & Future Work (neutral, §0.4):**
   - **Route Analysis** — future work; deferred because routing/optimisation-reference data was not
     available in scope; warehouse already designed to accommodate it (connect a route-optimisation
     solver; compare actual vs optimised routes; present as maps + comparative KPI tables).
   - **Conversational analytics assistant (prompt → chart)** — planned: user expresses an information
     need in plain language; the assistant returns the corresponding visualisation from the warehouse.
   - `[VISUAL-IMPLEMENT]` `booktabs` capability-status table (capability → status → reason/condition).

---

## APPENDICES (≤15 pp)
- **Annexe A** — full DW constellation ERD (the Ch.4 placeholder) + dimension/fact table inventory.
- **Annexe B** — extended dashboard gallery, sample alert-rule definitions, the full data-quality
  check list, a `docker-compose` overview.
- Keep appendices visual; reference them from the body ("see Annexe A").
