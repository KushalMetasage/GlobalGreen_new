## 📝 Performance Overview

<div class="flex items-center justify-between w-full">
<ButtonGroup name="matric" display="tabs">
        <ButtonGroupItem valueLabel="Global Green India" value="GGCL" default />
        <ButtonGroupItem valueLabel="Global Green Europe" value="GGE" />
</ButtonGroup>
</div>

## 📈 MoM Trend – EBITDA
<div class = 'mb-5'> </div>

<LineChart 
  data={overview_EBITDA}
  x="month"
  y="mom_change"
  yFmt=".2f" 
  yAxisTitle = "Values are in Million"
  series="metric"
  markers={true}
/>

## 📈 MoM Trend – PBT
<div class = 'mb-5'> </div>

<LineChart 
  data={overview_PBT}
  x="month"
  y="mom_change"
  yAxisTitle = "Values are in Million"
  series="metric"
  markers={true}
/>

## 📈 MoM Trend – PAT
<div class = 'mb-5'> </div>

<LineChart 
  data={overview_PAT}
  x="month"
  y="mom_change"
  yAxisTitle = "Values are in Million"
  series="metric"
  markers={true}
/>

## 📈 YoY Trend – EBITDA
<div class = 'mb-5'> </div>

<LineChart 
  data={overview_EBITDA_yoy}
  x="year"
  y="yoy_change"
  markers={true}
  yFmt=".2f"
  yAxisTitle = "Values are in Million"
/>

## 📈 YoY Trend – PBT
<div class = 'mb-5'> </div>

<LineChart 
  data={overview_PBT_yoy}
  x="year"
  y="yoy_change"
  markers={true}
  yAxisTitle = "Values are in Million"
  yFmt=".2f"
/>

## 📈 YoY Trend – PAT
<div class = 'mb-5'> </div>

<LineChart 
  data={overview_PAT_yoy}
  x="year"
  y="yoy_change"
  markers={true}
  yAxisTitle = "Values are in Million"
  yFmt=".2f"
/>

<div class = 'mb-15'> </div>



```sql date_filter
SELECT DISTINCT 
  STRFTIME(STRPTIME(period_date, '%b-%y'), '%Y') AS date_filter,
  MIN(STRPTIME(period_date, '%b-%y')) AS date_sort  -- optional for sorting
FROM income_statement
WHERE TRIM(period_date) IS NOT NULL
  AND TRIM(period_date) <> ''
GROUP BY date_filter
ORDER BY date_sort DESC;

```

```sql overview_EBITDA
WITH base AS (
    SELECT 
        entity,
        metric,
        metric_type,
        STRPTIME(period_date, '%b-%y') AS month,
        STRFTIME(STRPTIME(period_date, '%b-%y'), '%b-%y') AS month_label,
        period_value AS value
    FROM income_statement
    WHERE 
        entity = CASE '${inputs.matric}'
            WHEN 'GGCL' THEN 'Global Green India'
            WHEN 'GGE' THEN 'Global Green Europe'
        END
        AND metric = 'EBITDA'
        AND metric_type = 'Actual'
),
with_lag AS (
    SELECT 
        metric,
        month,
        value,
        LAG(value) OVER (PARTITION BY metric ORDER BY month) AS prev_month_value
    FROM base
),
with_mom AS (
    SELECT 
        metric,
        month,
        value AS current_month_value,
        prev_month_value,
        CASE 
            WHEN prev_month_value IS NULL THEN 'Base Month'
            WHEN ABS(prev_month_value) < 0.0001 THEN 'N/A'
            ELSE CAST(ROUND((value - prev_month_value) / ABS(prev_month_value), 2) AS TEXT)
        END AS mom_change
    FROM with_lag
)

SELECT 
    metric,
    month,
    current_month_value,
    prev_month_value,
    mom_change
FROM with_mom
ORDER BY metric, month;

```

```sql overview_PBT
WITH base AS (
    SELECT 
        entity,
        metric,
        metric_type,
        STRPTIME(period_date, '%b-%y') AS month,
        STRFTIME(STRPTIME(period_date, '%b-%y'), '%b-%y') AS month_label,
        period_value AS value
    FROM income_statement
    WHERE 
        entity = CASE '${inputs.matric}'
            WHEN 'GGCL' THEN 'Global Green India'
            WHEN 'GGE' THEN 'Global Green Europe'
        END
        AND metric = 'PBT Before Exceptional'
        AND metric_type = 'Actual'
),
with_lag AS (
    SELECT 
        metric,
        month,
        value,
        LAG(value) OVER (PARTITION BY metric ORDER BY month) AS prev_month_value
    FROM base
),
with_mom AS (
    SELECT 
        metric,
        month,
        value AS current_month_value,
        prev_month_value,
        CASE 
            WHEN prev_month_value IS NULL THEN 'Base Month'
            WHEN ABS(prev_month_value) < 0.0001 THEN 'N/A'
            ELSE CAST(ROUND((value - prev_month_value) / ABS(prev_month_value), 2) AS TEXT)
        END AS mom_change
    FROM with_lag
)

SELECT 
    metric,
    month,
    current_month_value,
    prev_month_value,
    mom_change
FROM with_mom
ORDER BY metric, month;

```

