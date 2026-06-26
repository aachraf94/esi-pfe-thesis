# LOGIQ — Anticipated Jury Questions & Answers

A preparation sheet for the PFE defence. Each question is followed by a short,
clear answer in simple academic language. Questions are grouped by theme; the
last two sections cover the "hard" and "trap" questions a jury often asks.

> **One-sentence summary of the project.** LOGIQ (Logistics + IQ) is a Business
> Intelligence decision-support platform that consolidates the data scattered
> across Yalidine's operational applications into a single data warehouse, keeps
> it current with an automated ETL pipeline, and presents it through interactive
> dashboards and proactive alerts — so that managers decide on evidence rather
> than intuition.

---

## 1. Project framing, motivation and scope

**Q1. In one or two sentences, what problem does your project solve?**
At Yalidine, the information needed to steer the business is not missing but
*scattered* across many disconnected applications. Producing a single, reliable
view of operations, cost and performance therefore required slow, manual work.
LOGIQ closes this *integration gap*: it brings the data together into one
trustworthy, decision-oriented platform.

**Q2. Who are Ourquilane and Yalidine, and what is your role between them?**
Ourquilane is the Algerian software company that *carries* the project and built
the platform; it is the host organisation. Yalidine is the *client* — the leader
of express delivery in Algeria — whose data the platform analyses. We designed
and built LOGIQ at Ourquilane for Yalidine.

**Q3. What are the two business axes, and why exactly those two?**
The two axes are **On-Demand Dedicated Transport (B2B)** and **Parcel Express
Delivery (B2C)**. They are the two ways goods actually move at Yalidine, and they
have very different economics (vehicles/distance/time vs. per-parcel handling), so
they must be analysed separately. Each axis is read through the same three views:
**Operations**, **Cost & Profitability**, and **Performance**.

**Q4. Parcel delivery is Yalidine's main activity by volume — so why is dedicated
transport the "Must have" and parcel the "Should have"?**
The ranking is *analytical*, not commercial. The parcel axis was already closely
watched through Yalidine's real-time parcel tracking, whereas the cost,
profitability and performance of dedicated transport were the most *opaque* to
management and the least served by any existing tool. Consolidated decision
support therefore adds the most value on the transport axis first. The parcel
axis follows immediately after, on the very same three-view design — and in the
end **both axes were delivered in full**.

**Q5. What does LOGIQ deliberately *not* do?**
LOGIQ is a **read-only decision-support layer**, not an operational tool. It does
not run the business, does not write back to the source systems, and does not
duplicate them. It covers only the two delivery axes — not HR, payroll or fleet
management as functions. **Route Analysis** is designed for but left as future
work because the routing data it needs was not available within the project's
scope.

**Q6. Why does the warehouse use payroll, expenses and HR data if those domains
are "out of scope"?**
There is a difference between an *analytical input* and a *monitoring objective*.
Salaries and operating expenses are needed to compute the **true cost and
profitability** of the two delivery axes (cost-to-serve includes labour and
overhead). So we ingest them as cost inputs, but we do not build HR or payroll
*dashboards* — those domains are not monitored as ends in themselves.

**Q7. What are the four technical pillars of the solution?**
A centralised **data warehouse**, an automated **ETL pipeline**, interactive
**dashboards**, and a proactive **alerting mechanism**. Every later design
decision serves one of these four.

---

## 2. Theoretical foundations (Part I)

**Q8. Why is Business Intelligence the right paradigm here, rather than a simple
report or a dashboard tool plugged onto the existing databases?**
Because the core difficulty is *fragmentation and inconsistency*, not the absence
of charts. BI adds three things a reporting tool alone cannot: a single
integrated data foundation (the warehouse) that removes conflicting versions of
the truth, an analytical orientation (the *why*, not just the *what*), and broad
accessibility for non-technical managers. Logistics is also an almost ideal
setting for BI: high data volume, wide geographic spread, many heterogeneous
systems, thin margins, and time-critical decisions.

**Q9. What is the difference between a Decision Support System (DSS) and Business
Intelligence?**
A DSS is the historical ancestor: an interactive set of models and tools to help
with semi-structured decisions. But classical DSS were limited by departmental
scope and fragmented, manually-updated data. BI overcomes exactly those limits by
adding a continuously-fed, integrated analytical foundation shared across the
whole organisation. LOGIQ is, in that sense, a modern data-driven DSS built on a
BI architecture.

