# LOGIQ — Dashboard KPIs & Visuals Reference

This document catalogues every **KPI**, **graph/visual**, and **filter** present on each
analytical page of the two business axes of the LOGIQ BI platform:

- **Parcel Delivery** (livraison de colis) — routes under `/parcel-delivery/*`
- **On-Demand Transport** (transport à la demande) — routes under `/transport/*`

Each axis exposes three analytical pages (tabs):

| Page | Route (Parcel) | Route (Transport) | Focus |
|------|----------------|-------------------|-------|
| **Operations** | `/parcel-delivery/operations` | `/transport/operations` | Volume & activity |
| **Cost & Profitability** | `/parcel-delivery/cost-profitability` | `/transport/cost-profitability` | Revenue, cost, margin |
| **Performance** | `/parcel-delivery/performance` | `/transport/performance` | Quality & service level |

Each page is laid out as **3 rows**:
- **Row 1** — 5 KPI cards (with period-over-period trend `vs N j précédents`).
- **Row 2** — 2 charts.
- **Row 3** — 2 charts.

> **Notation.** Formulas are reproduced from the KPI metadata panels
> (`frontend/src/lib/kpi-info/*`). `FILTER (...)` denotes a conditional aggregate
> (only rows matching the predicate are counted). All monetary values are in **DZD**.
> `début` / `fin` = the selected date range bounds. Update frequency for every KPI is
> **daily, after each ETL cycle**.

---

## Source: where the numbers come from

**Frontend** (Next.js): `logiq/frontend/src/app/(dashboard)/{parcel-delivery,transport}/*`
calls the analytics API; KPI definitions & formulas live in
`logiq/frontend/src/lib/kpi-info/{parcel-delivery,transport}.ts`.

**Backend** (Django): `logiq/backend/apps/analytics` (`queries/`, `views.py`,
`serializers.py`) serves the aggregated metrics from the constellation-schema warehouse.

---

# Global Filters (per axis)

Filters are rendered once in each axis **layout** and shared across its three pages
(via a Zustand store). Changing a filter re-fetches all KPIs and charts on the active page.

### Parcel Delivery filters — `useParcelDeliveryStore`

| Filter | Control | Values | Default |
|--------|---------|--------|---------|
| **Quick range** | Pills | `7D`, `30D`, `90D`, `YTD` | `7D` |
| **Start date** | Date picker | `>= 2023-01-01`, `<= end` | 7 days ago |
| **End date** | Date picker | `<= yesterday` | yesterday |
| **Delivery type** | Dropdown | `all` / `HD` (home delivery) / `SD` (stop desk / pickup point) | `all` |

API payload: `{ start_date, end_date, delivery_type? }` (`delivery_type` omitted when `all`).

### Transport filters — `useTransportStore`

| Filter | Control | Values | Default |
|--------|---------|--------|---------|
| **Quick range** | Pills | `7D`, `30D`, `90D`, `YTD` | `7D` |
| **Start date** | Date picker | `>= 2023-01-01`, `<= end` | 7 days ago |
| **End date** | Date picker | `<= yesterday` | yesterday |
| **Service type** | Dropdown | `all` / `course_dediee` / `courrier` / `manutention` | `all` |

API payload: `{ start_date, end_date, service_type? }` (`service_type` omitted when `all`).

> `rangeDays = round((end − start) / 1 day) + 1`; drives the "vs N j précédents" trend label.

---

# ▌ BUSINESS AXIS 1 — PARCEL DELIVERY

Shared warehouse tables:
- `SRC_OPS  = [dim_parcel, dim_parcel_status, dim_date]`
- `SRC_COST = [fact_parcel_revenue, fact_charges, fact_cost_salaire, dim_parcel, dim_date]`
- `SRC_PERF = [dim_parcel, dim_parcel_status, dim_remboursement, dim_date]`

Status codes used: **13 = Livré** (delivered, terminal), **19 = Retourné au vendeur**
(returned, terminal); `is_terminal = FALSE` = in transit.

---

## 1.1 — Parcel Delivery › Operations

