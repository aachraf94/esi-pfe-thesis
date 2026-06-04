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
- Purpose of the chapter: present the host + client organisations; study the existing systems and
  processes; **diagnose** the existing situation (the gap); then, through a **needs-driven** path,
  gather and synthesise the needs into the **objectives** of the target system, prioritise the scope,
  and set out the methodology. (Deliberately **no "requirements specification" wording** — frame it as
  *needs* and *objectives*; see 3.3–3.5.)

### 3.1 Host and Client Organisations
- **Ourquilane** (Hydra, Algiers) — the project carrier: software startup; products HR Force, FLEET GO,
  CASH Box, Route Planner, CS Care.
- **Yalidine El Djazair Services** — the final client: Algeria's express-delivery leader; ISO 9001 /
  14001 / 27001 certified; two principal services that become the **two business axes**:
  - **Express parcel delivery (B2C e-commerce)** — last-mile delivery.
  - **On-demand dedicated transport (B2B)** — moving goods/parcels for companies.
- **The logistics network**: general + 3 regional directions, call centres, vehicle fleet, and the
  **three-tier operational structure** — Hubs (4: Oued Smar / Relizane / Constantine / Ghardaïa) →
  regional sorting centres → delivery stations; delivery **types** (SD stop-desk / HD home-delivery).
  Scale figures (≈182 stations, fleet, headcount): confirm before printing (mark `% TODO`).
- `[VISUAL-IMPLEMENT]` TikZ Hub → Regional → Station hierarchy (**done**). Org-chart / network-position
  figure still `[VISUAL-PLACEHOLDER]` (Claude Design / PowerPoint).

### 3.2 Study of the Existing Systems
*(Order: business processes → operational applications. The analytical gap is now its own section, 3.3.)*
- **Business processes** first, *organised per service* (one subsection each):
  - *Express parcel delivery*: the parcel **lifecycle** (six stages — Pickup → Shipping → Transport →
    Reception → Delivery, + **Return** / reverse logistics, shown as a numbered list); the finer
    **status** set grouped by phase (table); the **delivery types** (HD / SD); **pricing** (delivered
    tariff, return tariff, theoretical-vs-real tariff by weight+volume) and — **separately** —
    **reimbursement** (insurance: ~1 % of declared value; 100 % if lost, 60–80 % if damaged).
    - `[VISUAL-FETCH]` author-provided parcel-lifecycle diagram (`Parcel Lifecycle 1.png`, **done**).
    - `[VISUAL-IMPLEMENT]` status table; pricing table.
  - *On-demand dedicated transport*: a **simplified four-step** request lifecycle —
    **Transport request → Agreement → Pickup → Delivery** (one client, one dedicated vehicle); a brief
    note on what a request records (vehicle & crew, cargo, routing & performance); the **cost**
    build-up (base + distance + operational + surcharges + fuel/tolls) vs the amount invoiced.
    - `[VISUAL-IMPLEMENT]` colour TikZ four-step flow (**done**).
- **Operational applications** (renamed from "source systems" — the BI solution is **not introduced
  yet**, so "source of what?" is premature) at a **functional** level — *what each one manages*.
  Present **all** the in-house applications in one styled grid table: Yalidine App, FleetGo, HR Force,
  Retour App, iTop, CS Care, QApp, Cash Box, PC Paie, Transport. **Mark** (note row) that user accounts
  for *all* applications are created and managed centrally through **HR Force**.
  - `[VISUAL-IMPLEMENT]` grid table (application → what it manages) + the HR-Force account note row.


### 3.3 Diagnosis of the Existing Situation
> **Redacted** in `chapter3.tex` (promoted from a 3.2 sub-bullet to its **own section**). Business /
> process framing — **no technology talk**; refer to the future solution as a **system**, not a
> "platform".
- **Two opening paragraphs**, then a **long numbered analysis** (≈10–11 items): each application does
  its job in isolation, but the set was never built to work as one, so the information needed to steer
  the business is dispersed, inconsistent, and hard to exploit.
- Weakness list (business outcomes, not technical faults): fragmented information; duplicated /
  inconsistent records; doubtful reliability of the figures; poor availability of information; manual,
  time-consuming reporting; reactive (not proactive) management; no consolidated three-view reading of
  each axis; blurred financial perimeters; limited historical perspective; dependence on individual
  knowledge; decisions taken on intuition.
- Close on the **need for a reliable, consolidated system** → leads into the needs / objectives below.

### 3.4 Needs-Gathering Methods *(Méthodes de recueil des besoins)*
- A few sentences: how the understanding of the business and its needs was built — direct contact with
  Yalidine / Ourquilane plus study of the existing material — then a table.
