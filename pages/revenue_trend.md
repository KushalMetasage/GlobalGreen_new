<Grid cols =2>

## 📈 Revenue Trend

<Dropdown data={date_filter} name=date_filter value=date_filter title="Year" defaultValue="2025" order = 'date_sort desc'>
</Dropdown>

</Grid>

<div class="text-align: center; ml-32">
  <p class="text-xs text-gray-500 text-center mt-2 italic">
  * Select the year to get the insights for each month.
</p>
</div>

<div class="flex items-center justify-between w-full">
<ButtonGroup name="matric" display="tabs">
        <ButtonGroupItem valueLabel="Global Green India" value="GGCL" default />
        <ButtonGroupItem valueLabel="Global Green Europe" value="GGE" />
</ButtonGroup>
</div>


## 📈 YoY Revenue Trend
<div class = 'mb-5'></div>


<LineChart 
  data={revenue_trend_yoy}
  x=year
  y2=yoy_change_pct
  y=yearly_revenue
  yAxisTitle = "Values are in Million"
  markers=true
/>

<LineChart 
data={sel_year}
x=month_label
y=monthly_revenue
y2=MoM_change_pct
yAxisTitle="Values are in Million"
markers=true
/>




## 📈 Revenue & EBITDA %
<div class = 'mb-5'></div>

<BarChart 
  data={revenue_ebitda_perc} 
  x="month"
  y="Revenue"                    
  yFmt="number"                
  y2="EBITDA_percent"             
  y2SeriesType="line"
  yAxisTitle = "Values are in Million"
  sort={true}
  xFmt="mmm-yy"
  tooltipTitle="month_label"
  y2AxisLabels={false}
  y2AxisTitle={false}
/>

<BarChart 
  data={sel_year_ebitda_perc} 
  x="month_label"
  y="monthly_revenue"                    
  yFmt="number"                
  y2="ebitda_percent"            
  y2SeriesType="line"
  yAxisTitle="Values are in Million"
  sort={true}
  xFmt="mmm-yy"
  tooltipTitle="month_label"
  y2AxisLabels={false}
  y2AxisTitle={false}
/>


## 📈 Revenue & EBITDA
<div class = 'mb-5'></div>

<BarChart 
  data={revenue_ebitda} 
  x="month"
  y="Revenue"                    
  yFmt="number"                
  y2="ebitda"              
  y2SeriesType="line"
  yAxisTitle = "Values are in Million"
  sort={true}
  xFmt="mmm-yy"
  tooltipTitle="month_label"
  y2AxisLabels={false}
  y2AxisTitle={false}
/>

<BarChart 
  data={sel_year_ebitda} 
  x="month_label"
  y="monthly_revenue"                    
  yFmt="number"                
  y2="ebitda"              
  y2SeriesType="line"
  yAxisTitle="Values are in Million"
  sort={true}
  xFmt="mmm-yy"
  tooltipTitle="month_label"
  y2AxisLabels={false}
  y2AxisTitle={false}
/>


## 📈 Revenue & PBT
<div class = 'mb-5'></div>

<BarChart 
  data={revenue_pbt} 
  x="month"
  y="Revenue"                    
  yFmt="number"                
  y2="PBT"              
  y2SeriesType="line"
  yAxisTitle = "Values are in Million"
  sort={true}
  xFmt="mmm-yy"
  tooltipTitle="month_label"
  y2AxisLabels={false}
  y2AxisTitle={false}
/>

<BarChart 
  data={sel_year_pbt} 
  x="month_label"
  y="monthly_revenue"                    
  yFmt="number"                
  y2="pbt"              
  y2SeriesType="line"
  yAxisTitle="Values are in Million"
  sort={true}
  xFmt="mmm-yy"
  tooltipTitle="month_label"
  y2AxisLabels={false}
  y2AxisTitle={false}
/>


<div class = 'mb-15'> </div>


