# Layoffs Data Cleaning Project

This project is part of Alex The Analyst - Data Analyst BootCamp which focuses on cleaning and preparing a dataset of company layoffs for analysis. The raw data includes records of layoffs across various industries, locations, and stages.

### Dataset
- **Source**: [Layoffs Dataset](https://github.com/AlexTheAnalyst/MySQL-YouTube-Series/blob/main/layoffs.csv)
- **Raw Data**: Contains inconsistencies, null values, and duplicate rows.

### Objective
To clean and standardize the data for further analysis by:
- Removing duplicates
- Standardizing fields (e.g., dates, industries)
- Filling or handling missing values
- Adding a primary key for easy identification

### Tools Used
- **MySQL** for querying and cleaning
- **MySQL Workbench** for MySQL IDE
- **GitHub** for version control

### How to Reproduce
1. Create schema with name `world_layoffs`.
2. Load the raw dataset (`layoffs.csv`) into the schema.
3. Run the SQL queries in (`layoffs_cleaning.sql`).
4. Review the cleaned dataset (`layoffs_cleaned.csv`).

---

# Exploratory Data Analysis (EDA)

## Objective
The goal of this exploratory data analysis (EDA) is to uncover patterns, trends, and insights in the layoffs dataset. This includes analyzing industry distributions, trends over time, and relationships between different variables.

### Approach

The EDA process involved the following steps:

1. **Dataset Overview**
   - Analyzed basic statistics for numeric columns (e.g., minimum, maximum, average, standard deviation).
   - Identified the frequency distribution of industries and countries.

2. **Trends Over Time**
   - Evaluated layoffs over time by month and quarter.
   - Analyzed temporal patterns to understand when layoffs peaked.

3. **Category Comparisons**
   - Compared layoffs across industries, countries, and startup stages.
   - Highlighted the top 10 industries and countries most affected by layoffs.

4. **Correlation Analysis**
   - Explored potential relationships between variables like total layoffs and percentage laid off.
   - Analyzed the relationship between funds raised and layoffs.

5. **Anomaly Detection**
   - Identified outliers in the dataset (e.g., unusually high layoffs).
   - Flagged uncommon countries with very few records.

### Key Findings

1. The top industries affected by layoffs include Technology, Crypto, and Retail.

2. Layoffs peaked during [insert timeframe after query execution].

3. Significant layoffs occurred in [insert countries after query execution].

4. There is a potential correlation between startup stage and layoffs, as [insert stage insight].

5. Anomalies in the data suggest outliers worth further investigation.

### Usage

The SQL queries used for this analysis are documented in the `layoffs_eda.sql` file. To replicate the analysis, execute the queries in order on the `layoffs_cleaned` table.

### Important
You could follow Alex The Analyst BootCamp on [YouTube](https://www.youtube.com/playlist?list=PLUaB-1hjhk8FE_XZ87vPPSfHqb6OcM0cF). It is free, and you could learn a lot of things about Data Analysis.