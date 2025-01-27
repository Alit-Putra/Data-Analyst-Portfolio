-- Exploratory Data Analysis (EDA) Queries

-- 1. Understand Dataset Overview

-- Summary statistics for numeric columns
SELECT 
    MIN(total_laid_off) AS min_laid_off,
    MAX(total_laid_off) AS max_laid_off,
    AVG(total_laid_off) AS avg_laid_off,
    STD(total_laid_off) AS std_laid_off
FROM layoffs_cleaned;

-- Frequency distribution of industries
SELECT industry, COUNT(*) AS count
FROM layoffs_cleaned
GROUP BY industry
ORDER BY count DESC;

-- Frequency distribution of countries
SELECT country, COUNT(*) AS count
FROM layoffs_cleaned
GROUP BY country
ORDER BY count DESC;

-- 2. Trends Over Time

-- Layoffs by month
SELECT 
    DATE_FORMAT(date, '%Y-%m') AS month, 
    SUM(total_laid_off) AS total_laid_off
FROM layoffs_cleaned
GROUP BY month
ORDER BY month;

-- Layoffs by quarter
SELECT 
    QUARTER(date) AS quarter, 
    YEAR(date) AS year, 
    SUM(total_laid_off) AS total_laid_off
FROM layoffs_cleaned 
GROUP BY year, quarter
ORDER BY year, quarter;

-- 3. Compare Categories

-- Top 10 industries affected by layoffs
SELECT industry, SUM(total_laid_off) AS total_laid_off
FROM layoffs_cleaned
GROUP BY industry
ORDER BY total_laid_off DESC;

-- Layoffs by country
SELECT country, SUM(total_laid_off) AS total_laid_off
FROM layoffs_cleaned
GROUP BY country
ORDER BY total_laid_off DESC;

-- Layoffs by startup stage
SELECT stage, SUM(total_laid_off) AS total_laid_off
FROM layoffs_cleaned
GROUP BY stage
ORDER BY total_laid_off DESC;

-- 4. Correlation Analysis

-- Layoff size vs percentage
SELECT 
    total_laid_off, 
    percentage_laid_off
FROM layoffs_cleaned
WHERE total_laid_off IS NOT NULL AND percentage_laid_off IS NOT NULL;

-- Funding vs layoffs
SELECT 
    funds_raised_millions, 
    total_laid_off
FROM layoffs_cleaned
WHERE funds_raised_millions IS NOT NULL AND total_laid_off IS NOT NULL;

-- 5. Spot Anomalies

-- Outliers in layoffs
SELECT *
FROM layoffs_cleaned
WHERE total_laid_off > (SELECT AVG(total_laid_off) + 2 * STD(total_laid_off) FROM layoffs_cleaned)
   OR total_laid_off < (SELECT AVG(total_laid_off) - 2 * STD(total_laid_off) FROM layoffs_cleaned);

-- Uncommon countries with very few records
SELECT country, COUNT(*) AS count
FROM layoffs_cleaned
GROUP BY country
HAVING count < 5;