### KPIs (Row 1 — 5 cards)

| # | KPI | Unit | Formula | Notes |
|---|-----|------|---------|-------|
| 1 | **Parcels Handled** (Colis traités) | count | `COUNT(*) WHERE date_creation_id BETWEEN début AND fin [AND delivery_type = filtre_type]` | All statuses included (raw volume). |
| 2 | **Delivered Parcels** (Colis livrés) | count | `COUNT(*) FILTER (current_status_id = 13)` | Only status 13 = successful delivery. |
| 3 | **Returns** (Retours) | count | `COUNT(*) FILTER (current_status_id = 19)` | Cost without delivery revenue. ⚠ erodes profitability. |
| 4 | **In Transit** (En transit) | count | `COUNT(*) FILTER (is_terminal = FALSE)` | All non-terminal statuses; varies by query date. |
| 5 | **Avg Delivery Duration** (Durée moy. livraison) | hours | `AVG(duree_totale_minutes) / 60.0 FILTER (current_status_id = 13)` | Creation → "Delivered". |

### Graphs

| Row · Position | Title | Chart type | Series / Encoding | Source |
|----------------|-------|-----------|-------------------|--------|
| **2 · Left** | Volume Trend | **Stacked bar** (by date) | Delivered (`nbr_livres`, green) + Returned (`nbr_retours`, amber) + In Transit (`nbr_en_transit`, indigo) | ops trend |
| **2 · Right** | Status Breakdown | **Pie / donut** | `nbr_colis` by `status_name` | status breakdown |
| **3 · Left** | Region Flow Matrix | **Heatmap** (origin × destination) | Cell value = `nbr_colis` for `origin → destination`; color intensity ∝ count | region flow |
| **3 · Right** | Zone Distribution | **Horizontal bar** | `nbr_colis` per delivery zone (`Zone N` / "Non assignés") | zone breakdown |

---

## 1.2 — Parcel Delivery › Cost & Profitability

### KPIs (Row 1 — 5 cards)

| # | KPI | Unit | Formula | Notes |
|---|-----|------|---------|-------|
| 1 | **Fees Collected** (Frais collectés) | DZD | `SUM(delivery_fee) FROM fact_parcel_revenue WHERE date_terminal_id BETWEEN début AND fin` | Revenue of the parcel segment; filtered on resolution date. |
| 2 | **Total Operational Cost** (Coût opérationnel total) | DZD | `SUM(fact_charges.montant) [depense_status_id = 2] + SUM(fact_cost_salaire.total_brut + total_charges_patronales)` | Only validated charges. If type filtered: `coût_alloué = coût_total × (frais_filtrés / frais_total)`. |
| 3 | **Gross Margin** (Marge brute %) | % | `(SUM(delivery_fee) − coût_total) / SUM(delivery_fee) × 100` | ⚠ Excludes overhead (rent, depreciation). Negative = critical. |
| 4 | **Avg Fee / Parcel** (Frais moy. / colis) | DZD | `SUM(delivery_fee) / COUNT(*) FILTER (current_status_id = 13)` | Delivered parcels only. |
| 5 | **Cost / Delivered Parcel** (Coût / colis livré) | DZD | `coût_total / COUNT(*) FILTER (current_status_id = 13)` | ⚠ If cost > fee → loss-making. |

### Graphs

| Row · Position | Title | Chart type | Series / Encoding | Source |
|----------------|-------|-----------|-------------------|--------|
| **2 · Left** | Revenue vs Cost Trend | **Combo (line + bar)** | Cost (`cout_total`, red area-line) + Revenue (`total_fees`, green area-line) + Gross margin (`marge_brute`, indigo bars) with **break-even** markline at y = 0 | revenue/cost trend |
| **2 · Right** | Expenses by Category | **Horizontal bar** | `total_dzd` by `nature_name` | cost by nature |
| **3 · Left** | Regional Margin Matrix | **Heatmap** (origin × destination) | Cell value/label = `marge_pct`; color amber (low) → emerald (high); tooltip shows colis, frais, coût, marge DZD & % | region profit |
| **3 · Right** | Zone Profitability | **Grouped bars + line (dual-Y)** | Fees collected (`total_fees`, green bar) + Total cost (`cout_total`, red bar) on Y-DZD; Margin % (`marge_pct`, indigo line) on Y-% (0–50) | zone profit |

