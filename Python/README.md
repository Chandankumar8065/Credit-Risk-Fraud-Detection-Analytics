# Python Analysis

## Notebook

[Credit_Risk_Fraud_Analysis.ipynb](Credit_Risk_Fraud_Analysis.ipynb) contains the project's Python workflow for data inspection, quality checks, relationship validation, date/range checks, repayment analysis and exploratory analysis.

## Run the notebook

1. Clone or download this repository.
2. Install dependencies: `pip install -r requirements.txt` (or install `pandas`, `numpy`, `matplotlib` and `seaborn`).
3. Open the notebook from the repository root or from this `Python/` folder.
4. Keep the five compressed source files in `datasets/cleaned/`. The notebook reads them directly with GZIP support.
5. Run all cells from top to bottom. Output CSVs are written to `outputs/python_analysis/`; the source datasets are not overwritten.

The notebook starts from the committed cleaned datasets. It validates and analyzes them; it does not claim to repeat the original raw-data cleaning process.

## Power BI summary generation

To rebuild the aggregated tables used by the four Power BI reports, run this command from the repository root:

```bash
python Python/build_powerbi_summaries.py
```

The script reads one source dataset at a time and writes 11 CSV summary tables to `PowerBI/summary_data/`. See [the summary data guide](../PowerBI/summary_data/README.md).

## Dataset files

- `customers_cleaned.csv.gz`
- `applications_cleaned.csv.gz`
- `loans_cleaned.csv.gz`
- `transactions_cleaned.csv.gz`
- `repayments_cleaned.csv.gz`

Pandas can read gzip-compressed CSV files directly. For a low-memory computer, the Power BI summary builder reads one source dataset at a time and selects only the required columns.

See the [Data Validation Report](../Documentation/Data_Validation.md) for recorded checks and [Key Findings](../Documentation/Key_Findings.md) for the principal analytical results and caveats.