```sql revenue_trend_yoy
WITH base AS (
    SELECT 
        entity,
        metric,
        metric_type,
        CAST(STRFTIME(STRPTIME(period_date, '%b-%y'), '%Y') AS INTEGER) AS year,  
        period_value AS revenue
    FROM income_statement
    WHERE 
        entity = CASE '${inputs.matric}'
            WHEN 'GGCL' THEN 'Global Green India'
            WHEN 'GGE' THEN 'Global Green Europe'
        END
        AND metric = 'Sales Revenue (Incl OI)'
        AND metric_type = 'Actual'
),
yearly_agg AS (
    SELECT 
        year,
        SUM(revenue) yearly_revenue
    FROM base
    GROUP BY year
),
with_yoy AS (
    SELECT 
        year,
        yearly_revenue,
        LAG(yearly_revenue) OVER (ORDER BY year) AS prev_year_revenue  
    FROM yearly_agg
),
final AS (
    SELECT 
        year,
        yearly_revenue,
        prev_year_revenue,
        ROUND(
            CASE 
                WHEN prev_year_revenue IS NOT NULL AND prev_year_revenue != 0
                THEN (yearly_revenue - prev_year_revenue) / prev_year_revenue
                ELSE NULL
            END, 
        4) AS yoy_change_pct
    FROM with_yoy
)

SELECT *
FROM final
ORDER BY year;

```

```sql revenue_ebitda_perc
SELECT
  entity,
  STRPTIME(period_date, '%b-%y') AS month,
  STRFTIME(STRPTIME(period_date, '%b-%y'), '%b-%y') AS month_label,
  MAX(CASE WHEN metric = 'Sales Revenue (Incl OI)' THEN period_value END) AS Revenue,
  MAX(CASE WHEN metric = 'EBITDA %' THEN period_value END) AS EBITDA_percent
FROM income_statement
WHERE 
  entity = CASE '${inputs.matric}'
    WHEN 'GGCL' THEN 'Global Green India'
    WHEN 'GGE' THEN 'Global Green Europe'
  END
  AND metric IN ('Sales Revenue (Incl OI)', 'EBITDA %')
  AND metric_type = 'Actual'
GROUP BY entity, month, month_label
ORDER BY entity, month;
```

```sql revenue_ebitda
SELECT
  entity,
  STRPTIME(period_date, '%b-%y') AS month,
  STRFTIME(STRPTIME(period_date, '%b-%y'), '%b-%y') AS month_label,
  MAX(CASE WHEN metric = 'Sales Revenue (Incl OI)' THEN period_value END) AS Revenue,
  MAX(CASE WHEN metric = 'EBITDA' THEN period_value END) AS ebitda
FROM income_statement
WHERE 
  entity = CASE '${inputs.matric}'
    WHEN 'GGCL' THEN 'Global Green India'
    WHEN 'GGE' THEN 'Global Green Europe'
  END
  AND metric IN ('Sales Revenue (Incl OI)', 'EBITDA')
  AND metric_type = 'Actual'
GROUP BY entity, month, month_label
ORDER BY entity, month;
```

