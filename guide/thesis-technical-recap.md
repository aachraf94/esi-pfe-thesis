# LOGIQ — Technical Recap for Thesis Redaction

> **Purpose of this document.** A high-level recap of the technical solution built for the PFE
> *"Decision Support Information System for the Analysis of Logistics Operations and Costs."*
> It is written to support the **redaction of the thesis** (Conception / Réalisation chapters): it
> describes the **general aspects** of the solution — architecture, design choices, and the rationale
> behind them — and deliberately **omits implementation details** (code, SQL, exact schemas, endpoint
> signatures, configuration). The simulated data sources are presented under **§10 — Testing &
> Validation**, since they belong to the test apparatus rather than the production solution.

---

## 1. Solution Overview

**LOGIQ** is a full-stack **Business Intelligence (BI) decision-support platform** designed for a
multi-site parcel-delivery and transport company operating across Algeria. Its goal is to **centralise
data scattered across several internal source systems** and turn it into reliable, navigable analytics
that help decision-makers monitor **logistics operations and costs**.

The platform is organised around a **Data Warehouse** as its central foundation, fed by an automated
**ETL pipeline**, exposed through analytical **dashboards**, and made proactive by a **threshold-based
alerting mechanism**. This directly mirrors the four objectives of the thesis: *centralised warehouse,
reliable automated ETL, interactive dashboards, and proactive alerting.*

### Business scope (prioritised)

| Priority | Business axis | What the solution delivers |
|---|---|---|
| **Must have** | **On-Demand / Dedicated Transport** | Analysis of expressed demand and evaluation of associated cost and profitability |
| **Should have** | **Parcel Delivery** | Monitoring of the classic e-commerce express parcel lifecycle at scale, with logistics-cost and profitability tracking |
| **Could have** | **Route Analysis** | **Not implemented in this version** — deferred due to the unavailability of the required routing data. The warehouse is nonetheless designed to support this extension later (see §11). |

These two primary axes (**Transport** and **Parcel Delivery**) are treated throughout the platform as
**two financially independent perimeters** — they share operational infrastructure (staff, agencies,
delivery centres) but their costs and revenues are **never mixed**. This separation is a structuring
principle of the whole solution, from the warehouse model up to the dashboards.

---

## 2. Functional Scope

The solution answers concrete decision-support questions for each business axis:

- **Operations** — How much volume is processed? What is the completion / delivery success rate? Where
  are the flows concentrated geographically?
- **Cost & Profitability** — What does each service cost? What is the gross margin? Where are parcels
  priced below their theoretical tariff? How does payroll and operating expense weigh on profitability?
- **Performance** — Are deliveries on time? What are the delays, attempts, and client-satisfaction
  signals?

These questions are organised into **two dashboard pages — one per business axis** — each with
exactly **three sub-pages** (*Operations*, *Cost & Profitability*, *Performance*; there is **no pricing
sub-page**), complemented by an **overview** page that summarises **both business axes** in a single
consolidated view, an **alerts** management page, and an **administration** module for user, role, and
pipeline governance.

**User model.** Users are imported from the company's HR system and activated by a super-administrator,
who assigns each user a **role**. A role controls which dashboard sections the user may access
(role-based access control), so the platform serves different decision-makers with a single, governed
interface.

---

## 3. Global Architecture

LOGIQ follows a **layered, service-oriented architecture**. Data flows in one direction — from source
systems, through integration and storage, up to the presentation layer — with a clear separation
between the **operational** plane (running the application) and the **analytical** plane (serving
insights).

### Component view

| Layer | Component | Role |
|---|---|---|
| **Sources** | Internal source systems | Five operational systems exposing data through REST APIs |
| **Integration** | ETL orchestrator | Extracts, transforms, and loads data into the warehouse on a schedule |
| **Storage (analytical)** | Data Warehouse | Dimensional store optimised for analytical queries |
| **Storage (operational)** | Platform database | Application state: users, roles, notifications, alert rules, pipeline history |
| **Application** | Backend REST API | Authentication, authorisation, analytics services, alert engine |
| **Presentation** | Web dashboard | Interactive charts, maps, filters, and administration UI |

A **message broker / cache** supports background processing (scheduled alert evaluation and
notification fan-out).

### Two-database principle