---

## 1.3 — Parcel Delivery › Performance

Adds source table `dim_remboursement` (claims / sinistres).

### KPIs (Row 1 — 5 cards)

| # | KPI | Unit | Formula | Notes |
|---|-----|------|---------|-------|
| 1 | **Delivery Rate** (Taux de livraison) | % | `COUNT(*) FILTER (current_status_id = 13) / COUNT(*) × 100` (denominator = parcels created in range) | ⚠ Rate < 73 % triggers a system alert. In-transit inflates denominator on recent periods. |
| 2 | **Avg Attempts** (Tentatives moy.) | count | `AVG(nbr_tentatives_livraison + 1) FILTER (current_status_id = 13)` | `+1` = the final successful attempt. |
| 3 | **1st Attempt Success** (Succès 1ère tentative) | % | `COUNT(*) FILTER (status=13 AND nbr_tentatives_livraison = 0) / COUNT(*) FILTER (status=13) × 100` | Field efficiency & client-data quality. |
| 4 | **Avg Delivery Duration** (Durée moy. livraison) | hours | `AVG(duree_totale_minutes) / 60.0 FILTER (current_status_id = 13)` | Same metric as Operations duration. |
| 5 | **Claims Declared** (Sinistres déclarés) | count | `COUNT(*) FROM dim_remboursement WHERE date_remboursement_id BETWEEN début AND fin` | ⚠ Growth signals transport/packaging issues. |

### Graphs

| Row · Position | Title | Chart type | Series / Encoding | Source |
|----------------|-------|-----------|-------------------|--------|
| **2 · Left** | Monthly Performance | **Dual-axis lines** | Delivery rate % (`taux_livraison_pct`, green area-line, Y-%) + Avg duration h (`avg_duree_livraison_h`, amber dashed line, Y-h) | perf trend |
| **2 · Right** | Duration Distribution | **Histogram (bar)** | `nbr_colis` per duration bucket (`bucket`) | duration distribution |
| **3 · Left** | Top 8 Expedition Centers | **Horizontal bar** (ranked) | `nbr_colis` per `center_code — center_name`, top 8 | center expedition ranking (`limit=8`) |
| **3 · Right** | Claims by Type | **Pie / donut** | `nbr_sinistres` by `sinistre_type` | claims types |

---

# ▌ BUSINESS AXIS 2 — ON-DEMAND TRANSPORT

Shared warehouse tables:
- `SRC_OPS  = [dim_transport, dim_transport_status, dim_transport_service_type, dim_date]`
- `SRC_COST = [fact_transport_billing, fact_transport_cost, dim_transport, dim_date]`
- `SRC_PERF = [fact_transport_performance, dim_transport, dim_date]`

Service types: `course_dediee` (dedicated trip), `courrier` (courier), `manutention` (handling).
Night shift = departure **or** arrival outside the **06:00–22:00** window.

---

## 2.1 — Transport › Operations

### KPIs (Row 1 — 5 cards)

