# Wan-Lin Yang — Portfolio

Master of Information Technology student at the University of Technology Sydney, building practical analytics projects with SQL, relational data modelling, and business-focused analysis.

## Portfolio contents

- [Featured project](#featured-project)
- [SQL](#sql)
- [Python](#python)
- [Skills demonstrated](#skills-demonstrated)
- [About me](#about-me)

## Featured project

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

### Airline Passenger Satisfaction Analysis — Work in progress

| Project | Tools | Current stage |
|---|---|---|
| [Open project](https://github.com/wanyangportfoliooo/airline-passenger-satisfaction) | Python, pandas, Jupyter, matplotlib, seaborn | Completed a reproducible data-understanding and quality-assurance notebook covering target balance, missingness, duplicate checks, category consistency, numeric ranges, and train/unknown compatibility. |

**Verified dataset profile**

- 83,123 training records and 20,781 unknown records
- Binary target: 43.33% satisfied and 56.67% neutral or dissatisfied
- No duplicate rows or overlapping IDs between the supplied files
- `Arrival Delay in Minutes` is the only field with missing values (approximately 0.3%)
- Raw CSV files remain excluded until their redistribution licence is confirmed

[Review the current notebook →](https://github.com/wanyangportfoliooo/airline-passenger-satisfaction/blob/main/notebooks/01_data_understanding.ipynb)

## SQL

| Project | Area of analysis | Project description |
|---|---|---|
| [Depop Marketplace SQL Database](https://github.com/wanyangportfoliooo/secondhand-marketplace-sql) | Data modelling, data integrity, marketplace analysis | Builds a PostgreSQL database from schema to analysis, including reusable views for listing details and user transaction summaries. |

## Python

| Project | Area of analysis | Project description |
|---|---|---|
| [Airline Passenger Satisfaction Analysis](https://github.com/wanyangportfoliooo/airline-passenger-satisfaction) | Data quality, exploratory foundations, classification preparation | Audits supplied training and prediction datasets before modelling. The project is being rebuilt incrementally so that every published result is reproducible and understood. |

## Skills demonstrated

| Skill | Evidence |
|---|---|
| SQL | Joins, aggregations, subqueries, `NOT EXISTS`, self-joins, views |
| Python | pandas-based profiling, validation checks, reusable functions, and notebook workflows |
| Data modelling | One-to-many, many-to-many, and self-referencing relationships |
| Data quality | `PRIMARY KEY`, `FOREIGN KEY`, `CHECK`, `UNIQUE`, and `NOT NULL` constraints |
| Business analysis | Marketplace sales, fee, inventory, brand, customer, and social-network questions |
| Documentation | Reproducible setup instructions, schema explanation, findings, and recommendations |

## About me

I am developing my data analytics portfolio around clear business questions, reproducible analysis, and concise communication of results. Each project in this repository is based on work that can be inspected in the linked source files.

Portfolio last updated: August 2026.