A deliberate and important design choice is the use of **two separate databases**:

- an **operational database** for the application itself (identity, preferences, notifications, alert
  definitions, ETL run history), and
- an **analytical data warehouse** for all decision-support queries.

The backend transparently **routes** analytical queries to the warehouse and everything else to the
operational store. This isolates heavy analytical workloads from the transactional application, keeps
each store optimised for its purpose, and reflects standard BI architecture practice.

### Technology stack (reference)

| Concern | Technology |
|---|---|
| Source-system simulation (test) | FastAPI + PostgreSQL |
| ETL orchestration | Dagster |
| Data warehouse & operational DB | PostgreSQL |
| Backend REST API | Django + Django REST Framework |
| Background processing | Celery + Redis |
| Frontend | Next.js (React, TypeScript) |
| Visualisation | ECharts, D3.js, Leaflet (maps), Tremor |
| Packaging & deployment | Docker Compose, Nginx, Let's Encrypt |

> The platform is built entirely on **open-source, free** components, which is consistent with the
> thesis goal of a *pragmatic and scalable* solution without proprietary licensing costs.

---

## 4. Data Modeling — The Data Warehouse

The warehouse is the **core foundation** of the solution. It is a dimensional database designed for
fast analytical queries and built in **four successive layers**.

### 4.1 Layered design

| Layer | Role |
|---|---|
| **Staging** | A faithful landing zone for raw extracted data — one staging table per source feed, no business transformation. Decouples extraction from modeling. |
| **Dimensions** | The descriptive context of the business (who, what, where, when), organised into normalised hierarchies. |
| **Facts** | The measurable business events (a parcel resolved, a payslip issued, an expense recorded, a transport request fulfilled). |
| **Aggregates** | Pre-computed, indexed summary views that feed dashboard KPIs and charts directly, for sub-second response. |

This layering gives a clean separation of concerns: ingestion, conformed modeling, measurement, and
presentation-ready aggregation each live in their own tier.

### 4.2 Schema paradigm — constellation with snowflaked dimensions

The model combines two classical dimensional patterns:

- a **constellation (galaxy / fact-constellation) schema** — **multiple fact tables share a common set
  of conformed dimensions**, which is what lets the platform analyse several business processes
  (parcels, payroll, expenses, transport) consistently and side by side; and
- **snowflaked dimensions** — dimension hierarchies are **normalised** (e.g. geographic and
  organisational hierarchies) so that **each attribute is stored exactly once**, eliminating redundancy.

The guiding rule is *"no redundant data"*: navigating up a hierarchy is always done by joining, not by
repeating attributes. A small number of **controlled, justified denormalisations** are the only
exceptions — applied where a normalised path would be unstable over time and would otherwise yield
incorrect results.

### 4.3 Advanced modeling techniques used

The warehouse applies several recognised dimensional-modeling techniques, each worth highlighting in
the thesis because each addresses a concrete analytical requirement:

| Technique | Where / why it is used |
|---|---|
| **Conformed dimensions** | Shared dimensions (time, geography, organisation, agencies) used identically by every fact table, enabling cross-process analysis. |
| **Slowly Changing Dimensions (SCD Type 2)** | Applied to entities whose attributes change over time (agencies and employees) so that history is preserved and each fact is linked to the version of the entity that was valid at the event date. |
| **Junk dimensions** | Low-cardinality flags (e.g. cargo and routing characteristics of a transport request) grouped into compact dimensions instead of cluttering the fact tables. |
| **Role-playing dimensions** | A single concept reused in multiple roles (e.g. a departure vs. an arrival location; multiple date roles such as creation, completion, payment). |
| **Natural vs. surrogate keys** | Stable source codes are reused directly as keys where possible; surrogate keys are introduced only where required (notably for SCD Type 2 history). |
| **Two financial perimeters** | Modeled explicitly so that transport profitability and parcel-delivery profitability are computed from strictly separate fact tables. |

### 4.4 Scale

The warehouse is dimensioned for **production-scale** data: the largest fact (parcel lifecycle) derives
from **hundreds of millions of status events**, while other facts cover payroll, operating expenses,
and transport requests over a multi-year horizon. This scale is what justifies the aggregate layer and
the incremental loading strategy described next.

---

