# Wan Yang — Portfolio

Master of Information Technology student at the University of Technology Sydney, based in Sydney, building practical analytics projects with SQL, Python, relational data modelling, and business-focused analysis.

[LinkedIn](https://www.linkedin.com/in/wan-yang0630/)

## Portfolio contents

- [Featured projects](#featured-projects)
- [SQL](#sql)
- [Python](#python)
- [Skills demonstrated](#skills-demonstrated)
- [About me](#about-me)

## Featured projects

### Depop Marketplace SQL Database

| Project | Tools | What it demonstrates |
|---|---|---|
| [Open project](https://github.com/wanyangportfoliooo/secondhand-marketplace-sql) | PostgreSQL, SQL, relational modelling | Designed a normalised marketplace database covering users, listings, categories, transactions, shipments, and social relationships. Added integrity constraints, reusable views, sample data, and analytical queries. |

**Business question:** How can a second-hand fashion marketplace structure reliable operational data and make it usable for listing, sales, customer, and engagement analysis?

**Key deliverables**

- Eight related tables with primary, foreign, composite, and self-referencing keys
- Validation rules for prices, dates, ratings, listing condition, transaction status, and shipment status
- Two reusable reporting views
- Five analysis examples using joins, aggregation, subqueries, and self-joins
- A documented data model and decision-oriented findings

**Illustrative findings from the included sample data**

- Completed transactions total **AUD 380** and generate **AUD 38** in platform fees.
- The five rated purchases average **4.4/5**.
- One of eight listings has no transaction, making unsold inventory easy to identify for seller follow-up.

[Read the full case study →](https://github.com/wanyangportfoliooo/secondhand-marketplace-sql)

### Airline Passenger Satisfaction Analysis

| Project | Tools | What it demonstrates |
|---|---|---|
| [Open project](https://github.com/wanyangportfoliooo/airline-passenger-satisfaction) | Python, pandas, Jupyter, matplotlib, seaborn, scikit-learn | Completed an end-to-end, reproducible analysis of airline passenger survey data, covering data quality, exploratory analysis, model comparison, and predictions for an unlabelled dataset. |

**Business question:** Which passenger and service patterns are associated with satisfaction, and how well can a validated model identify satisfied passengers in unseen data?

**Key deliverables**

- Six reproducible notebooks, from data understanding through unknown-set predictions
- Two published figures for the main exploratory and evaluation results
- A documented modelling process with a locked holdout, cross-validation, and stated limitations

**Key findings**

- Business travellers had a **58.17%** satisfaction rate, compared with **10.36%** for personal travellers. Business-class passengers recorded **69.33%** satisfaction, compared with **24.30%** in Eco Plus and **18.74%** in Eco. Business travellers in Business class reached **71.95%**, while every personal-travel cabin segment remained below 13%.
- Online boarding produced the largest average rating gap between satisfied and neutral/dissatisfied passengers (**1.372 points**). Several service scores showed a marked increase in satisfaction between ratings 3 and 4.
- A locked Random Forest reached **96.38% accuracy**, **97.36% precision**, **94.21% recall**, **95.76% F1**, and **99.47% ROC-AUC** on an untouched 20% final holdout (601 errors among 16,625 rows). Holdout results closely matched development cross-validation.
- The final model predicted **8,769 satisfied passengers (42.20%)** in the unlabelled dataset of 20,781 records. This is a predicted rate, not an accuracy estimate.
- Results are predictive associations, not causal effects. The meaning of service score `0` is not documented in the source materials and is treated as a limitation.

**Figures**

- [Satisfaction rate by travel type and cabin class](https://github.com/wanyangportfoliooo/airline-passenger-satisfaction/blob/main/images/travel_type_and_class.png)
- [Final holdout confusion matrix and ROC curve](https://github.com/wanyangportfoliooo/airline-passenger-satisfaction/blob/main/images/final_model_evaluation.png)

**Notebooks**

- [01 Data understanding](https://github.com/wanyangportfoliooo/airline-passenger-satisfaction/blob/main/notebooks/01_data_understanding.ipynb)
- [02 Exploratory analysis](https://github.com/wanyangportfoliooo/airline-passenger-satisfaction/blob/main/notebooks/02_exploratory_analysis.ipynb)
- [03 Baseline models](https://github.com/wanyangportfoliooo/airline-passenger-satisfaction/blob/main/notebooks/03_baseline_models.ipynb)
- [04 Tree models](https://github.com/wanyangportfoliooo/airline-passenger-satisfaction/blob/main/notebooks/04_tree_models.ipynb)
- [05 Model selection and final evaluation](https://github.com/wanyangportfoliooo/airline-passenger-satisfaction/blob/main/notebooks/05_model_selection_and_final_evaluation.ipynb)
- [06 Unknown predictions](https://github.com/wanyangportfoliooo/airline-passenger-satisfaction/blob/main/notebooks/06_unknown_predictions.ipynb)

The labelled dataset contains 83,123 passengers. Raw CSV files remain excluded until their redistribution licence is confirmed.

[Read the full case study →](https://github.com/wanyangportfoliooo/airline-passenger-satisfaction)

## SQL

| Project | Area of analysis | Project description |
|---|---|---|
| [Depop Marketplace SQL Database](https://github.com/wanyangportfoliooo/secondhand-marketplace-sql) | Data modelling, data integrity, marketplace analysis | Builds a PostgreSQL database from schema to analysis, including reusable views for listing details and user transaction summaries. |

## Python

| Project | Area of analysis | Project description |
|---|---|---|
| [Airline Passenger Satisfaction Analysis](https://github.com/wanyangportfoliooo/airline-passenger-satisfaction) | Data quality, exploratory analysis, classification | Audits the supplied datasets, explores passenger and service patterns, compares baseline and tree-based models, and generates predictions for an unlabelled file. |
| [Magic Squares: CSP, SA and GA](https://github.com/wanyangportfoliooo/magic-squares-search) | Search algorithms, experiment design, performance comparison | Compares constraint propagation with backtracking, Simulated Annealing and a Genetic Algorithm on N × N magic squares over 900 timed runs, and explains when each method works or fails. |

## Skills demonstrated

| Skill | Evidence |
|---|---|
| SQL | Joins, aggregations, subqueries, `NOT EXISTS`, self-joins, views |
| Python | pandas-based profiling, validation checks, reusable functions, notebook workflows, exploratory charts, classification with scikit-learn, and search algorithms with NumPy |
| Data modelling | One-to-many, many-to-many, and self-referencing relationships |
| Data quality | `PRIMARY KEY`, `FOREIGN KEY`, `CHECK`, `UNIQUE`, and `NOT NULL` constraints; missingness, duplicate, and consistency checks |
| Business analysis | Marketplace sales, fee, inventory, brand, customer, and social-network questions; passenger satisfaction patterns by travel purpose and cabin class |
| Documentation | Reproducible setup instructions, schema explanation, findings, limitations, and recommendations |

## About me

I am developing my data analytics portfolio around clear business questions, reproducible analysis, and concise communication of results. I am based in Sydney and building this portfolio for data analyst roles in Australia. Each project listed here can be inspected in the linked source files.

- LinkedIn: https://www.linkedin.com/in/wan-yang0630/

Portfolio last updated: November 2026.