**Q10. You mention the DIKW hierarchy — how does your system map onto it?**
DIKW is the ladder Data → Information → Knowledge → Wisdom. A BI system is a
machine for climbing it. In LOGIQ, raw status events are *data*; the warehouse and
KPIs turn them into *information* (delivery rate per region this month); cross-cut
analysis reveals *knowledge* (which corridors erode margin); and the manager
applies *wisdom* by deciding to re-price or re-route.

**Q11. Inmon or Kimball — which approach did you follow and why?**
We followed **Kimball's dimensional approach** (bottom-up, star/constellation
schema with conformed dimensions). It is organised around the *business questions*
to answer rather than around the source systems, which fits a decision-support
tool and lets us deliver one axis at a time while keeping figures comparable
across axes through conformed dimensions.

---

## 3. Analysis and methodology (Chapter 3)

**Q12. How did you gather the requirements? Was it just guesswork?**
No. We combined five complementary techniques: one-to-one **interviews** (returns
manager, operations manager), participation in a **management progress-review
meeting** at Yalidine, on-site **process observation** at a sorting centre
(following a parcel from pickup to return), **document analysis** of internal
processes and earlier theses, and hands-on **exploration of the operational
applications**. This gave both the strategic view from management and the ground
reality.

**Q13. What exactly was wrong with the existing situation?**
The diagnosis found a recurring pattern stemming from one absence — no system
*between* the applications. Concretely: information is fragmented; records are
duplicated and inconsistent; figures are hard to trust; cross-cutting numbers
need slow manual extraction; reporting is manual and error-prone; management is
reactive rather than proactive; financial perimeters are blurred; history is
limited; and knowledge depends on individuals. Together these force decisions on
intuition rather than evidence.

**Q14. What method did you use to prioritise the scope, and what does it mean?**
**MoSCoW** — Must have, Should have, Could have, Won't have (this time). It sorts
the scope by how essential each item is to a useful first release. Must have =
dedicated transport; Should have = parcel delivery; Could have = route analysis
(deferred); Won't have = other domains and any operational functions.

**Q15. How did you plan and track the work?**
The project ran in seven phases across the academic year (literature review,
analysis of the existing system, needs analysis, conceptual design,
implementation, testing & deployment, and a running documentation phase). It was
planned and tracked in **Notion**, with the schedule shown as a Gantt chart.

---

## 4. Design and architecture (Chapter 4)

**Q16. Walk us through the global architecture in one minute.**
Data flows in one direction. The five **source systems** expose REST APIs; a
**Dagster ETL pipeline** ingests them and builds the warehouse in four layers; the
data lands in two **PostgreSQL** databases — an analytical warehouse and an
operational store — plus **Redis**; a **Django + DRF** backend serves the data
while a **Celery** worker runs alerting off the request path; and a **Next.js**
web dashboard renders everything over HTTPS. Chapter 4 describes this logically;
Chapter 5 maps each block to its technology.

**Q17. Why did you separate the analytical store from the operational store?**
So that heavy analytical queries never disturb the running application, and each
store can be tuned — and fail — independently (an OLAP/OLTP separation). The
operational store holds the platform's own data (accounts, roles, alert rules,
preferences, ETL run history); the analytical store holds the read-only warehouse
the dashboards read.

**Q18. Why a fact-constellation (galaxy) schema rather than a single star?**
Because there are several business processes (parcel revenue, parcel performance,
salary cost, expenses, transport cost, transport billing, transport performance) —
seven fact tables. They are not forced into one star but **share** a common set of
conformed dimensions. Sharing makes figures reconcile (a cost and a revenue for
the same agency and month refer to the same agency and month) and keeps the two
financial perimeters cleanly apart.

**Q19. Why snowflake the dimensions instead of keeping them denormalised?**
The rule we chose is *no redundant data*: each attribute lives in exactly one
place, so a value stored once cannot disagree with itself — a single source of
truth. We allow a few *controlled* denormalisations only where a join path would
be nullable or SCD2-unstable, and each is justified.

**Q20. What is a Slowly Changing Dimension Type 2, and where did you use it?**
SCD Type 2 preserves history. When an attribute changes (an agency is relocated,
an employee reassigned), we do not overwrite the row — we close the old version
(set `valid_to`, `is_current = false`) and open a new one with a fresh surrogate
key and its own validity window. A fact then references whichever version was
current at the event date. We use it on **agencies and employees**; all other
dimensions are Type 1 (overwrite).