- `[VISUAL-IMPLEMENT]` grid table — columns: **Technique | Description | Stakeholders involved**:
  - **Individual interview** → with the **returns manager** (*responsable retour*).
  - **Individual interview** → with the **operations manager** (*responsable des opérations*).
  - **Meeting** → sat in on a project progress-review meeting for Yalidine's projects, held at
    Ourquilane, attended by several Yalidine department heads (customer-relations manager,
    information-systems department, returns manager, the manager's advisor); covered delivered and
    in-progress projects, their constraints and status.
  - **Document analysis** → the company's internal documents (business processes, parcel statuses,
    operational applications) and prior PFE theses produced at Ourquilane for Yalidine projects.
  - **Process observation** → an on-site visit (*visite de terrain*) to the Hussein Dey sorting centre,
    Algiers: first-hand observation of the process from pickup through delivery to return, with
    explanations from the **returns manager**.
  - **Application exploration** → hands-on use of the operational apps (Yalidine App, Returly, QApp, …).

### 3.5 Needs Analysis and Synthesis *(Analyse et synthèse des besoins)*
> **Absorbs the earlier "Objectives of the Target System" draft** — move that content here as the
> *output* of the synthesis. Still **no "Requirements Specification" / FR–NFR spec list** (avoids the
> client *cahier des charges* feel).
- Turn the gathered material into a **synthesised set of needs**, then state the **objectives of the
  target system** as the outcome of that synthesis:
  - **General objective** — one paragraph: a single, reliable, consolidated decision-support **system**
    giving management a faithful, timely view of the business, so decisions rest on data not intuition.
  - **Specific objectives** — short numbered list of business outcomes: *consolidate* the scattered
    data; *read each axis* along **Operations / Cost & Profitability / Performance**; *keep the two
    financial perimeters separate*; *monitor proactively*; *deliver the right information to the right
    decision-maker* (role-appropriate access); *found decisions on reliable data*. Fold the quality
    goals in lightly (reliable, responsive at national scale, simple for non-technical managers).
- `[VISUAL-IMPLEMENT]` optional needs / objectives summary figure or table (general → specific).

### 3.6 Business Scope and Prioritisation of the Needs (MoSCoW)
- **Must have — On-Demand Dedicated Transport** (B2B; Dedicated Trip / Courier / Handling).
- **Should have — Parcel Delivery** (classic e-commerce express).
- **Could have — Route Analysis** → one neutral line: future work, data not available in scope (§0.4).
- State the **two-independent-financial-perimeters** principle (costs/revenues never mixed).
- `[VISUAL-IMPLEMENT]` MoSCoW table (priority → axis → what it delivers).

### 3.7 Development Methodology and Planning
- Development approach (iterative); project timeline (from `thesis.md` schedule); tools.
- `[VISUAL-IMPLEMENT]` Gantt-style timeline (`pgfgantt`) — *optional, decide initial vs final Gantt*;
  fall back to a milestone table if a Gantt is not kept.

### Conclusion *(unnumbered)* — transition to Design.

---

## CHAPTER 4 — Conceptual Design & Architecture (22–26 pp) — heart of the thesis

> **This chapter is conceptual only.** Stay technology-agnostic: present *what the system does* and
> *how it is logically structured*, **not** how it is built. **No technology stack, no framework names,
> no physical/deployment detail, no code** — all of that lives in Chapter 5. The progression is
> **functional → conceptual architecture**; Chapter 5 then mirrors it as **technical realisation**.

### Introduction *(unnumbered)*
- Frame the chapter as the pivot from *problem* (Ch.3) to *solution*. **Name LOGIQ in 1–2 sentences**
  here so the reader has the name from the first line — e.g. *"This chapter presents LOGIQ
  (Logistics + IQ), the decision-support system proposed to close the gap diagnosed in Chapter 3."*
  The full reveal (vision, etymology, principles) comes in 4.3.

### 4.1 Functional specification *(technology-agnostic — what the system must do)*
> Frame as **functional design via use cases**, *not* a formal SRS / FR–NFR list (keep the
> needs/objectives spirit of Ch.3; avoid the *cahier des charges* feel). Trace every capability back to
> a Ch.3 specific objective.
- **Actors & roles** — who interacts with the system (top management, operations manager, returns
  manager, …, + an administrator); each actor's concern and what they consult.
  - `[VISUAL-IMPLEMENT]` grid table: actor → concern → what they consult.
- **Functional capabilities**, grouped into families, each traced to a Ch.3 objective:
  *data consolidation*; *multi-axis decision consultation* (two axes × Operations / Cost &
  Profitability / Performance); *proactive monitoring*; *role-appropriate access*; *administration*.
  - `[VISUAL-IMPLEMENT]` capabilities table (module/family → capabilities → objective served).
