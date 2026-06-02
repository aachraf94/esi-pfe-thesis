# 02 — Contribution Guide (Part II + General Intro/Conclusion)

### Structural conventions (apply to every Part II chapter)
- **No part-level general introduction for Part II.** The thesis has exactly **one** general
  introduction (at the very start) and **one** general conclusion (at the very end). Each *part*
  opens straight into its first chapter — do **not** write a "Contribution" introduction.
- **Each chapter's opening "Introduction" and closing "Conclusion" are unnumbered.** Use
  `\section*{Introduction}` / `\section*{Conclusion}` followed by
  `\addcontentsline{toc}{section}{Introduction}` (the convention already in Ch.1–Ch.2), so they
  appear in the TOC but carry **no section number** (no "3.1 Introduction"). Numbered sections start
  at the first substantive section.


> Covers the **General Introduction**, **Ch.3–Ch.6**, and the **General Conclusion**. Read
> `00_README_pfe_guide.md` and `03_visuals_guide.md` first. Source of truth = `thesis-technical-recap.md`
> (+ `docs/`). Stay at **design / general-aspects** level — no code dumps, no invented detail. Apply the
> no-dense-prose rule (§0.2): short paragraphs, frequent lists/tables/figures.

> **Scope reminder (corrected — §0.5):** two delivered axes = **On-Demand Dedicated Transport** (B2B;
> Dedicated Trip / Courier / Handling) and **Parcel Delivery Express** (classic e-commerce express). Each axis
> page has **three sub-pages: Operations / Cost & Profitability / Performance** — **NO Pricing page**.
> Route Analysis = future work (neutral framing).


---

## CHAPTER 3 — Analysis of the Existing System & Methodology (14–16 pp)

> All the collected raw material for this chapter is now organised, in English, as comment blocks
> inside `mainmatter/part2/chapter3/chapter3.tex` (under the matching section). This guide holds only
> the **plan**; the `.tex` holds the **content to redact**.

### Introduction *(unnumbered)*
- Purpose of the chapter: present the host + client organisations, study the existing systems and
  processes, expose the analytical gap, then derive the requirements, scope, and methodology.

### 3.1 Host and Final Client Organisations
- **Ourquilane** (Hydra, Algiers) — the project carrier: software startup; products HR Force, FLEET GO,
  ITOP, CASH Box, Route Planner, CS Care.
- **Yalidine El Djazair Services** — the final client: Algeria's express-delivery leader; ISO 9001 /
  14001 / 27001 certified; two principal services that become the **two business axes**:
  - **Express parcel delivery (B2C e-commerce)** — last-mile delivery.
  - **On-demand dedicated transport (B2B)** — moving goods/parcels for companies.
- **The logistics network**: general + regional directions, call centres, vehicle fleet, and the
  **three-tier operational structure** — Hubs (4) → regional sorting centres → stations (182 over 55
  wilayas); delivery **zones** (0–3) and **types** (SD stop-desk / HD home-delivery). Stats: confirm
  before printing (mark `% TODO`).
- `[VISUAL-PLACEHOLDER]` company-context / network-position figure → *Produce:* Claude Design /
  PowerPoint. `[VISUAL-IMPLEMENT]` optional TikZ of the Hub → Regional → Station hierarchy.

### 3.2 Study of the Existing Systems
*(Order: business processes → source systems → analytical gap.)*
- **Business processes** first (this is where the parcel lifecycle lives — *one process subsection,
  organised per service*, not a separate section each):
  - *Parcel delivery*: parcel **lifecycle**, parcel **statuses**, and **pricing** (delivered tariff,
    return tariff, theoretical vs real tariff by volume+weight, COD reimbursement).
  - *Dedicated transport*: request → pricing agreement → assigned trip → pickup → delivery → completion.
  - `[VISUAL-IMPLEMENT]` TikZ parcel-lifecycle / status flow.
- **Source systems** at a **functional** level (*what each provides*, not internals) — describe them as
  the **real** source systems (simulation appears only in Ch.6). The **five internal systems** the
  warehouse consumes:
  - Core logistics system (**Yalidine App**) → geography, delivery centres, pricing grid, full
    parcel-event history.
  - HR system (**HR Force**) → companies, agencies, employees, org hierarchy.
  - Cash-box system (**CashBox**) → operating expenses, freelance-driver payments, reimbursements,
    transfers.
  - Payroll system (**PC Paie**) → monthly payslips.
  - Transport system → dedicated B2B transport requests and their stops.
  - (**Returly** — returns management — noted but outside the consumed set.)
  - `[VISUAL-IMPLEMENT]` `booktabs`/grid table: source system → domain it provides.
- **Identified weaknesses & the analytical gap**: scattered systems; what decision-makers cannot do
  today (consolidated, timely view across operations, cost & profitability, performance).

### 3.3 Requirements Specification
- **Functional requirements** — derived from the gap (short, numbered list): the **two axis pages**,
  each with **three sub-treatments** (Operations / Cost & Profitability / Performance), plus
  **Overview**, **Alerts**, **Administration**; **RBAC** (users imported from HR Force, activated by a
  super-admin, role-based dashboard access); proactive **alerting** tied to KPIs.
- **Non-functional requirements** — performance, scalability, security, usability, maintainability,
  open-source/cost.
- `[VISUAL-IMPLEMENT]` use-case diagram (TikZ) **OR** `[VISUAL-PLACEHOLDER]` drawn UML.

### 3.4 Business Scope and Prioritisation (MoSCoW)
- **Must have — On-Demand Dedicated Transport** (B2B; Dedicated Trip / Courier / Handling).
- **Should have — Parcel Delivery** (classic e-commerce express).
- **Could have — Route Analysis** → one neutral line: future work, data not available in scope (§0.4).
- State the **two-independent-financial-perimeters** principle (costs/revenues never mixed).
- `[VISUAL-IMPLEMENT]` MoSCoW table (priority → axis → what it delivers).

### 3.5 Development Methodology and Planning
- Development approach (iterative); project timeline (from `thesis.md` schedule); tools.
- `[VISUAL-IMPLEMENT]` Gantt-style timeline (`pgfgantt`) — *optional, decide initial vs final Gantt*;
  fall back to a milestone table if a Gantt is not kept.

### Conclusion *(unnumbered)* — transition to Design.

---

## CHAPTER 4 — Design & Architecture (22–26 pp) — heart of the thesis

### Introduction
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

### Conclusion & transition to Implementation.

---

## CHAPTER 5 — Implementation & Deployment (18–22 pp)
> From *how it was designed* to *how it was built and shipped*. General-aspects level; tiny snippets
> only if they clarify (≤10 lines, `listings`). No full code.

### Introduction
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

### Conclusion & transition to Testing & Results.

---

## CHAPTER 6 — Testing, Validation & Results (14–18 pp) — NEW CHAPTER
> The **test apparatus** belongs here (recap §10), plus the results that justify the project.

### Introduction
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

### Conclusion 

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