```sql revenue_pbt
SELECT
  entity,
  STRPTIME(period_date, '%b-%y') AS month,
  STRFTIME(STRPTIME(period_date, '%b-%y'), '%b-%y') AS month_label,
  
  MAX(CASE WHEN metric = 'Sales Revenue (Incl OI)' THEN period_value END) AS Revenue,
  MAX(CASE WHEN metric = 'PBT Before Exceptional' THEN period_value END) AS PBT

FROM income_statement
WHERE 
  entity = CASE '${inputs.matric}'
    WHEN 'GGCL' THEN 'Global Green India'
    WHEN 'GGE' THEN 'Global Green Europe'
  END
  AND metric IN ('Sales Revenue (Incl OI)', 'PBT Before Exceptional')
  AND metric_type = 'Actual'

GROUP BY entity, month, month_label
ORDER BY entity, month;

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

parsed_dates AS (
    SELECT 
        STRPTIME(period_date, '%b-%y') AS parsed_date
    FROM income_statement
    WHERE TRIM(period_date) IS NOT NULL
),

calendar_years AS (
    SELECT 
        CASE 
            WHEN EXTRACT(YEAR FROM parsed_date) = 2019 AND EXTRACT(MONTH FROM parsed_date) BETWEEN 4 AND 12 THEN '2019'
            WHEN EXTRACT(YEAR FROM parsed_date) = 2020 THEN '2020'
            WHEN EXTRACT(YEAR FROM parsed_date) = 2021 THEN '2021'
            WHEN EXTRACT(YEAR FROM parsed_date) = 2022 THEN '2022'
            WHEN EXTRACT(YEAR FROM parsed_date) = 2023 THEN '2023'
            WHEN EXTRACT(YEAR FROM parsed_date) = 2024 THEN '2024'
            WHEN EXTRACT(YEAR FROM parsed_date) = 2025 THEN '2025'
        END AS date_filter,

        CASE 
            WHEN EXTRACT(YEAR FROM parsed_date) = 2019 AND EXTRACT(MONTH FROM parsed_date) BETWEEN 4 AND 12 THEN DATE '2019-01-01'
            ELSE DATE_TRUNC('year', parsed_date)
        END AS date_sort,

        EXTRACT(MONTH FROM parsed_date) AS month_num,
        STRFTIME(parsed_date, '%b-%y') AS month_label
    FROM parsed_dates
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

```sql sel_year
WITH base AS (
    SELECT 
        entity,
        metric,
        metric_type,
        STRPTIME(period_date, '%b-%y') AS parsed_date,
        STRFTIME(STRPTIME(period_date, '%b-%y'), '%Y') AS year,
        STRFTIME(STRPTIME(period_date, '%b-%y'), '%m') AS month_num,
        STRFTIME(STRPTIME(period_date, '%b-%y'), '%b-%y') AS month_label,
        period_value AS revenue
    FROM income_statement
    WHERE 
        entity = CASE '${inputs.matric}'
            WHEN 'GGCL' THEN 'Global Green India'
            WHEN 'GGE' THEN 'Global Green Europe'
        END
        AND metric = 'Sales Revenue (Incl OI)'
        AND metric_type = 'Actual'
),

-- Current year revenue per month
current_year AS (
    SELECT 
        month_label,
        CAST(month_num AS INTEGER) AS month_sort,
        SUM(revenue) AS monthly_revenue,
        month_num
    FROM base
    WHERE year = '${inputs.date_filter.value}'
    GROUP BY month_label, month_sort, month_num
),

-- Previous year revenue per month
previous_year AS (
    SELECT 
        CAST(month_num AS INTEGER) AS month_sort,
        SUM(revenue) AS prev_monthly_revenue
    FROM base
    WHERE year = CAST('${inputs.date_filter.value}' AS INTEGER) - 1
    GROUP BY month_num
),

-- Join current with previous and compute YoY change
joined AS (
    SELECT 
        c.month_label,
        c.month_sort,
        c.monthly_revenue,
        p.prev_monthly_revenue,
        ROUND(
            CASE 
                WHEN p.prev_monthly_revenue IS NOT NULL AND p.prev_monthly_revenue != 0 THEN 
                    (c.monthly_revenue - p.prev_monthly_revenue) / p.prev_monthly_revenue
                ELSE NULL
            END,
        4) AS MoM_change_pct
    FROM current_year c
    LEFT JOIN previous_year p ON c.month_sort = p.month_sort
)

SELECT *
FROM joined
ORDER BY month_sort;

```

```sql sel_year_ebitda_perc
WITH base AS (
    SELECT 
        entity,
        metric,
        metric_type,
        STRPTIME(period_date, '%b-%y') AS parsed_date,
        STRFTIME(STRPTIME(period_date, '%b-%y'), '%Y') AS year,
        STRFTIME(STRPTIME(period_date, '%b-%y'), '%m') AS month_num,
        STRFTIME(STRPTIME(period_date, '%b-%y'), '%b-%y') AS month_label,
        period_value
    FROM income_statement
    WHERE 
        entity = CASE '${inputs.matric}'
            WHEN 'GGCL' THEN 'Global Green India'
            WHEN 'GGE' THEN 'Global Green Europe'
        END
        AND metric IN ('Sales Revenue (Incl OI)', 'EBITDA %')
        AND metric_type = 'Actual'
),