**Q21. Why surrogate keys and not just the source's natural keys?**
We use natural keys where the source code is stable (wilaya, commune, date) and
**surrogate keys** where history or composition demands them — chiefly the SCD2
dimensions, where one business entity has several versions and each version needs
its own key. Surrogates also insulate the warehouse from changes in source
identifiers.

**Q22. What are junk and role-playing dimensions, and why do you use them?**
A **junk dimension** collapses many low-cardinality flags (boolean/category) into
one small dimension, keeping the transport fact tables narrow instead of cluttered
with flags. A **role-playing dimension** is one physical table reused in several
roles — e.g. the calendar used as creation date, completion date, and payment
date; geography used as departure vs. arrival.

**Q23. Why the four-layer warehouse (staging → dimensions → facts → aggregates)?**
Each layer refines the one below and isolates a concern. Staging is a faithful raw
copy that makes loads re-runnable; dimensions hold conformed context; facts hold
the measures; and the **aggregate layer** holds pre-computed summaries. The
dashboards read *only* the aggregate layer, which is what keeps them fast at
national scale.

**Q24. How do you guarantee a fast dashboard over tens of millions of rows?**
Three design choices. (1) The **aggregate layer** (materialised views): a
dashboard scans a small, indexed summary instead of the full fact tables. (2)
**Incremental** ETL: only new and changed rows each run, never a full reload. (3)
**Operational/analytical separation**, so analytical load never competes with the
application.

**Q25. What were your non-functional requirements, and how are they structured?**
We organised them along the **ISO/IEC 25010** product-quality model — performance,
capacity/scalability, reliability, security, usability, maintainability,
compatibility/portability — as 19 technical specifications (TS01–TS19), each
tracing back to a quality expectation voiced by the users.

**Q26. How does security work, and how is it more than a login screen?**
Two principles. First, a **governed user base**: nobody self-registers — accounts
are mirrored from the HR system and activated by an administrator, so access
follows the organisation. Second, **role-based access control (RBAC)**: a user's
*role* (not the individual) determines which views they reach, and permissions are
defined at view level so new roles can be added without touching the system.
Sessions are stateless and revocable, transport is encrypted, the analytical
layer is read-only, and the two financial perimeters are kept strictly separate.

**Q27. Did you consider data protection and compliance?**
Yes — by design, not as an add-on. LOGIQ is built to sit inside Yalidine's
**ISO/IEC 27001** information-security context, and it respects **Algerian Law
n° 18-07** on personal data: *purpose limitation*, *data minimisation* (dashboards
show aggregated indicators, not individual client records), and *security of
processing*. Being strictly read-only also protects the integrity of the source
data.

---

## 5. Implementation (Chapter 5)

**Q28. Justify your technology stack.**
The whole platform is **open-source and free** — no licensing cost, inspectable,
runs on commodity hardware. Each tool was chosen for **stability** (mature,
production-proven), **performance** (works at national scale), and **mastery**
(already well understood, which lowers risk). Examples: PostgreSQL for both
stores, Dagster for the asset-oriented pipeline, Django/DRF for the API, Celery +
Redis for background work, Next.js/React for the dashboard, and Docker for
deployment.

**Q29. Why Dagster rather than a plain script or a tool like Airflow?**
Dagster is **asset-oriented**: every warehouse table is declared as an *asset* that
names the assets it depends on. From those declarations Dagster reconstructs the
full **lineage** and materialises assets in dependency order automatically. This
gives correct ordering by construction, safe partial re-runs (any single table can
be rebuilt without the whole pipeline), and a readable, auditable dependency
graph — advantages a linear script does not offer.

**Q30. How does your ETL stay reliable and avoid duplicating or corrupting data?**
Loads are **idempotent**: an insert-or-update (upsert) keyed on the business
identifier means a retried or repeated run never duplicates data. Extraction is
**incremental** (resumed from a high-water mark). Failed source calls **retry with
exponential backoff**, and a stalled source is skipped rather than aborting the
whole run. So the pipeline is always safe to retry.

**Q31. A parcel's status keeps changing after it is created — how do you capture
late updates without reloading 30 million rows?**
With a **trailing re-window**. A pure high-water mark would miss retroactive status
changes, so each run *clears the last 7 days* of parcel-status history and reloads
that window incrementally. Late-arriving updates are always captured, but we never
reload the full history.