| # | KPI | Unit | Formula | Notes |
|---|-----|------|---------|-------|
| 1 | **Total Requests** (Demandes totales) | count | `COUNT(*) WHERE created_date_id BETWEEN début AND fin [AND service_type_id = filtre_service]` | All statuses (completed, in progress, cancelled). |
| 2 | **Completion Rate** (Taux de complétion) | % | `COUNT(*) FILTER (statut = 'terminée') / COUNT(*) × 100` | In-progress lowers rate on recent periods. |
| 3 | **Cancellation Rate** (Taux d'annulation) | % | `COUNT(*) FILTER (statut = 'annulée') / COUNT(*) × 100` | ⚠ > 10 % over a short window → investigate. |
| 4 | **Avg Distance** (Distance moy.) | km | `AVG(distance_real_km)` | GPS-tracked real distance (uses `fact_transport_performance`). |
| 5 | **Avg Stops / Request** (Arrêts moy. / demande) | count | `AVG(nbr_stops_total)` | Logistical complexity per run. |

### Graphs

| Row · Position | Title | Chart type | Series / Encoding | Source |
|----------------|-------|-----------|-------------------|--------|
| **2 · Left** | Monthly Volume | **Stacked bar** (by month) | Terminées (`nbr_terminees`, green) + En cours (`nbr_en_cours`, indigo) + Annulées (`nbr_annulees`, red) | monthly trend |
| **2 · Right** | Service Breakdown | **Pie / donut** | `nbr_requests` by `service_type` (course dédiée / courrier / manutention) | service breakdown |
| **3 · Left** | Origin–Destination Matrix | **Heatmap** (wilaya × wilaya) | Cell value = `nbr_requests` for `origin → destination` over the 7 main wilayas (Alger, Oran, Constantine, Annaba, Sétif, Blida, Batna) | OD matrix |
| **3 · Right** | Distance Category | **Bar** (+ % of total) | `nbr_requests` per `distance_category` + `km_range` (local / regional / national) | distance category |

---

## 2.2 — Transport › Cost & Profitability

Cost is decomposed into **8 components**:
`cout_base + cout_carburant + cout_assurance + cout_distance_supp + cout_manutention + cout_peage + cout_emballage + cout_tarif_nuit`.

### KPIs (Row 1 — 5 cards)

| # | KPI | Unit | Formula | Notes |
|---|-----|------|---------|-------|
| 1 | **Total Revenue** (Revenu total) | DZD | `SUM(amount_invoiced)` | Invoiced amount (base + surcharges). |
| 2 | **Total Cost** (Coût total) | DZD | `SUM(total_cost)` = sum of the 8 components above | Fixed costs (insurance) allocated per trip ∝ distance. |
| 3 | **Gross Margin** (Marge brute) | DZD | `SUM(marge_brute_dzd) = SUM(amount_invoiced) − SUM(total_cost)` | ⚠ Negative → revise tariff / optimise cost. |
| 4 | **Margin %** (Marge %) | % | `SUM(marge_brute_dzd) / NULLIF(SUM(amount_invoiced), 0) × 100` | Target > 20 %; < 10 % = financial risk zone. |
| 5 | **Cost / km** (Coût / km) | DZD/km | `SUM(total_cost) / NULLIF(SUM(distance_real_km), 0)` | ⚠ Compare only similar vehicle categories. |

### Graphs

| Row · Position | Title | Chart type | Series / Encoding | Source |
|----------------|-------|-----------|-------------------|--------|
| **2 · Left** | Revenue vs Cost Trend | **Combo (bar + line, dual-Y)** | Revenue (`total_revenue`, green bar) + Cost (`total_cost`, red bar) on Y-DZD; Margin % (`marge_brute_pct`, amber line) on Y-% (0–50) | rev/cost trend |
| **2 · Right** | Cost Categories | **Horizontal bar** (ranked) | `total_dzd` per cost `label` (the 8 components) | cost categories |
| **3 · Left** | Cost per km by Vehicle | **Horizontal bar** | `cout_par_km` per `vehicle_type`; color green→red scaled by cost; tooltip adds total km & request count | cost per km |
| **3 · Right** | Top Corridors by Margin | **Horizontal bar** (ranked) | `taux_marge_pct` per `corridor` (0–40 %), top 8; tooltip adds request count | top corridors (`limit=8`) |

---

## 2.3 — Transport › Performance

Source: `fact_transport_performance`.

### KPIs (Row 1 — 5 cards)

| # | KPI | Unit | Formula | Notes |
|---|-----|------|---------|-------|
| 1 | **On-Time Rate** (Ponctualité) | % | `COUNT(*) FILTER (is_on_time = true) / COUNT(*) FILTER (is_on_time IS NOT NULL) × 100` | ⚠ Rate < 80 % triggers a system alert. |
| 2 | **Avg Duration** (Durée moy.) | hours | `AVG(total_duration_minutes) / 60.0` | Pickup → final delivery; excludes prep time. |
| 3 | **Avg Client Rating** (Note client moy.) | / 5 | `AVG(client_rating)` | Completed & rated trips only. ⚠ < 3.5 → degraded experience. |
| 4 | **Avg Arrival Delay** (Retard arrivée moy.) | minutes | `AVG(arrival_delay_minutes) FILTER (statut = 'terminée' AND arrival_delay_minutes IS NOT NULL)` | `delay = actual_arrival − planned_arrival`; negative = early. |
| 5 | **Night Shift Rate** (Taux de nuit) | % | `COUNT(*) FILTER (is_night_shift = true) / COUNT(*) × 100` | Night = depart/arrive outside 06:00–22:00; triggers night surcharge. |

### Graphs

| Row · Position | Title | Chart type | Series / Encoding | Source |
|----------------|-------|-----------|-------------------|--------|
| **2 · Left** | Monthly On-Time Trend | **Dual-axis lines** | On-time rate % (`on_time_rate_pct`, green area-line, Y-%) + Avg duration h (`avg_duration_h`, amber dashed line, Y-h); **80 % threshold** markline | on-time trend |
| **2 · Right** | Delay Distribution | **Bar** (color-coded buckets) | `nbr_requests` per delay bucket: Avance (green), 0–15 min (indigo), 15–30 (amber), 30–60 (red), > 60 (dark red) | delay buckets |
| **3 · Left** | Rating Distribution | **Bar** (1★–5★) | `nbr_requests` per `rating` star value (red → green gradient) | rating buckets |
| **3 · Right** | On-Time by Vehicle | **Horizontal bar** | `on_time_rate_pct` per `vehicle_type` (0–100 %); tooltip adds avg duration | vehicle perf |

---

## Appendix — KPI quick-reference (formula index)

### Parcel Delivery
```
Operations
  Parcels Handled       COUNT(*) over creation date [± delivery_type]
  Delivered             COUNT(*) FILTER status = 13
  Returns               COUNT(*) FILTER status = 19
  In Transit            COUNT(*) FILTER is_terminal = FALSE
  Avg Duration (h)      AVG(duree_totale_minutes)/60 FILTER status = 13

Cost & Profitability
  Fees Collected        SUM(delivery_fee)                       [date_terminal_id]
  Total Cost            SUM(charges[validées]) + SUM(salaires brut + charges patronales)
  Gross Margin %        (fees − cost) / fees × 100
  Avg Fee / Parcel      fees / delivered
  Cost / Delivered      cost / delivered

Performance
  Delivery Rate %       delivered / created × 100            (alert < 73%)
  Avg Attempts          AVG(nbr_tentatives + 1) FILTER status = 13
  1st Attempt %         (delivered & tentatives=0) / delivered × 100
  Avg Duration (h)      AVG(duree_totale_minutes)/60 FILTER status = 13
  Claims                COUNT(*) dim_remboursement [date_remboursement_id]
```

### On-Demand Transport
```
Operations
  Total Requests        COUNT(*) over created date [± service_type]
  Completion Rate %     terminée / total × 100
  Cancellation Rate %   annulée / total × 100               (watch > 10%)
  Avg Distance (km)     AVG(distance_real_km)
  Avg Stops             AVG(nbr_stops_total)

Cost & Profitability
  Total Revenue         SUM(amount_invoiced)
  Total Cost            SUM(total_cost) = Σ 8 cost components
  Gross Margin (DZD)    SUM(amount_invoiced) − SUM(total_cost)
  Margin %              margin / NULLIF(revenue,0) × 100      (target > 20%)
  Cost / km             cost / NULLIF(distance_real_km,0)

Performance
  On-Time Rate %        on_time / (on_time NOT NULL) × 100    (alert < 80%)
  Avg Duration (h)      AVG(total_duration_minutes)/60
  Avg Rating (/5)       AVG(client_rating)
  Avg Delay (min)       AVG(arrival_delay_minutes) FILTER terminée
  Night Shift %         is_night_shift / total × 100
```
