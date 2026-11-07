# 📊 Global Corporate Layoffs: Exploratory Data Analysis (EDA) in MySQL

## 📌 Project Overview
This repository contains a comprehensive **Exploratory Data Analysis (EDA)** project conducted on a global corporate layoffs dataset (`layoff_learner2`) using MySQL. The goal of this analysis is to uncover macroeconomic trends, evaluate industry-wide impacts, measure cumulative monthly layoff progressions, and rank top-impacted companies and sectors across different time horizons.

The project moves from basic descriptive aggregations to complex SQL analytics using **Common Table Expressions (CTEs)**, **Window Functions**, and **Part-to-Whole Ratio (Percentage Market Share) Calculations**.

---

## 🔍 Key Business & Analytical Questions Answered

1. **Severity & Outliers:** What were the largest single-day layoff events, and which companies completely shut down (100% staff laid off)[cite: 1]?
2. **Geographic & Industry Impact:** Which countries and industries recorded the highest volume of total job cuts globally[cite: 1]?
3. **Timeline & Rolling Totals:** How did global layoffs accumulate sequentially month-by-month over a 2+ year period[cite: 1]?
4. **Annual Company Rankings:** Who were the top 5 companies responsible for the highest number of layoffs each year using non-overlapping dense ranks[cite: 1]?
5. **Peak Impact Months:** What was the single "worst month" on record for every individual company[cite: 1]?
6. **Part-to-Whole Market Share:** What percentage of total annual layoffs did a single company account for in any given year[cite: 1]?

---

## 🛠️ Tech Stack & SQL Concepts Demonstrated

* **Database Engine:** MySQL 8.0+
* **Window Functions:** `SUM() OVER ()`, `SUM() OVER (ORDER BY ...)`, and `SUM() OVER (PARTITION BY ...)` for running totals and group sub-totals[cite: 1].
* **Advanced Ranking Functions:** `DENSE_RANK()` and `ROW_NUMBER()` for annual company leaderboards and peak event filtering[cite: 1].
* **Multi-Stage CTEs (`WITH` clauses):** Modular, multi-level CTE pipelines for step-by-step data transformation and sub-query isolation[cite: 1].
* **Data Parsing & Aggregation:** `SUBSTR()`, `SUBSTRING()`, `YEAR()`, `MIN()`, `MAX()`, and `GROUP BY` grouping routines[cite: 1].
* **Proportional Analysis:** Calculating individual company market share ratios against dynamic yearly totals[cite: 1].

---

## 📂 Repository Structure

```text
├── machala_mysql_exploratory data.sql  # Main SQL script with annotated EDA queries
└── README.md                           # Documentation and project overview