filtered AS (
    SELECT 
        entity,
        month_label,
        CAST(month_num AS INTEGER) AS month_sort,
        MAX(CASE WHEN metric = 'Sales Revenue (Incl OI)' THEN period_value END) AS revenue,
        MAX(CASE WHEN metric = 'EBITDA %' THEN period_value END) AS ebitda_percent
    FROM base
    WHERE year = '${inputs.date_filter.value}'
    GROUP BY entity, month_label, month_sort
)

SELECT 
    entity,
    month_label,
    month_sort,
    revenue AS monthly_revenue,
    ebitda_percent
FROM filtered
ORDER BY entity, month_sort;
```

```sql sel_year_ebitda
WITH base AS (
    SELECT 
        entity,
        metric,
        metric_type,
        STRPTIME(period_date, '%b-%y') AS parsed_date,
        STRFTIME(STRPTIME(period_date, '%b-%y'), '%Y') AS year,
        STRFTIME(STRPTIME(period_date, '%b-%y'), '%m') AS month_num,
        STRFTIME(STRPTIME(period_date, '%b-%y'), '%b-%y') AS month_label,
        period_value
    FROM income_statement
    WHERE 
        entity = CASE '${inputs.matric}'
            WHEN 'GGCL' THEN 'Global Green India'
            WHEN 'GGE' THEN 'Global Green Europe'
        END
        AND metric IN ('Sales Revenue (Incl OI)', 'EBITDA')
        AND metric_type = 'Actual'
),

filtered AS (
    SELECT 
        entity,
        month_label,
        CAST(month_num AS INTEGER) AS month_sort,
        MAX(CASE WHEN metric = 'Sales Revenue (Incl OI)' THEN period_value END) AS revenue,
        MAX(CASE WHEN metric = 'EBITDA' THEN period_value END) AS ebitda
    FROM base
    WHERE year = '${inputs.date_filter.value}'
    GROUP BY entity, month_label, month_sort
)

SELECT 
    entity,
    month_label,
    month_sort,
    revenue AS monthly_revenue,
    ebitda
FROM filtered
ORDER BY entity, month_sort;
```

```sql sel_year_pbt
WITH base AS (
    SELECT 
        entity,
        metric,
        metric_type,
        STRPTIME(period_date, '%b-%y') AS parsed_date,
        STRFTIME(STRPTIME(period_date, '%b-%y'), '%Y') AS year,
        STRFTIME(STRPTIME(period_date, '%b-%y'), '%m') AS month_num,
        STRFTIME(STRPTIME(period_date, '%b-%y'), '%b-%y') AS month_label,
        period_value
    FROM income_statement
    WHERE 
        entity = CASE '${inputs.matric}'
            WHEN 'GGCL' THEN 'Global Green India'
            WHEN 'GGE' THEN 'Global Green Europe'
        END
        AND metric IN ('Sales Revenue (Incl OI)', 'PBT Before Exceptional')
        AND metric_type = 'Actual'
),

filtered AS (
    SELECT 
        entity,
        month_label,
        CAST(month_num AS INTEGER) AS month_sort,
        MAX(CASE WHEN metric = 'Sales Revenue (Incl OI)' THEN period_value END) AS revenue,
        MAX(CASE WHEN metric = 'PBT Before Exceptional' THEN period_value END) AS pbt
    FROM base
    WHERE year = '${inputs.date_filter.value}'
    GROUP BY entity, month_label, month_sort
)

SELECT 
    entity,
    month_label,
    month_sort,
    revenue AS monthly_revenue,
    pbt
FROM filtered
ORDER BY entity, month_sort;
```