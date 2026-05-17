\# Spreadsheet Answers



\# Overview



The spreadsheet phase focused on cleaning raw transaction data, standardizing operational fields, normalizing transaction amounts into USD, enriching merchant information, generating risk-related analytical flags, and building pivot-table-based business summaries.



Microsoft Excel was used for:

\- transaction cleaning,

\- text normalization,

\- currency conversion,

\- merchant enrichment,

\- operational risk flag generation,

\- and business aggregation analysis.



The spreadsheet outputs generated during this phase were later used for:

\- SQL analysis,

\- Python reconciliation workflows,

\- JSON normalization,

\- and dashboard reporting.



\---



\# Workbook Structure



The spreadsheet workbook contains the following sheets:



| Sheet Name | Purpose |

|---|---|

| Raw\_Data | Original imported transaction dataset |

| Cleaned\_Data | Cleaned and enriched transaction dataset |

| exchange\_rates | Currency conversion reference table |

| merchant\_master | Merchant enrichment reference table |

| Merchant\_Summary | Merchant-level pivot analysis |

| Payment\_Method\_Analysis | Payment-method pivot analysis |

| Region\_Risk\_Analysis | Region-level risk pivot analysis |



\---



\# Data Cleaning Process



The raw transaction dataset was manually reviewed and cleaned before downstream analysis.



The cleaning process included:

\- correcting inconsistent transaction status formatting,

\- checking missing values,

\- validating merchant-related fields,

\- reviewing payment-method consistency,

\- verifying chargeback transaction records,

\- standardizing categorical text values,

\- and checking duplicate transaction IDs.



The transaction status field initially contained inconsistent values such as:



| Original Value |

|---|

| `" SUCCESS "` |

| `"ChargeBack"` |

| `"FAILED "` |

| `"Success"` |



These values were standardized using spreadsheet text-cleaning functions such as:

\- `TRIM()`

\- `LOWER()`



Example formula:



```excel

=LOWER(TRIM(F2))

```



This transformed inconsistent values into standardized operational categories:



| Cleaned Value |

|---|

| `success` |

| `chargeback` |

| `failed` |



This ensured consistency across:

\- SQL filtering,

\- risk flag generation,

\- and dashboard aggregation logic.



\---



\# Currency Normalization



Transaction amounts were converted into a unified reporting currency (USD) using the `exchange\_rates.csv` reference table.



The exchange-rate mapping sheet contained:

\- currency codes,

\- corresponding exchange rates.



The `amount\_usd` field was created using lookup-based conversion logic.



Example formula structure:



```excel

=raw\_amount \* exchange\_rate

```



Excel `VLOOKUP()` was used to dynamically retrieve exchange rates.



Example implementation:



```excel

=D2\*VLOOKUP(E2,exchange\_rates!A:B,2,FALSE)

```



Where:

\- `D2` represented raw transaction amount,

\- `E2` represented transaction currency,

\- and the exchange-rate sheet stored currency-rate mappings.



This conversion standardized all transaction amounts into USD for:

\- GMV analysis,

\- merchant comparison,

\- and dashboard reporting.



\---



\# Merchant Data Enrichment



Transaction records were enriched using the `merchant\_master.csv` reference dataset.



The merchant master sheet provided:

\- merchant-level metadata,

\- region mapping,

\- and merchant validation support.



Excel `VLOOKUP()` was used to map merchant-related information into the cleaned transaction sheet.



Example structure:



```excel

=VLOOKUP(merchant\_id,merchant\_master!A:C,3,FALSE)

```



Merchant enrichment enabled:

\- region-level analysis,

\- operational segmentation,

\- and risk aggregation.



After enrichment, transaction records were mapped into standardized regional categories:

\- APAC

\- EU

\- US



\---



\# Calculated Fields



Several derived analytical columns were generated during spreadsheet processing.



\---



\# amount\_usd



The `amount\_usd` field represented normalized transaction value after currency conversion.



This field became the primary monetary field used throughout:

\- SQL aggregation,

\- merchant analysis,

\- dashboard KPIs,

\- and reconciliation workflows.



\---



\# high\_value\_flag



A binary flag identifying high-value transactions based on region-specific thresholds.



The following business rules were used:



| Region | Threshold |

|---|---|

