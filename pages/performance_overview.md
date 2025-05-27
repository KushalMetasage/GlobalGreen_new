
## 📝 Performance Overview

<div class="flex items-center justify-between w-full">
<ButtonGroup name="matric" display="tabs">
        <ButtonGroupItem valueLabel="Global Green India" value="GGCL" default />
        <ButtonGroupItem valueLabel="Global Green Europe" value="GGE" />
</ButtonGroup>
</div>

<Grid cols = 3>

## 📈 YoY Trend - EBITDA

<div class="text-align: center; ml-32">

<Dropdown data={date_filter} name=date_filter value=date_filter title="Year" defaultValue="2025" order = 'date_sort desc'>
</Dropdown>

<Info description="Select the year to get the insights for each month." color="red" />

</div>

</Grid>

<div class = 'mb-5'> </div>

<LineChart 
  data={overview_EBITDA_yoy}
  x="year"
  y="EBITDA"
  y2="yoy_change"
  yAxisTitle="Values are in Million"
  y2AxisTitle="YoY Change (%)"
  markers={true}
   echartsOptions={{ 
  xAxis: [{
    max: 'dataMax'
  }]
}}
/>

<LineChart 
  data={sel_year_ebitda}
  x="month"
  y="Monthly"
  y2="mom_change"
  yAxisTitle="Values are in Million"
  y2AxisTitle="MoM Change (%)"
  markers={true}
  sort=true
  xFmt="mmm-yy"
  yFmt=".2f"             
  tooltipTitle="month_label"
  tooltipFmt=".2f"       
  labelFmt=".2f"         
  y2Fmt="percent"
/>



<div class = 'mb-15'> </div>

<Grid cols = 3>

## 📈 YoY Trend - PBT

<div class="text-align: center; ml-32">

<Dropdown data={date_filter_pbt} name=date_filter_pbt value=date_filter_pbt title="Year" defaultValue="2025" order = 'date_sort desc'>
</Dropdown>

<Info description="Select the year to get the insights for each month." color="red" />

</div>

</Grid>

<LineChart 
  data={overview_PBT_yoy}
  x="year"
  y="PBT"
  y2 = "yoy_change"
  markers={true}
  yAxisTitle = "Values are in Million"
  y2AxisTitle = "YoY Change (%)"
  yFmt=".2f"
   echartsOptions={{ 
  xAxis: [{
    max: 'dataMax'
  }]
}}
/>

<LineChart 
  data={sel_year_pbt}
  x="month"
  y="Monthly"
  y2="mom_change"
  yAxisTitle="Values are in Million"
  y2AxisTitle="MoM Change (%)"
  markers={true}
  sort={true}
  xFmt="mmm-yy"
  yFmt=".2f"
  tooltipTitle="month_label"
  tooltipFmt=".2f"
  labelFmt=".2f"
  y2Fmt="percent"
/>

<Grid cols = 3>

## 📈 YoY Trend - PAT

<div class="text-align: center; ml-32">

<Dropdown data={date_filter_pat} name=date_filter_pat value=date_filter_pat title="Year" defaultValue="2025" order = 'date_sort desc'>
</Dropdown>

<Info description="Select the year to get the insights for each month." color="red" />

</div>

</Grid>

<LineChart 
  data={overview_PAT_yoy}
  x="year"
  y="PAT"
  y2 = "yoy_change"
  yAxisTitle = "Values are in Million"
  y2AxisTitle = "YoY Change (%)"
  markers={true}
  yFmt=".2f"
   echartsOptions={{ 
  xAxis: [{
    max: 'dataMax'
  }]
}}
/>

<LineChart 
  data={sel_year_pat}
  x="month"
  y="Monthly"
  y2="mom_change"
  yAxisTitle="Values are in Million"
  y2AxisTitle="MoM Change (%)"
  markers={true}
  sort={true}
  xFmt="mmm-yy"
  yFmt=".2f"
  tooltipTitle="month_label"
  tooltipFmt=".2f"
  labelFmt=".2f"
  y2Fmt="percent"
/>



<div class = 'mb-15'> </div>


```sql date_filter
SELECT DISTINCT 
  CAST(EXTRACT(YEAR FROM date_my) AS TEXT) AS date_filter,
  MIN(DATE_TRUNC('year', date_my)) AS date_sort  
FROM income_statement
WHERE date_my IS NOT NULL
GROUP BY date_filter
ORDER BY date_sort DESC;
```

```sql date_filter_pbt
SELECT DISTINCT 
  CAST(EXTRACT(YEAR FROM date_my) AS TEXT) AS date_filter_pbt,
  MIN(DATE_TRUNC('year', date_my)) AS date_sort  
FROM income_statement
WHERE date_my IS NOT NULL
GROUP BY date_filter_pbt
ORDER BY date_sort DESC;
```

```sql date_filter_pat
SELECT DISTINCT 
  CAST(EXTRACT(YEAR FROM date_my) AS TEXT) AS date_filter_pat,
  MIN(DATE_TRUNC('year', date_my)) AS date_sort  
FROM income_statement
WHERE date_my IS NOT NULL
GROUP BY date_filter_pat
ORDER BY date_sort DESC;
```

