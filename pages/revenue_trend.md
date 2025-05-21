

## 📈 Revenue Trend


<div class="flex items-center justify-between w-full">
<ButtonGroup name="matric" display="tabs">
        <ButtonGroupItem valueLabel="Global Green India" value="GGCL" default />
        <ButtonGroupItem valueLabel="Global Green Europe" value="GGE" />
</ButtonGroup>
</div>



## 📈 MoM Revenue Trend
<div class = 'mb-5'></div>

<LineChart 
  data={revenue_trend_mom}
  x=month
  y=mom_change_pct
  yAxisTitle= "Values are in Million"
  markers=true
/>

## 📈 YoY Revenue Trend
<div class = 'mb-5'></div>

<LineChart 
  data={revenue_trend_yoy}
  x=year
  y=yoy_change_pct
  yAxisTitle = "Values are in Million"
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

<div class = 'mb-15'> </div>

```sql date_filter
SELECT DISTINCT 
  STRFTIME(STRPTIME(period_date, '%b-%y'), '%Y') AS date_filter,
  MIN(STRPTIME(period_date, '%b-%y')) AS date_sort  
FROM income_statement
WHERE TRIM(period_date) IS NOT NULL
  AND TRIM(period_date) <> ''
GROUP BY date_filter
ORDER BY date_sort DESC;

```

```sql revenue_trend_mom
WITH base AS (
    SELECT 
        entity,
        metric,
        metric_type,
        STRPTIME(period_date, '%b-%y') AS month,
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
with_lag AS (
    SELECT 
        month,
        revenue,
        LAG(revenue) OVER (ORDER BY month) AS prev_month_revenue
    FROM base
),
with_mom AS (
    SELECT 
        month,
        revenue AS current_month_revenue,
        prev_month_revenue,
        ROUND(
            CASE 
                WHEN prev_month_revenue IS NOT NULL AND prev_month_revenue != 0 
                THEN (revenue - prev_month_revenue) / prev_month_revenue
                ELSE NULL 
            END, 
        4) AS mom_change_pct
    FROM with_lag
)

SELECT 
    month,
    current_month_revenue,
    prev_month_revenue,
    mom_change_pct
FROM with_mom
ORDER BY month;

```

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
        SUM(revenue) AS current_year_revenue
    FROM base
    GROUP BY year
),
with_yoy AS (
    SELECT 
        year,
        current_year_revenue,
        LAG(current_year_revenue) OVER (ORDER BY year) AS prev_year_revenue  
    FROM yearly_agg
),
final AS (
    SELECT 
        year,
        current_year_revenue,
        prev_year_revenue,
        ROUND(
            CASE 
                WHEN prev_year_revenue IS NOT NULL AND prev_year_revenue != 0
                THEN (current_year_revenue - prev_year_revenue) / prev_year_revenue
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