| APAC | amount\_usd > 5000 |

| EU | amount\_usd > 6000 |

| US | amount\_usd > 7000 |



Transactions satisfying the corresponding threshold were assigned:



```text

1

```



Otherwise:



```text

0

```



Example formula logic:



```excel

=IF(AND(H2="APAC",K2>5000),1,IF(AND(H2="EU",K2>6000),1,IF(AND(H2="US",K2>7000),1,0)))

```



This flag was used to identify:

\- high-value operational exposure,

\- large transaction concentration,

\- and elevated financial-risk events.



\---



\# high\_risk\_flag



A binary operational-risk indicator was generated using two conditions.



A transaction was classified as high risk when:



\- `risk\_score >= 70`

OR

\- transaction status contained `"chargeback"`



Transactions satisfying either condition were assigned:



```text

1

```



Otherwise:



```text

0

```



Example implementation:



```excel

=IF(OR(G2>=70,ISNUMBER(SEARCH("chargeback",LOWER(F2)))),1,0)

```



This field was later used for:

\- merchant risk analysis,

\- payment-method risk comparison,

\- regional risk aggregation,

\- and dashboard visualization.



\---



\# Pivot Table Analysis



Multiple pivot tables were created to summarize transaction behavior across operational dimensions.



These pivots enabled:

\- merchant-level analysis,

\- payment-channel analysis,

\- and region-level risk assessment.



\---



\# Merchant\_Summary Pivot



A merchant-level pivot table was created using the cleaned transaction dataset.



Rows:

\- `merchant\_name`



Values:

\- Count of `transaction\_id`

\- Sum of `amount\_usd`

\- Average of `risk\_score`

\- Sum of `high\_risk\_flag`



This pivot table produced:

\- total transaction volume by merchant,

\- total GMV contribution,

\- average merchant risk exposure,

\- and high-risk transaction counts.



The pivot helped identify:

\- high-volume merchants,

\- merchants with elevated operational risk,

\- and GMV concentration patterns.



\---



\# Payment\_Method\_Analysis Pivot



A payment-method pivot table was created to compare operational behavior across transaction channels.



Rows:

\- `payment\_method`



Values:

\- Count of `transaction\_id`

\- Sum of `amount\_usd`

\- Sum of `high\_risk\_flag`



This analysis enabled comparison of:

\- transaction volume,

\- GMV contribution,

\- and risk exposure



across payment methods such as:

\- Card,

\- UPI,

\- Wallet,

\- and NetBanking.



\---



\# Region\_Risk\_Analysis Pivot



A regional risk pivot table was created using gateway or merchant regions.



Rows:

\- `gateway\_region`



Values:

\- Count of `transaction\_id`

\- Sum of `amount\_usd`

\- Average of `risk\_score`

\- Sum of `high\_risk\_flag`



This pivot highlighted:

\- regional transaction concentration,

\- operational exposure,

\- and differences in average transaction risk across regions.



\---



\# Output Files Generated



The spreadsheet phase generated the following files:



| File | Purpose |

|---|---|

| cleaned\_transactions.csv | Cleaned and enriched transaction dataset |

| merchant\_risk\_summary.csv | Merchant-level operational and risk summary |

| spreadsheet\_workbook.xlsx | Full spreadsheet workbook containing all analysis sheets |



\---



\# Key Insights



\## Merchant Concentration



A relatively small number of merchants contributed a disproportionately large share of total GMV.



This indicated meaningful merchant-level concentration in transaction activity.



\---



\## High-Risk Transaction Clustering



High-risk transactions were concentrated among specific merchants and payment methods rather than being evenly distributed across the system.



\---



\## Chargeback Exposure



Certain merchants demonstrated elevated chargeback activity relative to transaction volume, indicating higher operational and fraud-related exposure.



\---



\## Regional Risk Differences



Average transaction risk and GMV exposure varied meaningfully across regions, highlighting operational differences in transaction behavior across APAC, EU, and US markets.



\---



\# Conclusion



The spreadsheet workflow established the cleaned and enriched analytical foundation used throughout the remainder of the project.



The outputs generated during this phase supported:

\- SQL querying,

\- Python reconciliation workflows,

\- JSON normalization,

\- and dashboard-based business monitoring.