## 5. Data Integration — The ETL Pipeline

The ETL pipeline is responsible for **populating and refreshing the warehouse reliably and
automatically**, which is one of the explicit thesis objectives.

### 5.1 Orchestration philosophy

The pipeline is built on an **asset-oriented orchestrator**: each warehouse table is modeled as a
*data asset* with declared dependencies. The orchestrator therefore knows the **lineage** of the whole
warehouse and can materialise assets in the correct order, visualise the dependency graph, and re-run
any subset safely.

### 5.2 Stages

The pipeline maps directly onto the warehouse layers:

1. **Extract** — pull data from each source system through its REST API, handling pagination and
   transient failures.
2. **Stage** — land raw data into staging tables.
3. **Transform & load dimensions** — conform, normalise, and apply SCD logic.
4. **Load facts** — resolve dimension keys and compute measures.
5. **Refresh aggregates** — rebuild the pre-computed summary views.

### 5.3 Key engineering properties

| Property | Rationale |
|---|---|
| **Incremental extraction** | The very large parcel-history feed is loaded incrementally (resuming from the last loaded point) rather than reloaded in full — essential at hundreds-of-millions scale. |
| **Idempotent loads** | Loads use an *insert-or-update* strategy so a re-run never duplicates data; the pipeline is safe to retry. |
| **Resilience** | Extraction retries failed calls with exponential backoff, tolerating temporary source-system unavailability. |
| **Scheduling** | A full refresh runs automatically on a nightly schedule, with a lighter periodic dimension refresh — no manual intervention required. |
| **Observability** | The pipeline emits lifecycle events (start, success, failure, cancellation) to the backend, which records every run and notifies users (see §7). |
| **Source decoupling** | Extraction depends only on the **API contract**, not on the source databases — so the same pipeline would connect to the real production systems without modification. |

---

## 6. Application Layer — The Backend

The backend is a **REST API** that mediates between the data stores and the frontend, and hosts the
platform's application logic.

### 6.1 Responsibilities

- **Authentication & session management** using stateless tokens, with token rotation and revocation
  on logout.
- **Authorisation** via **role-based access control** — a user's role determines which dashboards and
  administrative functions are available.
- **Analytics services** — read-only endpoints that query the warehouse's aggregate layer and shape
  the results into the KPIs, time series, breakdowns, and rankings the dashboards consume.
- **Administration** — user activation, role management, announcements, and pipeline-run history.
- **Alerting** — definition and evaluation of threshold alert rules (see §7).

### 6.2 Operational / analytical separation

Within the backend, only the analytics component talks to the warehouse; all other components use the
operational database. This routing is transparent to the application code and enforces the
two-database principle at the framework level.

### 6.3 Graceful degradation

Analytical endpoints are designed to **fail safe**: if the warehouse is temporarily unavailable, they
respond in a way that lets the frontend fall back to representative demonstration data rather than
breaking the user experience — useful both operationally and for demonstrations.

---

## 7. Proactive Alerting

Turning the platform from *descriptive* into *proactive* is an explicit deliverable of the thesis, met
by a **threshold-based alerting mechanism**.

- **Rule definition.** Decision-makers define rules on sensitive KPIs (e.g. tariff deviation, delivery
  success rate, transport cost, gross margin, daily volume) by choosing a metric, a comparison
  operator, a threshold, a severity, and a cooldown.
- **Scheduled evaluation.** A background worker evaluates the active rules periodically. When a metric
  crosses its threshold and the cooldown has elapsed, the system raises an **alert**.
- **Multi-channel delivery.** Alerts and pipeline notifications are delivered through the channels each
  user has enabled — **in-app** (pushed in real time to the interface) and/or **email** — according to
  per-user preferences.
- **Pipeline notifications.** Every ETL run's outcome is also surfaced through the same notification
  machinery, so users are informed when fresh data is available or when a refresh has failed.

This closes the loop between the data pipeline, the KPIs, and the decision-makers, making the system
**decision-oriented** rather than merely a reporting tool.

---

## 8. Presentation Layer — Dashboards

The frontend is a **single-page web dashboard** that presents the analytics interactively.

### 8.1 Organisation