**Q32. You run both databases on PostgreSQL — isn't that a contradiction with the
"separation" you claim?**
No. The separation is *logical and physical at the database level*, not at the
product level. We use **two separate PostgreSQL databases** — one analytical, one
operational — on the same proven engine, with a **database router** that sends
analytics models to the analytical database and everything else to the operational
one. The router makes the separation an infrastructural property, transparent to
the application code. Using one engine keeps the stack simple and well-mastered.

**Q33. How are users created and kept in sync with HR?**
Accounts are **imported from HR Force** and created *inactive by default* with no
access. An administrator activates the ones that need the platform and assigns each
a role. To stay aligned over time, the backend exposes a **webhook**: when an
employee is hired, leaves, or has their details changed in HR Force, HR Force calls
the webhook and the account is provisioned, revoked, or updated automatically.

**Q34. What happens if the warehouse is briefly unavailable — does the app break?**
No — it **fails safe** (graceful degradation, TS08). Because the planes are
separate, the analytics endpoints return a representative response instead of an
error, and the interface falls back to demonstration figures. This kept the app
usable both operationally and during demonstrations without a live warehouse.

**Q35. How does the alerting actually work?**
A user defines a **rule** (metric, operator, threshold, severity, and a *cooldown*
— the minimum quiet interval between repeat alerts). A periodic **Celery** task
reads each active rule's current value from the aggregate layer; when the threshold
is crossed *and* the cooldown has elapsed, an **alert** is raised and fanned out to
the channels the user enabled — **in-app** in real time, **email**, or both. Email
alerts are gathered into a weekly digest (Sundays at 07:00); the same machinery
also notifies users when the ETL finishes or fails.

**Q36. Why run alerting on a background worker instead of inside the API?**
So that watching the indicators never slows the interface a manager is using.
Celery (with Redis as broker) runs rule evaluation and notification delivery off
the request path, so heavy or scheduled work never blocks a request.

**Q37. Describe the deployment.**
The whole platform is **containerised** with Docker and described by a single
Docker Compose definition — frontend, backend, the two databases, Redis, the
Dagster orchestrator, and the Celery worker — brought up with one command. An
**Nginx** reverse proxy terminates HTTPS (certificates auto-renewed by Let's
Encrypt). Only ports 80/443 are exposed; every other container sits on a private
internal network. It runs on a **single modest Hostinger VPS** (2 vCPU, 8 GB RAM,
Ubuntu 24.04), which proves a full BI platform can be delivered cost-effectively
without a fleet of machines.

**Q38. Is this Hostinger deployment the production one?**
No — it is **temporary**, for testing and demonstration only. The production
deployment will be provisioned and costed by the company. Our point was to show the
platform is *reproducibly deployable* on modest infrastructure.

---

## 6. Testing, validation and results (Chapter 6)

**Q39. You validated against simulated sources, not the real systems. Does the
validation still count?**
Yes, and this is the key point. The ETL depends *only on each source's published
API contract* — never on its internal database. The simulation reproduces the same
endpoints, response shapes, authentication, pagination and quirks as the real
systems. So the pipeline connects to the simulation **exactly as it would to
production**, with no change to its code. Validating against the simulation
therefore genuinely validates the *production design*: the same pipeline that
passes here would run unchanged against the live feeds.

**Q40. Why couldn't you connect to the real systems?**
Direct access to Yalidine's live production systems could not be arranged within
the scope and timeframe of the project. Rather than test on toy data, we built a
faithful, contract-accurate simulation so the platform could still be exercised
end to end under realistic conditions.

**Q41. Was your test data just random? How is it "realistic"?**
It is **synthetic but business-realistic**, generated in two tiers. *Real reference
data* seeds the dimensions (the actual Algerian geography, the real agency/centre
network, the real company structure, the real pricing grid). *Synthetic
transactional data* is generated on top, shaped by **domain rules**: the Algerian
working calendar (Friday off), seasonality (Ramadan, Black Friday, year-end peaks),
geographic realism (volume concentrated on the densest wilayas), labour-law
payroll, the full multi-status parcel lifecycle, and internal financial
consistency. So the data reproduces the *behaviour* of the real activity, not just
its shape.

**Q42. What scale did you test at?**
Production scale: about **13 million parcels** and **30.5 million parcel-status
events** (the largest feed), ~45,000 monthly payslips across a workforce growing to
~3,000 employees, ~278,000 expense records, and ~3,800 transport requests with
~13,000 stops — over real reference dimensions (58 wilayas, 1,541 communes, 331
agencies, 252 centres). This scale is what makes the aggregate layer and the
incremental ETL meaningful to test; on a toy dataset neither could be exercised.