```sql overview_PAT
WITH base AS (
    SELECT 
        entity,
        metric,
        metric_type,
        STRPTIME(period_date, '%b-%y') AS month,
        STRFTIME(STRPTIME(period_date, '%b-%y'), '%b-%y') AS month_label,
        period_value AS value
    FROM income_statement
    WHERE 
        entity = CASE '${inputs.matric}'
            WHEN 'GGCL' THEN 'Global Green India'
            WHEN 'GGE' THEN 'Global Green Europe'
        END
        AND metric = 'PBT - (from operations)'  -- PAT proxy
        AND metric_type = 'Actual'
),
with_lag AS (
    SELECT 
        metric,
        month,
        value,
        LAG(value) OVER (PARTITION BY metric ORDER BY month) AS prev_month_value
    FROM base
),
with_mom AS (
    SELECT 
        metric,
        month,
        value AS current_month_value,
        prev_month_value,
        CASE 
            WHEN prev_month_value IS NULL THEN 'Base Month'
            WHEN ABS(prev_month_value) < 0.0001 THEN 'N/A'
            ELSE CAST(ROUND((value - prev_month_value) / ABS(prev_month_value), 2) AS TEXT)
        END AS mom_change
    FROM with_lag
)

SELECT 
    metric,
    month,
    current_month_value,
    prev_month_value,
    mom_change
FROM with_mom
ORDER BY metric, month;

```

```sql overview_EBITDA_yoy
WITH base AS (
    SELECT 
        entity,
        TRIM(metric) AS metric,
        metric_type,
        CAST(STRFTIME(STRPTIME(period_date, '%b-%y'), '%Y') AS INTEGER) AS year,  
        period_value AS value
    FROM income_statement
    WHERE 
        entity = CASE '${inputs.matric}'
            WHEN 'GGCL' THEN 'Global Green India'
            WHEN 'GGE' THEN 'Global Green Europe'
        END
        AND TRIM(metric) = 'EBITDA'
        AND TRIM(metric_type) = 'Actual'
        AND period_value IS NOT NULL
),
yearly_agg AS (
    SELECT 
        entity,
        metric,
        year,
        SUM(value) AS current_year_value
    FROM base
    GROUP BY entity, metric, year
),
with_yoy AS (
    SELECT 
        entity,
        metric,
        year,
        current_year_value,
        LAG(current_year_value) OVER (PARTITION BY entity, metric ORDER BY year) AS prev_year_value
    FROM yearly_agg
),
final AS (
    SELECT 
        entity,
        metric,
        year,
        current_year_value,
        prev_year_value,
        CASE 
            WHEN prev_year_value IS NULL THEN 'Base Year'
            WHEN prev_year_value = 0 THEN 'N/A'
            ELSE CAST(ROUND((current_year_value - prev_year_value) / prev_year_value, 2) AS TEXT)
        END AS yoy_change
    FROM with_yoy
)

SELECT *
FROM final
ORDER BY entity, metric, year;

```

```sql overview_PBT_yoy
WITH base AS (
    SELECT 
        entity,
        TRIM(metric) AS metric,
        metric_type,
        CAST(STRFTIME(STRPTIME(period_date, '%b-%y'), '%Y') AS INTEGER) AS year,  
        period_value AS value
    FROM income_statement
    WHERE 
        entity = CASE '${inputs.matric}'
            WHEN 'GGCL' THEN 'Global Green India'
            WHEN 'GGE' THEN 'Global Green Europe'
        END
        AND TRIM(metric) = 'PBT Before Exceptional'
        AND TRIM(metric_type) = 'Actual'
        AND period_value IS NOT NULL
),
yearly_agg AS (
    SELECT 
        entity,
        metric,
        year,
        SUM(value) AS current_year_value
    FROM base
    GROUP BY entity, metric, year
),
with_yoy AS (
    SELECT 
        entity,
        metric,
        year,
        current_year_value,
        LAG(current_year_value) OVER (PARTITION BY entity, metric ORDER BY year) AS prev_year_value
    FROM yearly_agg
),
final AS (
    SELECT 
        entity,
        metric,
        year,
        current_year_value,
        prev_year_value,
        CASE 
            WHEN prev_year_value IS NULL THEN 'Base Year'
            WHEN prev_year_value = 0 THEN 'N/A'
            ELSE CAST(ROUND((current_year_value - prev_year_value) / prev_year_value, 2) AS TEXT)
        END AS yoy_change
    FROM with_yoy
)

SELECT *
FROM final
ORDER BY entity, metric, year;

```

```sql overview_PAT_yoy
WITH base AS (
    SELECT 
        entity,
        TRIM(metric) AS metric,
        metric_type,
        CAST(STRFTIME(STRPTIME(period_date, '%b-%y'), '%Y') AS INTEGER) AS year,  
        period_value AS value
    FROM income_statement
    WHERE 
        entity = CASE '${inputs.matric}'
            WHEN 'GGCL' THEN 'Global Green India'
            WHEN 'GGE' THEN 'Global Green Europe'
        END
        AND TRIM(metric) = 'PBT - (from operations)'
        AND TRIM(metric_type) = 'Actual'
        AND period_value IS NOT NULL
),
yearly_agg AS (
    SELECT 
        entity,
        metric,
        year,
        SUM(value) AS current_year_value
    FROM base
    GROUP BY entity, metric, year
),
with_yoy AS (
    SELECT 
        entity,
        metric,
        year,
        current_year_value,
        LAG(current_year_value) OVER (PARTITION BY entity, metric ORDER BY year) AS prev_year_value
    FROM yearly_agg
),
final AS (
    SELECT 
        entity,
        metric,
        year,
        current_year_value,
        prev_year_value,
        CASE 
            WHEN prev_year_value IS NULL THEN 'Base Year'
            WHEN prev_year_value = 0 THEN 'N/A'
            ELSE CAST(ROUND((current_year_value - prev_year_value) / prev_year_value, 2) AS TEXT)
        END AS yoy_change
    FROM with_yoy
)

SELECT *
FROM final
ORDER BY entity, metric, year;

```