The interface is structured around the **two business axes**, each on its own page with three
sub-pages for *Operations*, *Cost & Profitability*, and *Performance*, plus an **overview** page that
consolidates both axes in a single view, an alerts page, user settings, and an administration area.
Navigation is filtered by the user's role.

### 8.2 Visualisation toolkit

The dashboards use a rich, purpose-matched set of visualisations:

- **Statistical charts** (lines, areas, bars, stacked bars, pies/donuts, scatter, heatmaps, gauges,
  radars, Sankey flows) for trends, comparisons, distributions, and cost-flow breakdowns;
- **Custom data-driven visualisations** for bespoke cost-flow and network diagrams;
- **Interactive maps** for the geographic dimension of logistics flows;
- **KPI cards** with period-over-period deltas and severity colouring for at-a-glance monitoring.

### 8.3 Interactivity

A **global filter bar** (period, service type, region, agency, etc.) is shared across a page so all of
its visualisations stay in sync. Users can save **named filter snapshots (bookmarks)** to return
quickly to a recurring analysis. Real-time notifications appear directly in the interface.

---

## 9. Deployment & Infrastructure

The whole platform is **containerised** and deployed as a coherent stack.

- **Containerisation.** Every component runs as an isolated container, wired together through a single
  orchestration definition; the stack can be brought up reproducibly with one command.
- **Reverse proxy & TLS.** A reverse proxy fronts the stack, routes public sub-domains to the
  appropriate internal services, and terminates **HTTPS** with automatically renewed certificates.
  Only the web ports are exposed publicly; all internal services communicate over a private network.
- **Topology.** The solution is designed to run on a **single modest virtual private server**,
  demonstrating that a complete BI stack can be delivered cost-effectively.
- **Persistence.** Databases and pipeline history are stored on **named volumes** that survive
  rebuilds and redeployments.
- **Automation.** Once deployed, the ETL runs on its schedule and certificates renew themselves — the
  platform operates without routine manual intervention.

---

## 10. Testing & Validation of the Solution

Because the real production systems could not be connected directly during development, a central part
of the work was building a **faithful test environment** that exercises the entire solution end to end.
The simulated data sources belong here, as the **test apparatus**.

### 10.1 Simulated source systems (mock data sources)

A dedicated service **simulates the five internal source systems** behind REST APIs that reproduce the
**same contract** (endpoints, response shapes, authentication, pagination, quirks) as the real
systems. The crucial property is that the **ETL pipeline connects to this simulation exactly as it
would to production** — so validating against the mock genuinely validates the production design. The
five simulated systems cover:

| Simulated system | Domain it provides |
|---|---|
| Core logistics system | Geography, delivery centres, pricing, and the full parcel-event history |
| HR system | Companies, agencies, employees, and the organisational hierarchy |
| Cash-box system | Operating expenses, freelance-driver payments, reimbursements, internal transfers |
| Payroll system | Monthly payslips |
| Transport system | Dedicated B2B transport requests and their stops |

### 10.2 Realistic data generation

The test data is **synthetically generated but business-realistic**, which is what makes the
validation meaningful:

- **Real reference data** seeds the dimensions (the actual Algerian administrative geography, the real
  network of agencies and delivery centres, the real company structure, the real pricing grid).
- **Synthetic transactional data** is generated on top — parcels and their lifecycles, payroll,
  expenses, and transport requests.
- **Domain realism** is built in: the Algerian working calendar (Friday as the only day off; reduced
  activity on weekends), seasonal effects (Ramadan, Eid, Black Friday, end-of-year peaks), realistic
  geographic distribution of volume across wilayas, salary computations following Algerian labour-law
  rates, a complete multi-status parcel lifecycle, and internal consistency constraints between costs,
  billing, and operations.

### 10.3 Scale of the test dataset

The generator produces data at **production scale** — on the order of tens of thousands of parcels per
day over a multi-year horizon, yielding **hundreds of millions of parcel-status events**, together with
tens of thousands of employees-months of payroll and the corresponding expense and transport records.
This lets the solution be tested for **performance and correctness under realistic load**, not just on
toy data.

### 10.4 Data-quality validation

A **validation suite of referential-integrity and business-rule checks** is run after every
generation. It verifies, among other things, that cross-system references resolve, that financial and
distance identities hold, that no events fall on the non-working day, that identifiers follow their
expected formats, and that excluded test entities never leak into the data. Only when all checks pass
is the dataset considered usable by the ETL — establishing a clean, trustworthy baseline for testing
the rest of the platform.

