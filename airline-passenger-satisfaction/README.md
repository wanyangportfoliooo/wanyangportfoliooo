# Airline Passenger Satisfaction Analysis

An educational, reproducible rebuild of a binary-classification assignment using airline passenger survey data.

## Current stage

The first notebook audits the two supplied datasets and establishes the modelling grain, target definition, missingness, uniqueness, valid ranges, and train/unknown consistency. No model is selected at this stage.

## Project structure

```text
airline-passenger-satisfaction/
├── data/
│   └── raw/                 # Local-only CSV inputs; ignored by Git
├── notebooks/
│   └── 01_data_understanding.ipynb
├── .gitignore
└── README.md
```

## Run locally

1. Put the supplied CSV files in `data/raw/` with their original filenames.
2. Open `notebooks/01_data_understanding.ipynb` in Jupyter or VS Code.
3. Select a Python environment containing pandas, matplotlib and seaborn.
4. Run all cells from top to bottom.

## Dataset note

The raw files are intentionally excluded from Git. Their original source and redistribution licence still need to be confirmed before publication.

## Planned notebooks

- `01_data_understanding.ipynb` — data quality and exploratory foundations
- `02_exploratory_analysis.ipynb` — customer segments and satisfaction drivers
- `03_baseline_models.ipynb` — dummy and logistic-regression baselines
- `04_tree_models.ipynb` — decision tree and random forest
- `05_model_evaluation.ipynb` — cross-validation, test evaluation and threshold selection