**Q43. How do you know the data is correct and nothing was lost or corrupted?**
Two automated gates. *Before* the ETL, a **data-quality gate** checks the generated
data (referential integrity, financial and distance identities, the working
calendar, identifier formats, test-entity isolation); only a dataset that passes is
admitted. *After* every load, a **warehouse-integrity audit** checks the ETL itself:
layer population, SCD2 integrity (no duplicate current rows, no overlapping
validity windows), staging→dimension and dimension→fact coverage (both **100%**),
and business-rule invariants (**zero violations**). Because the input is guaranteed
clean before the pipeline touches it, any downstream discrepancy can be blamed on
the platform, not the data.

**Q44. Some fact tables have fewer rows than their dimensions — isn't that data
loss?**
No — it reflects a *business rule*, not a loss. Only events that reach a *billable*
state produce a revenue row, whereas *every* event — successful or not — is still
measured for performance. So the model captures the full lifecycle, including
failed and returned parcels, not just the successful outcomes.

**Q45. How can a manager trust a KPI number on the screen?**
Every KPI card opens a **data-table view** listing the individual records behind
the headline figure, which the user can page through and reconcile against the
aggregate. So the warehouse-integrity audit proves the figures are right *to the
engineer*, and the drill-down lets the *decision-maker* verify them — turning every
KPI from an opaque number into an *auditable* one.

**Q46. Did you measure response times and ETL duration?**
We confirmed *qualitatively* that, because the analytics endpoints read the
pre-computed aggregate layer rather than scanning the fact tables, dashboards
return within seconds even over the production-scale dataset. Formal, measured
benchmarking of response times and refresh duration is stated openly as future
work — it was not completed within the project timeframe.

---

## 7. Limitations and future work

**Q47. What are the honest limitations of your work?**
Three. (1) **Simulated, not live, sources** — validation rests on the simulation;
the platform has yet to run against the real feeds (though its contract fidelity
makes it a sound substitute). (2) **No formal user-acceptance round** — it was
validated technically, not yet evaluated in day-to-day use with the managers. (3)
**Scope bounded** — route analysis was deferred for lack of the required data.

**Q48. What is the next step, and how ready is it?**
Live production integration is **ready by design**: you repoint the ETL from the
simulation to the real source contracts, with no code change. Beyond that:
**route analysis** (the warehouse already accommodates it), a **conversational
analytics assistant** (plain-language question → generated visualisation), formal
**performance benchmarking**, **user-acceptance testing**, and **predictive
analytics** (forecasting volumes, costs and performance on the existing facts).

**Q49. How will the system scale as data keeps growing?**
The design leaves headroom: the refresh is incremental (work grows only with
*new* data, not total data), the dashboards read bounded pre-computed aggregates,
and analytics are isolated from the operational store. If a single VPS becomes
insufficient, the containerised stack can be moved to larger or multiple hosts
without redesign.

---

## 8. Hard / "trap" questions

**Q50. Isn't this just a dashboard? What is the real engineering contribution?**
The dashboard is the visible 10%. The contribution is the *foundation* beneath it:
a layered dimensional warehouse on a constellation schema with conformed,
snowflaked dimensions and SCD2 history; an asset-oriented ETL that is incremental,
idempotent and observable, and depends only on the source contract; a clean
operational/analytical split; auditable KPIs traceable from headline to record;
and a faithful production-scale validation apparatus with two automated quality
gates. The dashboard is only the surface of that engineering.

**Q51. Why not use a ready-made BI tool like Power BI, Tableau or Metabase?**
Those tools are presentation layers; they do not solve the hard part — *integrating
and historising* fragmented, inconsistent source data into one trustworthy base.
We still needed a designed warehouse and a reliable pipeline underneath. A custom,
open-source stack also gives full control, no licensing cost, the ability to embed
domain-specific logic (the two financial perimeters, SCD2, the trailing re-window,
the bespoke cost-flow visualisations), and a tailored RBAC tied to the client's HR
system — which an off-the-shelf tool constrains.

**Q52. You designed for "tens of millions" of rows but tested on ~30 million. Is
that genuinely large?**
For this domain and this client it is the realistic production order of magnitude,
and crucially it is large enough that the design choices *matter*: at this scale a
naïve query over the fact tables is visibly slow, so the aggregate layer and the
incremental load are put under real pressure rather than tested on a toy. The
architecture (incremental + aggregates + OLAP/OLTP split) is also the standard one
that continues to scale beyond this volume.