```sql overview_EBITDA
WITH base AS (
    SELECT 
        entity,
        metric,
        metric_type,
        date_my AS month,
        STRFTIME(date_my, '%b-%y') AS month_label,
        period_value AS value
    FROM income_statement
    WHERE 
        entity = CASE '${inputs.matric}'
            WHEN 'GGCL' THEN 'Global Green India'
            WHEN 'GGE' THEN 'Global Green Europe'
        END
        AND metric = 'EBITDA'
        AND metric_type = 'Actual'
        AND date_my IS NOT NULL
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
        date_my AS month,
        STRFTIME(date_my, '%b-%y') AS month_label,
        period_value AS value
    FROM income_statement
    WHERE 
        entity = CASE '${inputs.matric}'
            WHEN 'GGCL' THEN 'Global Green India'
            WHEN 'GGE' THEN 'Global Green Europe'
        END
        AND metric = 'PBT Before Exceptional'
        AND metric_type = 'Actual'
        AND date_my IS NOT NULL
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
        date_my AS month,
        STRFTIME(date_my, '%b-%y') AS month_label,
        period_value AS value
    FROM income_statement
    WHERE 
        entity = CASE '${inputs.matric}'
            WHEN 'GGCL' THEN 'Global Green India'
            WHEN 'GGE' THEN 'Global Green Europe'
        END
        AND metric = 'PBT - (from operations)'  -- PAT proxy
        AND metric_type = 'Actual'
        AND date_my IS NOT NULL
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
        EXTRACT(YEAR FROM date_my) AS year,
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
        AND date_my IS NOT NULL
),

yearly_agg AS (
    SELECT 
        entity,
        metric,
        year,
        SUM(value) AS "EBITDA"
    FROM base
    GROUP BY entity, metric, year
),

with_yoy AS (
    SELECT 
        entity,
        metric,
        year,
        EBITDA,
        LAG(EBITDA) OVER (PARTITION BY entity, metric ORDER BY year) AS prev_year_value
    FROM yearly_agg
),

final AS (
    SELECT 
        entity,
        metric,
        year,
        EBITDA,
        prev_year_value,
        CASE 
            WHEN prev_year_value IS NULL THEN 'Base Year'
            WHEN prev_year_value = 0 THEN 'N/A'
            ELSE CAST(ROUND((EBITDA - prev_year_value) / prev_year_value, 2) AS TEXT)
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
        EXTRACT(YEAR FROM date_my) AS year,  
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
        AND date_my IS NOT NULL
),

yearly_agg AS (
    SELECT 
        entity,
        metric,
        year,
        SUM(value) AS "PBT"
    FROM base
    GROUP BY entity, metric, year
),

with_yoy AS (
    SELECT 
        entity,
        metric,
        year,
        PBT,
        LAG(PBT) OVER (PARTITION BY entity, metric ORDER BY year) AS prev_year_value
    FROM yearly_agg
),

final AS (
    SELECT 
        entity,
        metric,
        year,
        PBT,
        prev_year_value,
        CASE 
            WHEN prev_year_value IS NULL THEN 'Base Year'
            WHEN prev_year_value = 0 THEN 'N/A'
            ELSE CAST(ROUND((PBT - prev_year_value) / prev_year_value, 2) AS TEXT)
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
        EXTRACT(YEAR FROM date_my) AS year,  
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
        AND date_my IS NOT NULL
),

yearly_agg AS (
    SELECT 
        entity,
        metric,
        year,
        SUM(value) AS "PAT"
    FROM base
    GROUP BY entity, metric, year
),

with_yoy AS (
    SELECT 
        entity,
        metric,
        year,
        PAT,
        LAG(PAT) OVER (PARTITION BY entity, metric ORDER BY year) AS prev_year_value
    FROM yearly_agg
),

final AS (
    SELECT 
        entity,
        metric,
        year,
        PAT,
        prev_year_value,
        CASE 
            WHEN prev_year_value IS NULL THEN 'Base Year'
            WHEN prev_year_value = 0 THEN 'N/A'
            ELSE CAST(ROUND((PAT - prev_year_value) / prev_year_value, 2) AS TEXT)
        END AS yoy_change
    FROM with_yoy
)

SELECT *
FROM final
ORDER BY entity, metric, year;


```