### 10.5 End-to-end validation

Together, these elements allow the full chain to be exercised and validated: **simulated sources →
ETL → warehouse → API → dashboards → alerts**. The frontend's graceful-degradation behaviour (falling
back to representative data when the backend is unavailable) was likewise verifiable independently of a
live warehouse.

---

## 11. Scope Boundaries & Future Work (Perspectives)

The platform delivers its two priority business axes — **Dedicated Transport** and **Parcel
Delivery** — in full. Two further capabilities are intentionally **outside the scope of the current
version** and are documented here as perspectives; both are natural material for a *Limitations &
Future Work* discussion in the thesis.

### 11.1 Route Analysis — not implemented (data unavailability)

The *"Could have"* **Route Analysis** axis is **not implemented in this version**, because the **data
required for it is not available**. Meaningful route analysis depends on actual route/trajectory data
and an optimisation reference against which real routes can be compared — inputs that could not be
obtained for this work.

This is a **scope decision driven by data availability, not a design limitation**: the dimensional
model and its geographic dimensions were deliberately designed to **accommodate** the extension. Once
the routing data becomes available, the warehouse can be connected to a **route-optimisation solver**
(e.g. a Google OR-Tools–style solver) to **compare actual vs. optimised routes** and present the
results as **maps and comparative KPI tables**, without restructuring the existing model.

### 11.2 Conversational analytics assistant (prompt → chart) — planned

A **natural-language analytics assistant (chatbot)** is planned as an enhancement: the user expresses
an information need as a **prompt in plain language**, and the assistant returns the **corresponding
chart / visualisation** generated from the warehouse data. This would lower the barrier to ad-hoc
analysis, letting decision-makers obtain a visual answer without manually composing a dashboard.

This feature is **scheduled as a time-permitting extension** — it will be implemented if the remaining
project time allows, and is otherwise positioned as a near-term perspective for the solution.

### Capability status summary

| Capability | Status | Reason / condition |
|---|---|---|
| Dedicated Transport analytics | **Delivered** | Priority *Must have* |
| Parcel Delivery analytics | **Delivered** | Priority *Should have* |
| Route Analysis | **Not implemented** | Required routing data unavailable; model designed to support it later |
| Conversational assistant (prompt → chart) | **Planned** | To be implemented if project time permits |

---

## 12. Quick Reference (Appendix)

### Solution at a glance

| Dimension | Summary |
|---|---|
| Nature | Full-stack Business Intelligence decision-support platform |
| Domain | Logistics — parcel delivery and dedicated transport (multi-site, Algeria) |
| Central foundation | Layered dimensional **Data Warehouse** |
| Business axes | Dedicated Transport · Parcel Delivery (two independent financial perimeters) |
| Integration | Scheduled, incremental, observable **ETL** pipeline |
| Decision support | Interactive **dashboards** + proactive **threshold alerting** |
| Source systems | Five (simulated faithfully for testing) |
| Deployment | Containerised, reverse-proxied, single-VPS, automated |

### Design techniques to highlight in the thesis

- Layered warehouse (staging → dimensions → facts → aggregates)
- Constellation schema with **conformed dimensions** + **snowflaked** hierarchies
- **SCD Type 2** historisation; junk and role-playing dimensions; controlled denormalisation
- **Incremental** and **idempotent** ETL with retry/backoff and lineage-aware orchestration
- Separation of **operational** and **analytical** data stores
- **Role-based access control** and stateless authentication
- **Proactive**, multi-channel alerting tied to pipeline freshness
- Faithful **source-system simulation** with production-scale, business-realistic synthetic data and an automated **data-quality gate**

---

> **Note on figures.** Concrete volume figures (e.g. parcels/day, number of agencies, total event rows,
> number of dimension/fact tables) are intentionally summarised qualitatively here. Exact, final
> numbers for the manuscript should be taken from the detailed design documents in `docs/`
> (`dw-doc.md`, `etl-dagster-doc.md`, `mock-data-doc.md`, `architecture.md`, `deployment.md`), and
> a few of those counts differ slightly between documents — fix on one set of values before quoting
> them in the thesis.
