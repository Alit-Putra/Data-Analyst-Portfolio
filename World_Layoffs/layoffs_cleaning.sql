-- Layoffs Data Cleaning Project

-- 1. Explore Raw Dataset
-- Preview Dataset
SELECT * FROM layoffs;

-- Check row numbers and unique company count
SELECT COUNT(*) AS total_rows FROM layoffs; -- Expected output: 2361 rows
SELECT COUNT(DISTINCT company) AS unique_companies FROM layoffs; -- Expected output: 1885 rows

-- Check for null or inconsistent data
SELECT * FROM layoffs WHERE total_laid_off IS NULL OR percentage_laid_off IS NULL;
SELECT DISTINCT industry FROM layoffs ORDER BY industry;
SELECT DISTINCT country FROM layoffs ORDER BY country;

-- 2. Remove Duplicate Rows
-- Create a working table to preserve the raw dataset
CREATE TABLE layoffs_cleaned AS SELECT * FROM layoffs;

-- Verify duplicate creation
SELECT id, company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions
FROM layoffs_cleaned;

-- Validate row counts
SELECT COUNT(*) AS total_rows FROM layoffs_cleaned; -- Expected output: 2361 rows
SELECT COUNT(DISTINCT company) AS unique_companies FROM layoffs_cleaned; -- Expected output: 1885 rows

-- Add a primary key for uniqueness
ALTER TABLE layoffs_cleaned ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;
DESCRIBE layoffs_cleaned;

-- Detect duplicate rows
WITH duplicate_finder AS (
    SELECT id, company, location, industry,
           ROW_NUMBER() OVER (
               PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions
           ) AS row_num
    FROM layoffs_cleaned
)
SELECT * FROM duplicate_finder WHERE row_num > 1;

-- Remove duplicate rows
DELETE FROM layoffs_cleaned
WHERE id NOT IN (
    SELECT id FROM (
        SELECT id, ROW_NUMBER() OVER (
            PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions
        ) AS row_num
        FROM layoffs_cleaned
    ) AS numbered_rows
    WHERE row_num = 1
);

-- 3. Standardize Data
-- Remove leading/trailing spaces from company names
UPDATE layoffs_cleaned SET company = TRIM(company);

-- Normalize industry names (e.g., 'CryptoCurrency' to 'Crypto')
UPDATE layoffs_cleaned SET industry = 'Crypto' WHERE industry LIKE 'Crypto%';

-- Convert date to proper format and modify column type
UPDATE layoffs_cleaned SET date = STR_TO_DATE(date, '%m/%d/%Y');
ALTER TABLE layoffs_cleaned MODIFY COLUMN date DATE;

-- Standardize country names (remove trailing periods)
UPDATE layoffs_cleaned SET country = TRIM(TRAILING '.' FROM country);

-- 4. Handle Missing Data
-- Replace empty industry values with NULL for easier handling
UPDATE layoffs_cleaned SET industry = NULL WHERE industry = '';

-- Fill missing industry values based on similar companies
UPDATE layoffs_cleaned t1
JOIN layoffs_cleaned t2
    ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL AND t2.industry IS NOT NULL;

-- Replace remaining NULL values with 'Unknown'
UPDATE layoffs_cleaned SET industry = 'Unknown' WHERE industry IS NULL;
UPDATE layoffs_cleaned SET stage = 'Unknown' WHERE stage IS NULL;

-- 5. Remove Unnecessary Rows
-- Identify rows with multiple critical NULL fields
SELECT * FROM layoffs_cleaned
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL
  AND funds_raised_millions IS NULL;

-- Delete rows with insufficient data
DELETE FROM layoffs_cleaned
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL
  AND funds_raised_millions IS NULL;

-- Final Validation
SELECT * FROM layoffs_cleaned;
