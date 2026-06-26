# LOGIQ — Defence Annex Slides (Backup Deck)

Reference slides to place **after** the main pitch deck. You don't present these
linearly — you jump to one when the jury asks a detailed question. Each slide is
written at "slide altitude" (short fragments, not sentences) and points to the
**thesis figure** you can drop straight in.

> **How to use:** keep them numbered A1, A2, … Put an index slide (A0) first so you
> can find a slide fast. The *Backs question* line ties each slide to the
> `jury-questions.md` sheet.

---

### A0 — Annex Index
*(divider slide — list of what's in the backup deck)*

- A1  Problem & diagnosis
- A2  Requirements gathering
- A3  Scope & MoSCoW
- A4  Functional architecture
- A5  Global architecture — logical
- A6  Global architecture — technical
- A7  Warehouse — 4 layers
- A8  Warehouse — constellation schema (ERD)
- A9  The 7 fact tables & 2 perimeters
- A10 Dimensional modelling techniques
- A11 SCD Type 2 illustrated
- A12 ETL pipeline — 5 stages
- A13 ETL — engineering properties
- A14 Technology stack
- A15 Two databases + router
- A16 Backend & HR Force sync
- A17 Dashboard structure (2 axes × 3 views)
- A18 KPI catalogue — Parcel
- A19 KPI catalogue — Transport
- A20 Alerting flow
- A21 Security & RBAC
- A22 Compliance (ISO 27001, Law 18-07)
- A23 Deployment topology
- A24 Test environment & data generation
- A25 Scale of test dataset
- A26 Quality gate & integrity audit
- A27 Results vs 6 objectives
- A28 Non-functional specs (ISO 25010)
- A29 Limitations & future work

---

### A1 — The Problem: Data That Exists but Cannot Be Read
**Backs question:** Q1, Q13

- Data is **not missing — it is scattered** across ~10 disconnected apps
- Same parcel / vehicle / expense recorded in several systems → conflicting answers
- Cross-cutting figures need **slow manual extraction** → out of date on arrival
- Reactive management: problems seen only *after* they appear in a report
- Result: **decisions on intuition, not evidence**

*Visual:* Ch.2 "integration gap" figure (`fig:ch2-integration-gap`)

---

### A2 — How the Requirements Were Gathered
**Backs question:** Q12

| Technique | Source |
|---|---|
| Individual interviews | Returns manager · Operations manager |
| Management meeting | Yalidine dept. heads · Ourquilane supervisor |
| On-site observation | Sorting centre (parcel pickup → delivery → return) |
| Document analysis | Internal processes, statuses, prior PFE theses |
| App exploration | Yalidine App, Returly, QApp … |

→ Strategic view (management) **+** ground reality (field)

---

### A3 — Scope & Priority (MoSCoW)
**Backs question:** Q4, Q5, Q14

| Priority | Item |
|---|---|
| **Must** | On-Demand Dedicated Transport (B2B) |
| **Should** | Parcel Express Delivery (B2C) |
| **Could** | Route Analysis *(deferred — data unavailable)* |
| **Won't (now)** | Other domains; any operational function |

- Transport first = it was the **most opaque** to management
- Parcel already watched via real-time tracking
- **Both axes delivered in full**

*Visual:* Ch.3 MoSCoW table (`tab:ch3-moscow`)

---

### A4 — Functional Architecture (Logical Value Chain)
**Backs question:** Q16

- One-directional chain: **Sources → Processing → Consolidation → Presentation + Alerts**
- Presentation answers questions *when asked*
- Alerts answer them *before they are asked*
- Cross-cutting: **Access & Personalisation**, **Administration**

*Visual:* Ch.4 functional-architecture (`functional-architecture.png`)

---

### A5 — Global Architecture — Logical View
**Backs question:** Q16, Q17

- Source systems → ETL orchestrator → analytical + operational stores → dashboard
- Each block names the **role it plays**, independent of technology
- Technical counterpart on the next slide

*Visual:* Ch.4 landscape figure (`global-architecture-logical.png`)

---

### A6 — Global Architecture — Technical View
**Backs question:** Q16

- Sources expose **REST APIs**
- **Dagster** builds the warehouse in 4 asset layers
- **2× PostgreSQL** (warehouse-db OLAP · platform-db OLTP) + **Redis**
- **Django + DRF** backend · **Celery + Beat** worker
- **Next.js** web client over **HTTPS**

*Visual:* Ch.5 landscape figure (`global-architecture.png`)

---

### A7 — Data Warehouse: Four Layers
**Backs question:** Q23, Q24

| Layer | Role | Objects |
|---|---|---|
| Staging | Raw faithful copy of each source | 18 |
| Dimensions | Conformed context (SCD2 where needed) | 55 |
| Facts | Measurable events, declared grain | 7 |
| Aggregates | Pre-computed summaries — **dashboards read here** | 5 |

- Built in strict dependency order by **idempotent SQL scripts**

*Visual:* Ch.4 four-layer stack (`fig:ch4-dw-layers`)

---

### A8 — Warehouse Schema: Constellation (Galaxy)
**Backs question:** Q18, Q19

- **7 facts share conformed dimensions** — not one forced star
- Shared dims → figures reconcile across views & axes
- **Snowflaked** dimensions: each attribute stored once (no redundancy)
- Two financial perimeters kept apart at the schema level

*Visual:* Ch.4 full constellation ERD (`fig:ch4-dw-erd`) — landscape

---

### A9 — The 7 Fact Tables & 2 Perimeters
**Backs question:** Q18, Q54

**Parcel-delivery perimeter**
- Parcel revenue · Parcel performance · Salary cost · Operating charges

**Transport perimeter**
- Transport cost · Transport billing · Transport performance

→ **No fact mixes a parcel measure with a transport measure** (TS10)

*Visual:* Ch.4 facts table (`tab:ch4-dw-facts`)

---

### A10 — Dimensional Modelling Techniques
**Backs question:** Q20, Q21, Q22

| Technique | Where | Why |
|---|---|---|
| Conformed dims | Time, geo, org, employee | Figures reconcile |
| Snowflake | Geo & org chains | One source of truth |
| **SCD Type 2** | Agencies, employees | Preserve history |
| Junk dims | Transport flags | Keep facts narrow |
| Role-playing | Calendar, geography | One table, many roles |
| Surrogate vs natural keys | SCD2 / stable codes | Stability + history |

*Visual:* Ch.4 techniques table (`tab:ch4-dw-techniques`)

---

### A11 — SCD Type 2 Illustrated
**Backs question:** Q20

- Attribute changes → **do not overwrite**
- Close old row (`valid_to`, `is_current = false`)
- Open new row → fresh surrogate key, **same business key**
- Fact references the version **current at the event date**

*Visual:* Ch.4 SCD2 figure (`fig:ch4-dw-scd2`) or Ch.5 `dim_employee_scd2`

---

### A12 — ETL Pipeline: 5 Stages
**Backs question:** Q29

**Extract → Stage → Load dimensions → Load facts → Refresh aggregates**

- Each stage mapped onto a warehouse layer
- **Asset-oriented** (Dagster): every table declares its dependencies
- Correct ordering *by construction* · safe partial re-runs · readable lineage

*Visual:* Ch.4 ETL flow (`fig:ch4-etl-flow`) + Dagster lineage (`dagster_lineage.png`)

---

### A13 — ETL: Engineering Properties
**Backs question:** Q30, Q31

- **Incremental** extraction — new/changed rows only (high-water mark)
- **Trailing 7-day re-window** for parcel status → captures late updates
- **Idempotent** upserts → retries never duplicate data
- **Resilience** — exponential backoff; skip a stalled source
- **Scheduled** nightly (01:00 UTC) — no manual intervention
- **Observable** — every run reported to users

*Visual:* Ch.4 properties table (`tab:ch4-etl-properties`)

---

### A14 — Technology Stack (all open-source)
**Backs question:** Q28

| Concern | Tools |
|---|---|
| Languages | Python · SQL |
| Data | PostgreSQL · Dagster |
| Backend | Django + DRF · Celery · Redis |
| Frontend | Next.js · React · Tailwind · ECharts · D3 · Leaflet · Tremor |
| Infra | Docker · Compose · Nginx · Let's Encrypt |
| Test apparatus | FastAPI · Faker |

- Chosen for **stability · performance · mastery** — no licensing cost

*Visual:* Ch.5 stack table (`tab:ch5-stack`)

---

### A15 — Two Databases + Router
**Backs question:** Q17, Q32

- **Operational DB** — accounts, roles, alert rules, preferences, ETL history (read/write)
- **Analytical DB** — read-only aggregate layer (dashboards)
- A **database router** sends analytics models → analytical, everything else → operational
- Same proven engine (PostgreSQL), two databases — separation is infrastructural

*Visual:* Ch.5 routing figure (`fig:ch5-routing`)

---

### A16 — Backend & HR Force Integration
**Backs question:** Q33, Q34

- Users **imported from HR Force** — inactive by default, no self-registration
- Admin **activates** + **assigns a role**
- **Webhook sync**: hire / leave / change → account provisioned, revoked, updated
- **Graceful degradation** (TS08): analytics fail safe → fall back to demo figures

*Visual:* Ch.5 backend responsibilities table (`tab:ch5-backend-resp`)

---

### A17 — Dashboard Structure: 2 Axes × 3 Views
**Backs question:** Q3, Q16

- **Overview** — both axes side by side
- **Parcel Delivery** — Operations · Cost & Profitability · Performance
- **On-Demand Dedicated Transport** — same three views, separate perimeter
- Plus Alerts · Preferences · Administration
- Navigation **filtered by role**; visual-first; data-table behind every KPI

*Visual:* Ch.5 frontend screenshots (`BusinessUser_Overview`, axis pages)

---

### A18 — KPI Catalogue — Parcel Delivery
**Backs question:** Q45

- **Operations:** parcels handled · delivered · returns · in transit · avg duration
- **Cost & Profitability:** fees collected · operational cost · gross margin % · avg fee/parcel · cost/parcel
- **Performance:** delivery rate % · avg attempts · 1st-attempt % · avg duration · claims

*Visual:* Ch.4 parcel KPI table (`tab:ch4-dash-kpi-parcel`)

---

### A19 — KPI Catalogue — Dedicated Transport
**Backs question:** Q45

- **Operations:** total requests · completion % · cancellation % · avg distance · avg stops
- **Cost & Profitability:** revenue · cost (8 components) · gross margin · margin % · cost/km
- **Performance:** on-time % · avg duration · avg client rating · avg arrival delay · night-shift %

*Visual:* Ch.4 transport KPI table (`tab:ch4-dash-kpi-transport`)

---

### A20 — Proactive Alerting Flow
**Backs question:** Q35, Q36

- Rule = **metric · operator · threshold · severity · cooldown**
- **Celery** worker evaluates active rules on schedule (off the request path)
- Threshold crossed **+** cooldown elapsed → raise alert
- **Fan-out:** in-app (real time) · email (weekly digest, Sun 07:00)
- Same machinery reports **ETL run** success/failure

*Visual:* Ch.4 alerting flow (`fig:ch4-alert-flow`)

---

### A21 — Security & Role-Based Access
**Backs question:** Q26

| Role | Overview | Parcel | Transport | Admin |
|---|:--:|:--:|:--:|:--:|
| Direction Générale | ✓ | ✓ | ✓ | — |
| Responsable Colis & PCC | ✓ | ✓ | — | — |
| Responsable Transport | ✓ | — | ✓ | — |
| Responsable Tournées | ✓ | — | — | — |
| Administrator | ✓ | ✓ | ✓ | ✓ |

- HR-governed users · stateless auth · read-only analytics · view-level permissions (configurable)

*Visual:* Ch.4 RBAC matrix (`tab:ch4-rbac`)

---

### A22 — Compliance by Design
**Backs question:** Q27

- **ISO/IEC 27001** — controlled access, segregation of duties, traceability, encryption in transit
- **Algerian Law 18-07** — purpose limitation, **data minimisation** (aggregated indicators, not personal records), security of processing
- Read-only layer → never alters the systems of record
- Two perimeters segregated end to end

*Visual:* Ch.4 conformity table (`tab:ch4-conformity`)

---

### A23 — Deployment Topology
**Backs question:** Q37, Q38

- Fully **containerised** (Docker Compose, one command)
- **Nginx** reverse proxy + **Let's Encrypt** TLS (auto-renew)
- Only ports **80/443** public; everything else on a **private Docker network**
- Single **Hostinger VPS** — 2 vCPU / 8 GB / Ubuntu 24.04 — `logiq.space`
- *Temporary* — production provisioned by the company

*Visual:* Ch.5 deployment topology (`fig:ch5-deploy`)

---

### A24 — Test Environment & Data Generation
**Backs question:** Q39, Q40, Q41

- **FastAPI** mock of the 5 source systems — **18 endpoints**
- Same endpoints, response shapes, auth, pagination, quirks as the real systems
- ETL connects **exactly as it would to production** (no code change)
- Data = **real reference dims** (geo, agencies, pricing) + **synthetic transactions**
- Domain rules: Algerian week (Fri off) · seasonality (Ramadan, Black Friday, year-end) · geographic realism · labour-law payroll · full lifecycle · internal consistency

*Visual:* Ch.6 mock API screenshots (`fig:ch6-mockapi`)

---

### A25 — Scale of the Test Dataset (production scale)
**Backs question:** Q42, Q52

| Domain | Volume |
|---|---|
| Parcels | ~13.0 M |
| Parcel-status events | ~30.5 M (largest feed) |
| Payslips | 45,378 |
| Operating expenses | 277,574 |
| Transport requests / stops | 3,822 / 13,414 |
| Reference dims | 58 wilayas · 1,541 communes · 331 agencies · 252 centres |

→ This scale is **why** the aggregate layer + incremental ETL matter

*Visual:* Ch.6 scale table (`tab:ch6-scale`) + row-count audit (`ETL_validation_row_counts`)

---

### A26 — Quality Gate & Integrity Audit
**Backs question:** Q43, Q44

**Before ETL — data-quality gate** (admits only clean data)
- Referential integrity · financial & distance identities · working calendar · ID formats · test isolation

**After every load — warehouse-integrity audit**
- Layer population: all populated
- SCD2 integrity: **0 violations**
- Staging→dim & dim→fact coverage: **100%**
- Business rules: **0 violations**

*Visual:* Ch.6 integrity table (`tab:ch6-integrity`) + coverage screenshots

---

### A27 — Results vs the 6 Objectives
**Backs question:** Q49 (and overall close)

| Objective | Delivered |
|---|---|
| Consolidate scattered data | One dimensional base, consistent figures |
| Read each axis in depth | 2 axes × 3 views, KPIs/charts/maps |
| Separate financial perimeters | Each axis on its own perimeter |
| Monitor proactively | Scheduled threshold alerts, multi-channel |
| Right info to right manager | Role-based access + overview |
| Decisions on reliable data | Auto, incremental, idempotent, observed refresh |

*Visual:* Ch.6 results table (`tab:ch6-results`) + populated dashboard (`Transport_page_notification`)

---

### A28 — Non-Functional Specs (ISO/IEC 25010)
**Backs question:** Q25

- **Performance** — views return in seconds over full history (aggregate layer)
- **Capacity** — sized for tens of millions of events; incremental refresh
- **Reliability** — consistent figures; idempotent, recoverable refresh
- **Security** — RBAC; separated perimeters; encrypted, stateless sessions
- **Usability** — visual-first; consistent across axes
- **Maintainability / Portability** — loosely coupled, open foundations; deployable on modest infra

*Visual:* Ch.4 technical-specs table (`tab:ch4-techspec`)

---

### A29 — Limitations & Future Work
**Backs question:** Q47, Q48

**Limitations (stated openly)**
- Simulated, not live, sources
- No formal user-acceptance round yet
- Scope bounded — route analysis deferred

**Future work**
- Live production integration *(ready by design — repoint the ETL)*
- Route analysis · conversational analytics assistant
- Performance benchmarking · UAT · predictive analytics

*Visual:* Conclusion future-work table (`tab:concl-future`)

---

## Notes for building the deck

- **Visual-first slides win.** Where a row points to a thesis figure, prefer the
  figure over the text — paste the figure and keep only a one-line caption.
- **Keep one idea per slide.** If a slide feels dense, split it (e.g. A18/A19 are
  already split per axis).
- **Mirror your manuscript colours** (the steel-blue / teal / amber / green figure
  palette) so the deck and the thesis read as one piece.
- **Order matches the Q&A sheet**, so during prep you can rehearse "question →
  annex slide" as a pair.
</content>
