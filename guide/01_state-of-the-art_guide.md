# 01 — State of the Art Guide (Part I)

> Covers **Ch.1 (Data-Driven Decision Making)** and **Ch.2 (Logistics)**. Read `00_README_pfe_guide.md`
> and `03_visuals_guide.md` first. **Goal of Part I:** give the reader the theory needed to understand
> the contribution, moving from **general/abstract** (decision, information) to **technical** (BI
> architecture), then the **domain** (logistics). Citation-dense. Apply the no-dense-prose rule (§0.2):
> short paragraphs, frequent lists/tables/figures.

---

## CHAPTER 1 — Data-Driven Decision Making (16–18 pp)
**Narrative arc:** from the **abstract** (what a decision is) → to the **conceptual** (how data and
systems support decisions) → to the **technical** (BI and its building blocks). Four parent sections,
each with grouped subsections, so related ideas live together instead of as a flat list.

> **Structure at a glance**
> 1. Decision-Making in Organisations *(the problem: deciding)*
> 2. From Data to Decisions: Information Systems *(the conceptual progression — DIKW → IS → DSS)*
> 3. Business Intelligence *(the modern paradigm)*
> 4. The Building Blocks of a BI System *(the technical components)*

### Introduction (½ pp)
2–3 sentences: this chapter builds from what a decision is, through the systems that support it, up to
Business Intelligence as the technical means of doing so with data.

### 1.1 Decision-Making in Organisations
*The "why" — characterise decisions and their limits before introducing any supporting tool.*

- **1.1.1 The nature of a decision** — what a decision is; Simon's **intelligence → design → choice**
  model. Cite Simon.
- **1.1.2 Types of decisions** — **structured / semi-structured / unstructured** (short list).
- **1.1.3 Levels of decision-making** — **operational / tactical / strategic**, and how information
  needs differ by level.
  - `[VISUAL-FETCH]` the classic **decision pyramid** (operational → tactical → strategic).
- **1.1.4 Bounded rationality & the need for decision support** — cognitive limits (incomplete
  information, finite capacity, scarce time) → why structured, data-driven support is required. This is
  the bridge into §1.2. Cite Simon.
- Keep §1.1 to ~2 short paragraphs + 1 list + the pyramid figure.

### 1.2 From Data to Decisions: Information Systems
*The conceptual progression that turns raw data into decision support — DIKW → information systems →
DSS.*

- **1.2.1 Data, information, knowledge** — the **DIKW** hierarchy; data vs information vs knowledge vs
  wisdom; the role of context. *(Lead sentence + short list of the four levels, one line each.)*
  - `[VISUAL-IMPLEMENT]` TikZ **DIKW pyramid**.
- **1.2.2 Information systems and their types** — definition; **TPS, MIS, DSS, EIS**; where each sits
  by decision level (ties back to §1.1.3).
  - `[VISUAL-IMPLEMENT]` `booktabs` table: IS type → decision level → purpose.
- **1.2.3 Decision Support Systems (DSS)** — definition; three components (**data, model, user
  interface**); evolution from DSS toward BI (short list of components + 1 paragraph on the DSS → BI
  evolution).

### 1.3 Business Intelligence
*BI as the modern, technical realisation of everything above.*

- **1.3.1 Definition & strategic value** — BI as the technical answer to data-driven decision support;
  what makes it more than reporting. Cite Chaudhuri, Dayal & Narasayya (2011); Bose (2008).
- **1.3.2 The BI value chain** — sources → integration → storage → analysis → delivery.
  - `[VISUAL-IMPLEMENT]` TikZ **BI value-chain** diagram.

### 1.4 The Building Blocks of a BI System (technical)
Keep each block to a short paragraph — **deep design detail lives in Ch.4, not here.** This section
names the components; Ch.4 designs them.

- **1.4.1 Data Warehouse** — Inmon (top-down) vs Kimball (bottom-up / dimensional); fact vs dimension;
  what a dimensional model is. Cite Inmon (2005), Kimball & Ross (2013).
  - `[VISUAL-FETCH]` a generic textbook **star schema** illustration.
- **1.4.2 ETL** — extract / transform / load. Cite Vassiliadis (2009).
- **1.4.3 OLAP** — slice / dice / drill; the cube idea (brief).
- **1.4.4 Dashboards & reporting** — principles of good dashboard design. Cite Few (2006).
- **1.4.5 KPIs & proactive alerting** — what a KPI is; proactive vs descriptive monitoring (sets up the
  alerting designed in Ch.4).
- `[VISUAL-IMPLEMENT]` `booktabs` table: building block → role → relevance to this work.

### Conclusion & transition (½ pp)
Recap that BI is the technical answer to data-driven decision support; bridge to the logistics domain.

**Citations available for Ch.1:** Simon; Inmon (2005); Kimball & Ross (2013); Vassiliadis (2009); Few
(2006); Chaudhuri, Dayal & Narasayya (2011); Bose (2008).

---

## CHAPTER 2 — Logistics & the Logistics Domain (12–14 pp)

### Introduction (½ pp)
This chapter presents the logistics domain that the platform serves, and why it is a strong BI domain.

### 2.1 Logistics & supply chain
- Definitions; core logistics functions (transport, warehousing, distribution, last-mile).
- Citations: Günther & Tempelmeier (2007); Hofmann & Rüsch (2017).
- Lead sentence + short list of functions.

### 2.2 Parcel-delivery logistics (classic e-commerce express)
- The **parcel lifecycle**: creation → pickup → transit → delivery attempt(s) → resolution
  (delivered / returned / failed).
- Key operational KPIs: delivery success rate, delays, number of attempts, return rate.
- `[VISUAL-IMPLEMENT]` TikZ **parcel lifecycle** state flow.
- This subsection grounds the **Parcel Delivery** axis of the platform.

### 2.3 On-demand / dedicated transport (B2B)
- What dedicated transport is (B2B, dedicated capacity vs shared parcel network).
- The three service types relevant to this work: **Dedicated Trip, Courier, Handling** — one line each
  on what they are and their main cost drivers.
- `[VISUAL-IMPLEMENT]` a `booktabs` table: service type → description → main cost drivers.
- This subsection grounds the **Dedicated Transport** axis of the platform.

### 2.4 Cost & profitability in logistics
- Logistics cost structure; margin; the idea of profitability monitoring.
- (Pricing may be mentioned here as a general concept — but remember the built platform has **no
  pricing page**; do not promise a pricing dashboard.) Cite Wang & Alexander (2016).

### 2.5 BI in logistics
- Why logistics suits BI: high volume, cost pressure, geographic spread, many source systems.
- The **integration gap** that motivates this work: transport analysis, parcel monitoring, and
  decision-oriented visualisation are rarely unified.
- `[VISUAL-IMPLEMENT]` (optional) a small diagram of the integration gap (scattered systems → unified
  view).

### Conclusion & transition (½ pp)
Recap the domain and the gap; bridge to Part II (the contribution).

**Citations available for Ch.2:** Günther & Tempelmeier (2007); Hofmann & Rüsch (2017); Wang &
Alexander (2016); plus a parcel/last-mile logistics source (add to bib if used).

---

## Part I style reminders
- **Citation-dense, figure-present.** Use `[VISUAL-FETCH]` for textbook concepts, `[VISUAL-IMPLEMENT]`
  for anything drawable in TikZ.
- Keep every subsection scannable: lead sentence → list/table/figure → at most 2–3 short paragraphs.
- Do not let Part I drift into design detail — design belongs in Ch.4.
