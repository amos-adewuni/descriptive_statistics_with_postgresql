-- Calculating Mean
SELECT 
    ROUND(AVG(age)) AS mean_age,
    ROUND(AVG(height),2) AS mean_height,
    ROUND(AVG(weight),2) AS mean_weight
FROM athletes;

-- Calculating Mean of age, height and weight, grouped by gender
SELECT 
    gender,
    ROUND(AVG(age)) AS mean_age,
    ROUND(AVG(height),2) AS mean_height,
    ROUND(AVG(weight),2) AS mean_weight
FROM athletes
GROUP BY gender;
SELECT 
    MAX(age) AS max_age,
    MIN(age) AS min_age
FROM athletes;

-- Calculating Mean of height and weight, grouped by age
SELECT 
    CASE
        WHEN age < 20 THEN '10-19'
        WHEN age < 30 THEN '20-29'
        WHEN age < 40 THEN '30-39'
        WHEN age < 50 THEN '40-49'
        ELSE '50-59' END AS age_group,
    ROUND(AVG(height),2) AS mean_height,
    ROUND(AVG(weight),2) AS mean_weight
FROM athletes
GROUP BY age_group
ORDER BY age_group;

--Median
SELECT 
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY age) AS median_age,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY height) AS median_height,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY weight) AS median_weight
FROM athletes;

--Median
SELECT 
    gender,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY age) AS median_age,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY height) AS median_height,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY weight) AS median_weight
FROM athletes
GROUP BY gender;

--Mode
SELECT 
    MODE() WITHIN GROUP (ORDER BY age) AS modal_age,
    MODE() WITHIN GROUP (ORDER BY height) AS modal_height,
    MODE() WITHIN GROUP (ORDER BY weight) AS modal_weight
FROM athletes;

-- Mode for age,height and weight grouped by gender
SELECT 
    gender,
    MODE() WITHIN GROUP (ORDER BY age) AS modal_age,
    MODE() WITHIN GROUP (ORDER BY height) AS modal_height,
    MODE() WITHIN GROUP (ORDER BY weight) AS modal_weight
FROM athletes  
GROUP BY gender; 

- Measures of Dispersion
-- Range
SELECT 
    MAX(age) - MIN(age) AS range_age,
    MAX(height) - MIN(height) AS range_height,
    MAX(weight) - MIN(weight) AS range_weight
FROM athletes;

-- Range with GROUP BY clause
SELECT
    gender,
    MAX(age) - MIN(age) AS range_age,
    MAX(height) - MIN(height) AS range_height,
    MAX(weight) - MIN(weight) AS range_weight
FROM athletes
GROUP BY gender;

--Variance (Population)
SELECT 
    ROUND(VAR_POP(age),2) AS var_age,  
    ROUND(VAR_POP(height),2) AS var_height,
    ROUND(VAR_POP(weight),2) AS var_weight  
FROM athletes;

--Variance (Sample, grouped by gender)
SELECT 
    gender,
    ROUND(VAR_SAMP(age),2) AS var_age,
    ROUND(VAR_SAMP(height),2) AS var_height,
    ROUND(VAR_SAMP(weight),2) AS var_weight  
FROM athletes
GROUP BY gender;
--Standard Deviation (Population)
SELECT 
    ROUND(STDDEV_POP(age),2) AS std_age,
    ROUND(STDDEV_POP(height),2) AS std_height,
    ROUND(STDDEV_POP(weight),2) AS std_weight  
FROM athletes;

--Standard Deviation (Sample, grouped by gender)
SELECT 
    gender,
    ROUND(STDDEV_SAMP(age),2) AS var_age,
    ROUND(STDDEV_SAMP(height),2) AS var_height,
    ROUND(STDDEV_SAMP(weight),2) AS var_weight  
FROM athletes
GROUP BY gender;

-- Interquartile Range(IQR)
SELECT
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY age) - PERCENTILE_CONT(0.25) 
    WITHIN GROUP ( ORDER BY age ) AS iqr_age,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY  height) - PERCENTILE_CONT(0.25) 
    WITHIN GROUP (ORDER BY height) AS iqr_height,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY weight) - PERCENTILE_CONT(0.25) 
    WITHIN GROUP (ORDER BY weight) AS iqr_weight
FROM athletes; 
-- Interquartile Range(IQR) grouped by gender
SELECT
    gender,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY age) - PERCENTILE_CONT(0.25) 
    WITHIN GROUP ( ORDER BY age ) AS iqr_age,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY  height) - PERCENTILE_CONT(0.25) 
    WITHIN GROUP (ORDER BY height) AS iqr_height,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY weight) - PERCENTILE_CONT(0.25) 
    WITHIN GROUP (ORDER BY weight) AS iqr_weight
FROM athletes
GROUP BY gender;

-- Frequency Distribution
SELECT DISTINCT age, COUNT(*) AS frequency
FROM athletes
GROUP BY age
ORDER BY frequency DESC
LIMIT 5;

-- Cummulative Frequency Distribution
WITH freq_tabl AS (
    SELECT DISTINCT age,
    COUNT(*) AS freq
FROM athletes
GROUP BY age)

SELECT
    age,
    SUM(freq) OVER (ORDER BY age) AS cum_freq
FROM freq_tabl
LIMIT 5;

--Correlation
SELECT 
    CORR(height, weight) AS height_weight_corr
FROM athletes;
