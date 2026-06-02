# 01 — State of the Art Guide (Part I)

> Covers **Ch.1 (Data-Driven Decision Making)** and **Ch.2 (Logistics in the Data Age)**. Read `00_README_pfe_guide.md`
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

## CHAPTER 2 — Logistics in the Data Age (12–14 pp)
**Narrative arc:** **global** (logistics as a vast, data-rich, thin-margin domain) → **how it operates**
(the two operating models — which are the platform's two axes, but introduced *indirectly*, as the
domain's natural structure) → **the economics** (cost, profitability, performance — the universal
analytical lenses) → **Business Intelligence in logistics** (why it fits, and the integration gap this
thesis fills). Move broad-to-specific; **never frame the chapter as "our two axes"** — let the two
operating models emerge as the way logistics simply works.

> **Structure at a glance**
> 1. The Logistics Landscape *(global: what logistics is, its weight, the data-age pressures)*
> 2. How Logistics Operates *(the two operating models — the axes, introduced indirectly)*
> 3. The Economics of Logistics *(cost, profitability, performance — the three lenses)*
> 4. Business Intelligence in Logistics *(why logistics fits BI; the integration gap)*

> **Title.** Primary: *Logistics in the Data Age*. Alternatives if preferred: *The Logistics Domain:
> Flows, Operations, and the Analytics Imperative* · *Steering Logistics with Data* · *Logistics as a
> Data-Driven Decision Domain*.

### Introduction (½ pp)
2–3 sentences: logistics is a large, data-rich, thin-margin domain under intense pressure; this chapter
situates it globally, shows how it operates and where its money and performance are decided, and argues
why Business Intelligence is the natural instrument — setting up the contribution.

### 2.1 The Logistics Landscape
*Start global. Establish logistics as a large, strategic, data-intensive domain before any specifics.*
- Definitions: logistics & supply-chain management; logistics as the orchestration of three flows ---
  **physical, informational, financial**.
- Core functions: transport, warehousing, handling, distribution, last mile.
- Strategic weight: logistics cost as a share of product cost / GDP; logistics as a competitive
  differentiator, not a back-office cost centre.
- **The data-age pressures** (use recent refs): the e-commerce surge, rising customer expectations
  (speed, real-time visibility), digitalisation / Industry 4.0, omni-channel, and the data deluge from
  tracking and IoT.
- `[VISUAL-IMPLEMENT]` TikZ: the **three flows** (physical / informational / financial) along a supply
  chain — or a logistics-functions map.

### 2.2 How Logistics Operates
*The two dominant operating models of a modern logistics operator — presented as the domain's natural
structure, NOT labelled as the platform's axes.*
- Lead: goods move through two complementary operating models that differ in granularity, network
  shape, and economics.
- **2.2.1 Networked parcel distribution & the last mile** — many small shipments, hub-and-spoke
  networks, the last-mile challenge; the **parcel lifecycle** (creation → pickup → transit → delivery
  attempt(s) → resolution: delivered / returned / failed); operational KPIs (success rate, delays,
  attempts, return rate).
  - `[VISUAL-IMPLEMENT]` TikZ **parcel lifecycle** state flow.
- **2.2.2 Dedicated & on-demand freight transport (B2B)** — dedicated capacity vs the shared parcel
  network; on-demand service models (\eg dedicated trip, courier, handling) and their distinct cost
  drivers.
  - `[VISUAL-IMPLEMENT]` table (project grid style, §3 of `03_visuals_guide.md`): service model →
    description → main cost drivers.
- Close with one line: a single operator often runs **both** models on shared infrastructure yet with
  very different economics — which is exactly why they must be analysed separately. *(This is the only,
  indirect, hook to the platform's two axes — do not name them as "axes" or "sub-pages" here.)*

### 2.3 The Economics of Logistics
*Where logistics decisions are won or lost — and the three lenses every activity is read through.*
- Cost structure: transport, fuel, labour, handling, warehousing, last mile; thin margins; the idea of
  **cost-to-serve**.
- Profitability: margin per shipment / per trip; why deviations are hard to see inside raw operational
  systems.
- Performance & service quality: on-time delivery, reliability, SLA adherence.
- Frame the **three analytical lenses** — **operations, cost & profitability, performance** — as the
  universal way *any* logistics activity is monitored. *(This echoes the thesis's three analytical
  aspects without naming axes or sub-pages.)*
  - `[VISUAL-IMPLEMENT]` table (grid style): analytical lens → question it answers → example logistics
    KPIs.
  - `[VISUAL-IMPLEMENT]` (optional) illustrative cost-structure breakdown (`pgfplots`; mark
    "illustrative").
- Note: pricing may appear here as a general logistics concept, but the built platform has **no pricing
  page** — do not promise a pricing dashboard.

### 2.4 Business Intelligence in Logistics
*Bring it home: why logistics is a prime BI domain, and the gap this thesis fills.*
- Why logistics suits BI: high volume and velocity, geographic spread, many heterogeneous source
  systems, thin margins, and time-critical decisions.
- What analytics deliver in logistics: KPI monitoring, cost analytics, network/flow visibility,
  proactive alerting, and the climb from descriptive toward predictive (ties back to Ch.1's maturity
  idea).
- **The integration gap (the motivating problem):** operations, cost, and performance data are
  scattered across disconnected systems and rarely unified into one decision-oriented view — across
  *both* operating models. This is the gap Part~II closes.
  - `[VISUAL-IMPLEMENT]` TikZ: the integration gap (scattered source systems → unified analytical view
    / dashboards).

### Conclusion & transition (½ pp)
Recap: a data-rich, thin-margin, decision-intensive domain whose operations, costs, and performance are
scattered and under-exploited — exactly the gap a BI platform can close. Bridge to Part~II (the
contribution).

**Citations for Ch.2 (mix recent + classic — add each to `references.bib` when cited; search the web
for accurate details):**
- SCM / logistics foundations: a standard SCM text (\eg Chopra \& Meindl, recent ed.); Günther \&
  Tempelmeier (2007).
- Digitalisation / Industry 4.0 in logistics: Hofmann \& Rüsch (2017) + a recent (2020s) survey.
- Last-mile / e-commerce logistics: a recent dedicated reference.
- Logistics cost & profitability / cost-to-serve: Wang \& Alexander (2016) + a recent reference.
- BI / big-data analytics in logistics & SCM: a recent (2019–2024) survey.

---

## Part I style reminders
- **Citation-dense, figure-present.** Use `[VISUAL-FETCH]` for textbook concepts, `[VISUAL-IMPLEMENT]`
  for anything drawable in TikZ.
- Keep every subsection scannable: lead sentence → list/table/figure → at most 2–3 short paragraphs.
- Do not let Part I drift into design detail — design belongs in Ch.4.
