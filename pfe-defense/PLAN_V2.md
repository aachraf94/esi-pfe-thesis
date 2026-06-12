# Thesis Plan V2 — LOGIQ (Revised Agenda)

> Alternative table of contents, restructured per the new outline.
> Project: **LOGIQ** — a Business Intelligence Decision Support Information System for logistics, in partnership with Ourquilane.
> Scope (binding): two business axes — **On-Demand Dedicated Transport** and **Parcel Delivery**. Each dashboard page has three sub-pages — **Operations / Cost & Profitability / Performance**. **Route Analysis** = future work only.

---

## General Introduction
*A single flowing introduction: context → problem → objectives.*

- **Context** — the logistics sector and the rise of data; Ourquilane and its operational reality; why decision-making needs support.
- **Problem statement** — fragmented, raw operational data; no consolidated view; decisions made without consolidated, reliable indicators.
- **Objectives** — build a BI Decision Support System (LOGIQ) that turns raw logistics events into actionable dashboards across the two delivered axes.
- **Contributions** — what this work delivers (data pipeline, dimensional model, dashboards, deployment).
- **Document structure** — one short paragraph walking through the parts below.

---

## State of the Art
*Conceptual foundation in two movements.*

### Data-Driven Decision Making
- From data to decision: the value chain (data → information → knowledge → decision).
- Decision Support Systems (DSS) and Business Intelligence: definitions and positioning.
- BI building blocks: data warehouse, ETL, OLAP, dashboards / KPIs.
- Dimensional modelling essentials (facts, dimensions, star schema) — brief, sets up later parts.

### Logistics in the Data Age
- The logistics domain: transport, delivery, the operational data it generates.
- Digitalisation of logistics; events, tracking, the data deluge.
- Why BI fits logistics: cost control, performance, profitability.
- Synthesis → the gap LOGIQ fills (bridge into the next part).

---

## Analysis of the Existing System
*What exists today, what's wrong, and what we require.*

- **Host organisation** — Ourquilane: activity, the two business axes (On-Demand Dedicated Transport, Parcel Delivery).
- **Study of the existing** — current data sources, operational systems, how data flows today.
- **Critique of the existing** — limitations: no consolidation, no analytical layer, manual reporting.
- **Requirements** — functional (the dashboards/indicators needed) and non-functional (performance, scalability, usability).
- **Proposed solution** — high-level pitch of LOGIQ as the answer.

---

## Conceptual Design and Architecture
*From requirements to a blueprint.*

- **Methodology** — approach adopted (process / lifecycle for the BI project).
- **Global architecture** — layered view: sources → ingestion → warehouse → presentation.
- **Dimensional model** — star/constellation schema; fact and dimension tables for the two axes.
- **Data warehouse design** — granularity, SCD handling, key design choices.
- **Dashboard design** — the page model: one page per axis, each with Operations / Cost & Profitability / Performance sub-pages; KPI catalogue per sub-page.

---

## Implementation
*Building the system.*

- **Technology stack** — tools and platforms chosen, with brief justification.
- **ETL pipeline** — extraction, transformation, loading; data quality handling.
- **Warehouse construction** — building the schema, loading at scale.
- **Dashboard development** — building the pages and sub-pages; representative screenshots.
- **Key implementation challenges** — what was hard and how it was solved.

---

## Deployment & Infrastructure
*Running it for real.*

- **Deployment architecture** — environment, hosting/infrastructure topology.
- **Infrastructure & configuration** — servers, services, scheduling/orchestration.
- **Operation** — refresh cycles, monitoring, maintenance considerations.
- **Security & access** — roles, access control (high level).

---

## Test, Validation & Results
*Short part — closes with a demo.*

- **Testing approach** — what was validated (data correctness, performance).
- **Validation** — results meet requirements; KPI sanity checks.
- **Results** — outcomes, performance figures, value delivered.
- **Demonstration** — walkthrough of the live dashboards (the demo) at the end.

---

## General Conclusion
- Summary of the work and contributions.
- Limitations.
- **Future work** — including **Route Analysis** (neutral terms only).

---

## Annexes
- Supporting material: detailed schema, additional dashboards/screenshots, glossary, technical references.

---

### Mapping to the previous structure (for reference)
| V2 (this plan) | Notes |
|---|---|
| General Introduction | merges context + problem + objectives into one intro |
| State of the Art | Part I collapsed, two themes |
| Analysis of the Existing System | was old Chapter 3 |
| Conceptual Design and Architecture | merges old "Analysis & Methodology" + "Design & Architecture" |
| Implementation | was part of old Chapter 5 |
| Deployment & Infrastructure | split out from old "Implementation & Deployment" |
| Test, Validation & Results | was old Chapter 6, now shorter + demo |