- **Global use-case diagram** — actors × main use cases.
  - `[VISUAL-IMPLEMENT]` TikZ use-case diagram (or `[VISUAL-PLACEHOLDER]` if drawn in a UML tool).
- **Quality requirements** — restate the quality goals (reliable, responsive at national scale, simple
  for non-technical managers) as functional-level expectations, **not** a formal NFR table.

### 4.2 Functional architecture *(the logical decomposition — still tech-agnostic)*
- The system split into **functional modules** and their relationships, as a logical block diagram —
  purely conceptual (e.g. *Consolidation → Decision-support/consultation → Monitoring & alerting*,
  wrapped by *Access & personalisation* and *Administration*). **No technology, no "platform/DB" yet.**
- A conceptual functional data flow: business activity → consolidated view → analytical consultation,
  with the alerting branch.
- `[VISUAL-IMPLEMENT]` TikZ functional-architecture block diagram (modules + relationships).

### 4.3 Solution & Global Architecture
> The **LOGIQ reveal** + the conceptual layered architecture, in that order: *here is LOGIQ, and here
> is how it is structured.* Lead with the solution, **then** the architecture.
- **The proposed solution — LOGIQ.** Name & meaning: **LOGIQ = Logistics + IQ** (logistics
  intelligence); also reads as *logique* (Fr. "logical") → decisions on logic/evidence, not intuition
  (callback to the diagnosis). Positioning: a single, consolidated BI decision-support **system**
  answering the Ch.3 gap. **Guiding principles**: one consolidated source; two axes read along
  Operations / Cost & Profitability / Performance; **two independent financial perimeters**; proactive
  monitoring; role-appropriate access.
  - `[VISUAL-IMPLEMENT]` optional "solution-at-a-glance" figure (problem → LOGIQ → value).
- **Global architecture** (conceptual): layered, service-oriented; **one-directional** data flow;
  **operational plane vs analytical plane** split (conceptual — *no database technology named here*).
  Conceptual layers: sources → integration → storage → application → presentation.
  - `[VISUAL-IMPLEMENT]` **layered architecture** TikZ diagram — *the single most important figure;
    make it clean and central.*
  - `[VISUAL-IMPLEMENT]` `booktabs` component table (layer → role) — conceptual roles, not products.

### 4.4 Data warehouse design (~8–10 pp — biggest section)
> **Logical spine:** *design approach* frames the method → *source scoping & data understanding* shows
> the raw material and sorts it into facts vs dimensions (the hinge) → *layered design → schema paradigm
> → modelling techniques* build the model from that sorting → *scale* justifies why it is built big.
- **Design approach** — one short paragraph: the model is driven **top-down** by the analytical
  questions (2 axes × 3 views, §4.1) and **bottom-up** by the source data; frame it as the **Kimball
  dimensional-modelling lifecycle** (select business process → declare grain → choose dimensions →
  identify facts), with a citation. Conceptual only — *no database technology named.*
- **Source Scoping and Data Understanding** — the bridge from sources to model. Of the ~10 operational
  applications in Ch.3, **only ~5 actually feed the warehouse** for the two delivered axes; the rest are
  out of scope this version. State sources at **contract level only** — *no REST/API extraction
  mechanics here* (those belong to §4.5 ETL). Present against the **real** source applications, **not**
  the simulated/mock sources (the simulation is Ch.6 Testing). Default app→source mapping (confirm with
  author): Yalidine App → core logistics (geography, delivery centres, pricing, parcel-event history);
  HR Force → HR (companies, agencies, employees, org hierarchy); Cash Box → cash-box (operating
  expenses, freelance-driver pay, reimbursements, transfers); PC Paie → payroll (payslips); Transport →
  dedicated B2B requests + stops. **Excluded:** FleetGo, Retour App, iTop, CS Care, QApp.
  - `[VISUAL-IMPLEMENT]` **one merged grid table**: operational app → data it provides → axis/process
    served → becomes a **fact** or a **dimension**. (Does scoping *and* the fact/dimension sorting at
    once — the hinge into the layered design below.)
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

### 4.5 ETL pipeline design (~4–5 pp)
> Conceptual design of the integration process — *no orchestrator/product names* (those go to Ch.5).
- **Asset-oriented orchestration** & lineage (each warehouse table = a data asset with declared deps).
- **Five stages** mapped onto the layers: extract → stage → transform/load dimensions → load facts →
  refresh aggregates.
- **Engineering properties**: incremental extraction; idempotent loads (insert-or-update); resilience
  (retry + exponential backoff); scheduling (nightly full + lighter dimension refresh); observability
  (lifecycle events to the platform); **source decoupling** (depends only on the source contract).
