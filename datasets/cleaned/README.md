# Cleaned Datasets

This directory contains the five cleaned, gzip-compressed CSV datasets used in the Credit Risk & Fraud Detection Analytics project.

## Inventory

| File | Records | Columns |
|---|---:|---:|
| customers_cleaned.csv.gz | 87,719 | 9 |
| applications_cleaned.csv.gz | 131,579 | 11 |
| loans_cleaned.csv.gz | 65,789 | 12 |
| transactions_cleaned.csv.gz | 438,601 | 13 |
| repayments_cleaned.csv.gz | 526,312 | 9 |
| **Total** | **1,250,000** | — |

## Reading the files

Pandas supports gzip-compressed CSV files directly:

    import pandas as pd
    df = pd.read_csv("customers_cleaned.csv.gz", compression="gzip")

To extract a file manually, use a utility that supports gzip. For large datasets, use chunked reading or load only the columns required for the analysis.

## Data quality

The recorded validation covered row counts, null cells, duplicate rows, primary-key uniqueness, and referential integrity. See the [Data Validation Report](../../Documentation/Data_Validation.md).

## Important

All data and outcome labels are synthetic and intended for learning and portfolio demonstration only. They must not be used for real lending, credit decisions, fraud investigations, or regulatory reporting.
