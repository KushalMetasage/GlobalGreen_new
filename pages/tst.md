
<LineChart
data = {test}
x = month_sort
y = period_value
sort = true
/>


```sql test
WITH base AS (
    SELECT 
        entity,
        metric,
        metric_type,
        date_my AS month,
        EXTRACT(YEAR FROM date_my) AS year,
        EXTRACT(MONTH FROM date_my) AS month_num,
        STRFTIME(date_my, '%b-%y') AS month_label,
        period_value AS value
    FROM income_statement
    WHERE 
        entity = CASE 'Global Green India'
            WHEN 'GGCL' THEN 'Global Green India'
            WHEN 'GGE' THEN 'Global Green Europe'
        END
        AND metric = 'EBITDA'
        AND metric_type = 'Actual'
        AND date_my IS NOT NULL
),

filtered AS (
    SELECT 
        metric,
        month,
        CAST(month_num AS INTEGER) AS month_sort,
        month_label,
        value
    FROM base
    WHERE month >= '2024-01-01'
),

with_lag AS (
    SELECT 
        metric,
        month,
        month_label,
        month_sort,
        value AS Monthly,
        LAG(value) OVER (PARTITION BY metric ORDER BY month) AS prev_month_value
    FROM filtered
),

with_mom AS (
    SELECT 
        metric,
        month_label,
        month_sort,
        Monthly,
        prev_month_value,
        CASE 
            WHEN prev_month_value IS NULL THEN 'Base Month'
            WHEN ABS(prev_month_value) < 0.0001 THEN 'N/A'
            ELSE CAST(ROUND((Monthly - prev_month_value) / ABS(prev_month_value), 2) AS TEXT)
        END AS mom_change
    FROM with_lag
)

SELECT 
    metric,
    month_label,
    month_sort,
    Monthly,
    prev_month_value,
    mom_change
FROM with_mom
ORDER BY month_sort;
```