- `[VISUAL-IMPLEMENT]` TikZ **ETL flow** (stages → layers).
- `[VISUAL-IMPLEMENT]` `booktabs` properties table (property → rationale).
- `[VISUAL-FETCH]` generic asset-graph illustration **OR** `[VISUAL-PLACEHOLDER]` real asset-graph
  screenshot.

### 4.6 Application Platform Design
> The application users actually touch, on top of the warehouse — described **functionally**
> (back-end + front-end as *functions*, **no framework/technology names**). Absorbs the former
> "Alerting design" and "Security/access" role concerns at the conceptual level.
- **Decision-support visualisations / dashboards** — organised by the **two axes**, each with
  **Operations / Cost & Profitability / Performance** (NO pricing) + Overview; KPI cards, charts, maps
  (conceptually — visualisation *types*, not the toolkit).
- **Proactive alerting** — threshold **rules** (metric, operator, threshold, severity, cooldown);
  scheduled evaluation; **multi-channel** delivery (in-app + email, per-user preference); pipeline
  notifications surfaced through the same machinery (closes the loop).
  - `[VISUAL-IMPLEMENT]` TikZ flow: rule → scheduled check → threshold crossed → alert → channel fan-out.
- **Role-based access experience** — each role sees the sections suited to it; **role-filtered
  navigation** (the *functional* view; the security mechanism is 4.7).
- **User-preference management** — saved filter snapshots (bookmarks), notification-channel
  preferences, etc.
- **Operational vs analytical data separation** — the conceptual essence of the two-store design: the
  platform's own data (users, roles, alert rules, preferences, notifications) is kept **separate** from
  the analytical data, so heavy analytics never disturbs the application. *(The physical two-database
  routing is Ch.5.)*

### 4.7 Security & Conformity
> Renamed from "Security & access design" (NB: idiomatic English is "Security & Compliance" — kept as
> *Conformity* per the author's choice). Cross-cutting concerns, conceptual level.
- **Access control** — **RBAC** mapping roles → dashboard sections; authentication & session principles
  (conceptual — *no token/library specifics here*).
- **Conformity** — security/data-protection posture aligned with Yalidine's ISO 27001 context;
  read-only decision-support layer (does not alter operational data); traceability/audit of access.
- `[VISUAL-IMPLEMENT]` small RBAC table (role → accessible sections).

### Conclusion & transition to Implementation.

---

## CHAPTER 5 — Implementation & Deployment (18–22 pp)
> From *how it was designed* (Ch.4, conceptual) to *how it was built and shipped* (the technical
> realisation). This is where **all technology** lives — the stack, frameworks, products, and physical
> choices deferred from Ch.4. General-aspects level; tiny snippets only if they clarify (≤10 lines,
> `listings`). No full code. Each section mirrors a Ch.4 design block.

### Introduction
### 5.1 Technology stack
> Moved here from Ch.4 — Ch.4 is conceptual, so the concrete stack is introduced at the start of the
> realisation chapter and reused by the sections below.
- The open-source stack with one-line justification each; emphasise **free / open-source / no
  licensing cost**.
- `[VISUAL-IMPLEMENT]` `booktabs` stack table (concern → technology):
  FastAPI+PostgreSQL (source simulation, test) · Dagster (ETL) · PostgreSQL (DW + operational) ·
  Django + DRF (backend) · Celery + Redis (background) · Next.js/React/TS (frontend) ·
  ECharts/D3.js/Leaflet/Tremor (viz) · Docker Compose + Nginx + Let's Encrypt (deploy).

### 5.2 Backend implementation
- REST API responsibilities: auth/session, RBAC authorisation, **read-only** analytics services over
  the **aggregate layer**, administration, alert engine.
- **Two-database realisation** — the operational DB (identity, roles, notifications, alert rules, ETL
  run history) vs the analytical DW; the backend **transparently routes** queries to the right store.
  *(This is the physical counterpart of the conceptual operational/analytical split in §4.6.)*
- **Graceful degradation** of analytics endpoints (fall back to representative demo data when the
  warehouse is unavailable).
- `[VISUAL-IMPLEMENT]` small TikZ figure of the operational/analytical query routing.
- `[VISUAL-PLACEHOLDER]` (optional) request-flow diagram.

### 5.3 Warehouse & ETL implementation
- How the four layers + asset graph were realised; nightly full refresh + lighter dimension refresh;
  lifecycle events emitted to the backend.

### 5.4 Alerting implementation
- Background worker evaluating active rules; notification machinery; per-user channel preferences.

### 5.5 Frontend / dashboard implementation
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

### 5.6 Deployment & infrastructure
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