```sql date_filter
WITH month_lookup AS (
    SELECT * FROM (VALUES
        (1,  'January'),
        (2,  'February'),
        (3,  'March'),
        (4,  'April'),
        (5,  'May'),
        (6,  'June'),
        (7,  'July'),
        (8,  'August'),
        (9,  'September'),
        (10, 'October'),
        (11, 'November'),
        (12, 'December')
    ) AS m(month_num, month_name)
),

calendar_years AS (
    SELECT 
        CASE 
            WHEN EXTRACT(YEAR FROM date_my) = 2019 AND EXTRACT(MONTH FROM date_my) BETWEEN 4 AND 12 THEN '2019'
            WHEN EXTRACT(YEAR FROM date_my) = 2020 THEN '2020'
            WHEN EXTRACT(YEAR FROM date_my) = 2021 THEN '2021'
            WHEN EXTRACT(YEAR FROM date_my) = 2022 THEN '2022'
            WHEN EXTRACT(YEAR FROM date_my) = 2023 THEN '2023'
            WHEN EXTRACT(YEAR FROM date_my) = 2024 THEN '2024'
            WHEN EXTRACT(YEAR FROM date_my) = 2025 THEN '2025'
        END AS date_filter,

        CASE 
            WHEN EXTRACT(YEAR FROM date_my) = 2019 AND EXTRACT(MONTH FROM date_my) BETWEEN 4 AND 12 THEN DATE '2019-01-01'
            ELSE DATE_TRUNC('year', date_my)
        END AS date_sort,

        EXTRACT(MONTH FROM date_my) AS month_num,
        STRFTIME(date_my, '%b-%y') AS month_label
    FROM income_statement
    WHERE date_my IS NOT NULL
),

calendar_labels AS (
    SELECT DISTINCT
        date_filter,
        date_sort,
        month_num,
        month_label
    FROM calendar_years
    WHERE date_filter IS NOT NULL
),

aggregated_calendar AS (
    SELECT 
        date_filter,
        date_sort,
        STRING_AGG(month_label ORDER BY month_num) AS months_included
    FROM calendar_labels
    GROUP BY date_filter, date_sort
)

SELECT 
    date_filter,
    date_sort,
    months_included
FROM 
    aggregated_calendar
ORDER BY 
    date_sort DESC;

```

```sql sel_year_ebitda
WITH base AS (
    SELECT 
        entity,
        metric,
        metric_type,
        date_my AS month,
        EXTRACT(YEAR FROM date_my) AS year,
        EXTRACT(MONTH FROM date_my) AS month_num,
        -- STRFTIME(date_my, '%b-%y') AS month_label,
        period_value AS value
    FROM income_statement
    WHERE 
        entity = CASE '${inputs.matric}'
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
        -- month_label,
        value
    FROM base
    WHERE year = CAST('${inputs.date_filter.value}' AS INTEGER)
),

with_lag AS (
    SELECT 
        metric,
        month,
        -- month_label,
        month_sort,
        value AS Monthly,
        LAG(value) OVER (PARTITION BY metric ORDER BY month) AS prev_month_value
    FROM filtered
),

with_mom AS (
    SELECT 
        metric,
        -- month_label,
        month,
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
    -- month_label,
    month,
    month_sort,
    Monthly,
    prev_month_value,
    mom_change
FROM with_mom
ORDER BY month_sort;

```

```sel_year_pbt
WITH base AS (
    SELECT 
        entity,
        TRIM(metric) AS metric,
        metric_type,
        date_my AS month,
        EXTRACT(YEAR FROM date_my) AS year,
        EXTRACT(MONTH FROM date_my) AS month_num,
        -- STRFTIME(date_my, '%b-%y') AS month_label,
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
        AND date_my IS NOT NULL
),

filtered AS (
    SELECT 
        metric,
        month,
        CAST(month_num AS INTEGER) AS month_sort,
        -- month_label,
        value
    FROM base
    WHERE year = CAST('${inputs.date_filter_pbt.value}' AS INTEGER)
),

with_lag AS (
    SELECT 
        metric,
        month,
        -- month_label,
        month_sort,
        value AS Monthly,
        LAG(value) OVER (PARTITION BY metric ORDER BY month) AS prev_month_value
    FROM filtered
),

with_mom AS (
    SELECT 
        metric,
        -- month_label,
        month,
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
    -- month_label,
    month,
    month_sort,
    Monthly,
    prev_month_value,
    mom_change
FROM with_mom
ORDER BY month_sort;

```

```sql sel_year_pat
WITH base AS (
    SELECT 
        entity,
        TRIM(metric) AS metric,
        metric_type,
        date_my AS month,
        EXTRACT(YEAR FROM date_my) AS year,
        EXTRACT(MONTH FROM date_my) AS month_num,
        -- STRFTIME(date_my, '%b-%y') AS month_label,
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
        AND date_my IS NOT NULL
),

filtered AS (
    SELECT 
        metric,
        month,
        CAST(month_num AS INTEGER) AS month_sort,
        -- month_label,
        value
    FROM base
    WHERE year = CAST('${inputs.date_filter_pat.value}' AS INTEGER)
),

with_lag AS (
    SELECT 
        metric,
        month,
        -- month_label,
        month_sort,
        value AS Monthly,
        LAG(value) OVER (PARTITION BY metric ORDER BY month) AS prev_month_value
    FROM filtered
),

with_mom AS (
    SELECT 
        metric,
        -- month_label,
        month,
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
    -- month_label,
    month,
    month_sort,
    Monthly,
    prev_month_value,
    mom_change
FROM with_mom
ORDER BY month_sort;

```