**Q53. What if a source system changes its API? Doesn't your whole pipeline break?**
Only the **extraction** stage depends on the API, and only on its *published
contract*. Staging decouples extraction from the rest, so a contract change is
contained to one stage — the dimensions, facts and aggregates downstream are
unaffected. This same decoupling is exactly what let the simulation stand in for
production unchanged.

**Q54. How do you guarantee a cost reported for the parcel axis never leaks into
the transport axis?**
The **two financial perimeters never share a fact table**: no fact mixes a parcel
measure with a transport measure. The separation is enforced end to end — in the
schema (separate facts), in the queries, and in the dashboards — so each axis is
read on its own perimeter and the profitability of one can never be inflated or
masked by the other.

**Q55. Your alerting and KPIs read the aggregate layer, which is refreshed nightly.
Isn't the data stale during the day?**
The data is *daily-fresh*, which matches the decision horizon of this tool: LOGIQ
supports tactical and strategic decisions (cost, profitability, performance trends),
not second-by-second dispatching. The pipeline runs nightly so each morning's
dashboards rest on data refreshed overnight, and the lighter dimension refresh runs
more often. The refresh frequency is a schedule setting that can be increased if a
faster cadence is ever needed.

**Q56. Why is the abstract's keyword "Parcel Cost Control" (PCC) in the
abbreviations but the axis is "Parcel Express Delivery"?**
PCC appears only as the name of an internal Yalidine *role* (Responsable Colis &
PCC). The delivered business axis is **Parcel Express Delivery (B2C)**; "Parcel Cost
Control" is not a separate axis or page. The two delivered axes are dedicated
transport and parcel delivery, each with the three views Operations / Cost &
Profitability / Performance.

**Q57. If you had more time, what one thing would you do differently or first?**
Connect the platform to the **live production systems** and run a **user-acceptance
round** with the actual decision-makers. The architecture is ready for it by
design; doing it would convert a technically-validated platform into an
operationally-proven one and surface any real-world data quirks the simulation
could not anticipate.

**Q58. What did *you* personally learn or find hardest?**
The hardest and most valuable part was the **dimensional modelling and the
guarantee of trust**: declaring the right grain for each fact, deciding where
history (SCD2) genuinely mattered, keeping the two financial perimeters separate,
and then *proving* — with the quality gate and the integrity audit — that the
figures arrive complete and correct. Designing a system whose numbers a manager can
actually believe was a deeper challenge than building the dashboard itself.

---

### Quick-reference cheat sheet

| Topic | Key figures / facts |
|---|---|
| Axes | On-Demand Dedicated Transport (B2B, *Must*) · Parcel Express Delivery (B2C, *Should*) |
| Views per axis | Operations · Cost & Profitability · Performance |
| Warehouse | 4 layers · constellation schema · snowflaked dims · **18 staging, 55 dimensions, 7 facts, 5 aggregate views** |
| Modelling | Kimball · conformed dims · SCD2 (agencies, employees) · junk & role-playing dims · 2 financial perimeters |
| ETL | Dagster, asset-oriented · incremental · idempotent (upsert) · 7-day trailing re-window · nightly 01:00 UTC |
| Stores | Two PostgreSQL DBs (analytical + operational) · DB router · Redis |
| Backend / Front | Django + DRF · Celery + Redis · Next.js / React · ECharts, D3, Leaflet, Tremor |
| Alerting | Rule (metric·operator·threshold·severity·cooldown) · in-app + email · weekly digest Sun 07:00 |
| Deployment | Docker Compose · Nginx + Let's Encrypt · single Hostinger VPS (2 vCPU / 8 GB) · logiq.space |
| Validation | FastAPI mock of 5 systems (18 endpoints) · Faker · contract-faithful |
| Scale | ~13 M parcels · ~30.5 M status events · 45 K payslips · 278 K expenses · 3.8 K transport requests |
| Quality | Pre-ETL data-quality gate + post-load integrity audit (100% coverage, 0 violations) |
| Security | RBAC · HR-governed users · stateless auth · read-only analytics · ISO 27001 · Law 18-07 |
| Standards | Kimball (warehouse) · ISO/IEC 25010 (quality) · ISO/IEC 27001 + Law 18-07 (security) |
| Limitations | Simulated sources · no UAT yet · route analysis deferred |
</content>
</invoke>
