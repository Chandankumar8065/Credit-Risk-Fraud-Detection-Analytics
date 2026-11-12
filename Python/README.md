# Python Analysis

## Notebook

[Credit_Risk_Fraud_Analysis.ipynb](Credit_Risk_Fraud_Analysis.ipynb) contains the project's Python workflow for data inspection, quality checks, relationship validation, date/range checks, repayment analysis, and exploratory analysis.

## Data location

The cleaned datasets are stored in ../datasets/cleaned/ relative to this folder:

- customers_cleaned.csv.gz
- applications_cleaned.csv.gz
- loans_cleaned.csv.gz
- transactions_cleaned.csv.gz
- repayments_cleaned.csv.gz

Pandas can read gzip-compressed CSV files directly:

    import pandas as pd
    customers = pd.read_csv("../datasets/cleaned/customers_cleaned.csv.gz")
    applications = pd.read_csv("../datasets/cleaned/applications_cleaned.csv.gz")
    loans = pd.read_csv("../datasets/cleaned/loans_cleaned.csv.gz")
    transactions = pd.read_csv("../datasets/cleaned/transactions_cleaned.csv.gz")
    repayments = pd.read_csv("../datasets/cleaned/repayments_cleaned.csv.gz")

For a low-memory computer, avoid loading all five full datasets simultaneously. Read only the columns required for a task or use chunked loading:

    for chunk in pd.read_csv(
        "../datasets/cleaned/transactions_cleaned.csv.gz",
        compression="gzip",
        chunksize=50000
    ):
        # Process one chunk at a time
        pass

## Reproducibility

The analysis was developed in Google Colab. If a notebook cell still points to a personal Google Drive path, update that cell to the repository-relative path shown above before running locally. Install the notebook's required Python packages in the active environment if they are not already available.

See the [Data Validation Report](../Documentation/Data_Validation.md) for recorded checks and the [Key Findings](../Documentation/Key_Findings.md) for the principal analytical results and caveats.
