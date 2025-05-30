<Grid cols = 3>

## 💵 Consolidated Income

<div class="relative ml-25 mb-5 mt-1">
<Dropdown data={date_cons} name=date_cons value=date_cons title="Date" defaultValue="Jan-25" order = 'date_sort desc'>
</Dropdown>
</div>


<div class = "relative mt-5 ml-30">
 <p class="text-sm text-grey ml-auto">
        📅 Last Updated: <Value data={max_date_cons} />
    </p>
</div>

</Grid>

<DataTable data = {consolidated} rows= 20 title = "Values are in Million" rowshadowing={true} headerFontColor=Bold headerColor=#FFD700>
<Column id = 'metric' title = "Particulars"/>
<Column id= "CY Actual" fmt='$0.00' align="center" title = 'CY Actual'/>
 <Column id= "CY AOP" fmt='$0.00' align="center" title = 'CY AOP'/>
 <Column id= "LY Actual" fmt='$0.00' align="center" title = 'LY Actual'/>
 <Column id= "Variance vs AOP" fmt='$0.00' align="center" contentType="delta" title = 'Variance vs AOP'/>
 <Column id= "Variance vs LY" fmt='$0.00' align="center" contentType="delta" title = 'Variance vs LY'/>
</DataTable>

<DataTable data = {consolidated_perc} rows= 20 rowshadowing={true} headerFontColor=Bold headerColor=#FFD700>
<Column id = 'metric' title = "Particulars"/>
<Column id= "CY Actual" fmt='0.00"%"' align="center" title = 'CY Actual'/>
 <Column id= "CY AOP" fmt='0.00"%"' align="center" title = 'CY AOP'/>
 <Column id= "LY Actual" fmt='0.00"%"' align="center" title = 'LY Actual'/>
 <Column id= "Variance vs AOP" fmt='0.00"%"' align="center" contentType="delta" title = 'Variance vs AOP'/>
 <Column id= "Variance vs LY" fmt='0.00"%"' align="center" contentType="delta" title = 'Variance vs LY'/>
</DataTable>


<Grid cols = 3>

## 💵 Income Statement

<div class = "relative mt-1 ml-25">
<Dropdown data={date_filter} name=date_filter value=date_filter title="Date" defaultValue="Jan-25" order = 'date_sort desc'>
</Dropdown>
</div>

<div class = "relative mt-4 ml-30">
<p class="text-sm text-grey ml-auto">
        📅 Last Updated: <Value data={max_date_inc} />
    </p>
</div>
</Grid>

<div class="flex items-center justify-between w-full">
<ButtonGroup name="matric" display="tabs">
        <ButtonGroupItem valueLabel="Global Green India" value="GGCL" default />
        <ButtonGroupItem valueLabel="Global Green Europe" value="GGE" />
</ButtonGroup>
</div>

<DataTable data = {income} rows= 20 title = "Values are in Million" rowshadowing={true} headerFontColor=Bold headerColor=#FFD700>
<Column id = 'metric' title = "Particulars"/>
<Column id= "CY Actual" fmt='$0.00' align="center" title = 'CY Actual'/>
 <Column id= "CY AOP" fmt='$0.00' align="center" title = 'CY AOP'/>
 <Column id= "LY Actual" fmt='$0.00' align="center" title = 'LY Actual'/>
 <Column id= "Variance vs AOP" fmt='$0.00' align="center" contentType="delta" title = 'Variance vs AOP'/>
 <Column id= "Variance vs LY" fmt='$0.00' align="center" contentType="delta" title = 'Variance vs LY'/>
</DataTable>

<DataTable data = {income_perc} rows= 20 rowshadowing={true} headerFontColor=Bold headerColor=#FFD700>
<Column id = 'metric' title = "Particulars"/>
<Column id= "CY Actual" fmt='0.00"%"' align="center" title = 'CY Actual'/>
 <Column id= "CY AOP" fmt='0.00"%"' align="center" title = 'CY AOP'/>
 <Column id= "LY Actual" fmt='0.00"%"' align="center" title = 'LY Actual'/>
 <Column id= "Variance vs AOP" fmt='0.00"%"' align="center" contentType="delta" title = 'Variance vs AOP'/>
 <Column id= "Variance vs LY" fmt='0.00"%"' align="center" contentType="delta" title = 'Variance vs LY'/>
</DataTable>

<div class = "mt-10"> </div>

<Grid cols = 2>

## 🧮 Consolidated Income Chart

<div class = "relative mt-4 ml-70">
 <p class="text-sm text-grey ml-auto">
        📅 Selected Date: <Value data={selected_date_income} />
</p>
</div>
</Grid>

<div class = "mb-15"></div>
<BarChart 
    data={cons_inc_chart}
    yAxisTitle = "Values are in Million"
    type = grouped
/>

<Grid cols = 4 gapSize = none>

## 💵 YTD Income

<div class="relative mt-1 ml-15">
<Dropdown data={date_filter_ytd} name=date_filter_ytd value=date_filter_ytd title="Year" defaultValue="2025" order = 'date_sort desc'>
</Dropdown>


<Info description="For the year 2019 data is from Apr-19 to Dec-19" color="red" />
</div>

<div class="relative mt-1">
<Dropdown data={month_filter_ytd} name=month_filter_ytd value=month_filter_ytd title="Month" 
defaultValue="January" order="month_num">
</Dropdown>

</div>

<div class = "relative ml-1 mt-4">
 <p class="text-sm text-grey ml-auto">
        📅 Last Updated: <Value data={max_date_ytd_income} />
</p>
</div>

</Grid>



<div class="flex items-center justify-between w-full">
  <!-- Button Group on the Left -->
    <ButtonGroup name="matric_ytd" display="tabs">
        <ButtonGroupItem valueLabel="Global Green India" value="GGCL" default />
        <ButtonGroupItem valueLabel="Global Green Europe" value="GGE" />
    </ButtonGroup>
</div>




<DataTable data = {ytd_income} rows= 20 title = "Values are in Million" rowshadowing={true} headerFontColor=Bold headerColor=#FFD700>
<Column id = 'metric' title = "Particulars"/>
<Column id = 'YTD Actual' fmt = '$0.00' align="center" title = 'YTD Actual'/>
<Column id = 'YTD AOP' fmt = '$0.00' align="center" title = 'YTD AOP'/>
<Column id = 'LY Actual YTD' fmt = '$0.00' align="center" title = 'LY Actual YTD'/>
<Column id = 'Variance vs AOP YTD' fmt = '$0.00' align="center" contentType="delta" title = 'Variance vs AOP YTD'/>
<Column id = 'Variance vs LY YTD' fmt = '$0.00' align="center" contentType="delta" title = 'Variance vs LY YTD'/>
</DataTable>

<DataTable data = {ytd_perc} rows= 20 rowshadowing={true} headerFontColor=Bold headerColor=#FFD700>

<Column id = 'metric' title = "Particulars"/>
<Column id = 'YTD Actual' fmt = '$0.00"%"' align="center" title = 'YTD Actual'/>
<Column id = 'YTD AOP' fmt = '$0.00"%"' align="center" title = 'YTD AOP'/>
<Column id = 'LY Actual YTD' fmt = '$0.00"%"' align="center" title = 'LY Actual YTD'/>
<Column id = 'Variance vs AOP YTD' fmt = '$0.00"%"' align="center" contentType="delta" title = 'Variance vs AOP YTD'/>
<Column id = 'Variance vs LY YTD' fmt = '$0.00"%"' align="center" contentType="delta" title = 'Variance vs LY YTD'/>
</DataTable>

<div class = "mt-10"> </div>

<Grid cols = 2>

## 🧮 Consolidated YTD Income Chart

<div class = "relative mt-4 ml-70">
 <p class="text-sm text-grey ml-auto">
        📅 Selected Year: <Value data={selected_year_ytd} />
</p>
</div>

</Grid>

<div class = "mb-15"></div>
<BarChart 
    data={cons_ytd_inc}
    yAxisTitle = "Values are in Million"
    type = grouped
/>

<Grid cols = 4 gapSize = none>

## 💵 Consolidated YTD Income

<div class="relative ml-15 mt-1">
<Dropdown data={date_filter_ytd_cons} name=date_filter_ytd_cons value=date_filter_ytd_cons title="Year" defaultValue="2025" order = 'date_sort desc'>
</Dropdown>
<Info description="For the year 2019 data is from Apr-19 to Dec-19" color="red" />
</div>

<div class="relative mt-1">
<Dropdown data={month_filter_ytd_cons} name=month_filter_ytd_cons value=month_filter_ytd_cons title="Month" 
defaultValue="January" order="month_num">
</Dropdown>
</div>


<div class = "relative mt-4 ml-1 mb-8">
<p class="text-sm text-grey ml-auto">
        📅 Last Updated: <Value data={max_date_ytd_cons} />
</p>
</div>

</Grid>
<div class = 'mb-5'> </div>

<DataTable data = {ytd_income_cons} rows= 20 title = "Values are in Million" rowshadowing={true} headerFontColor=Bold headerColor=#FFD700>
<Column id = 'metric'title = "Particulars"/>
<Column id = 'YTD Actual' fmt = '$0.00' align="center" title = 'YTD Actual'/>
<Column id = 'YTD AOP' fmt = '$0.00' align="center" title = 'YTD AOP'/>
<Column id = 'LY Actual YTD' fmt = '$0.00' align="center" title = 'LY Actual YTD'/>
<Column id = 'Variance vs AOP YTD' fmt = '$0.00' align="center" contentType="delta" title = 'Variance vs AOP YTD'/>
<Column id = 'Variance vs LY YTD' fmt = '$0.00' align="center" contentType="delta" title = 'Variance vs LY YTD'/>
</DataTable>

<DataTable data = {ytd_income_cons_perc} rows= 20 rowshadowing={true} headerFontColor=Bold headerColor=#FFD700>

<Column id = 'metric' title = "Particulars"/>
<Column id = 'YTD Actual' fmt = '$0.00"%"' align="center" title = 'YTD Actual'/>
<Column id = 'YTD AOP' fmt = '$0.00"%"' align="center" title = 'YTD AOP'/>
<Column id = 'LY Actual YTD' fmt = '$0.00"%"' align="center" title = 'LY Actual YTD'/>
<Column id = 'Variance vs AOP YTD' fmt = '$0.00"%"' align="center" contentType="delta" title = 'Variance vs AOP YTD'/>
<Column id = 'Variance vs LY YTD' fmt = '$0.00"%"' align="center" contentType="delta" title = 'Variance vs LY YTD'/>
</DataTable>

<div class = 'mb-10'> </div>

```sql date_filter
SELECT DISTINCT 
  STRFTIME(date_my, '%b-%y') AS date_filter,
  STRFTIME(date_my, '%b-%y') AS label,
  date_my AS date_sort  
FROM income_statement
WHERE 
  date_my IS NOT NULL
  AND STRFTIME(date_my, '%b-%y') != 'Feb-25'
ORDER BY date_sort DESC;
```

```sql income
WITH metric_order AS (
    SELECT 
        metric,
        ROW_NUMBER() OVER (ORDER BY MIN(date_my)) AS sort_order
    FROM income_statement
    WHERE 
        entity = 'Global Green India'  
        AND TRIM(metric) IS NOT NULL
        AND TRIM(metric) <> ''
        AND metric NOT IN ('GROSS %', 'EBITDA %', 'EBT %', 'EBIT %', 'DSO', 'DPO', 'Trade Payables')
    GROUP BY metric
),
base AS (
    SELECT 
        entity,
        metric,
        metric_type,
        date_my,
        period_value
    FROM income_statement
    WHERE 
        entity = CASE '${inputs.matric}'
            WHEN 'GGCL' THEN 'Global Green India'
            WHEN 'GGE' THEN 'Global Green Europe'
        END
        AND TRIM(metric) IS NOT NULL
        AND TRIM(metric) <> ''
        AND metric NOT IN ('GROSS %', 'EBITDA %', 'EBT %', 'EBIT %', 'DSO', 'DPO', 'Trade Payables')
),
cy AS (
    SELECT *
    FROM base
    WHERE 
        metric_type IN ('Actual', 'AOP')
        AND STRFTIME(date_my, '%b-%y') = '${inputs.date_filter.value}'
),
ly AS (
    SELECT 
        entity,
        metric,
        date_my AS ly_date,
        period_value AS ly_value
    FROM base
    WHERE metric_type = 'Actual'
),
pivoted AS (
    SELECT 
        cy.entity,
        cy.metric,
        cy.date_my AS period_date,

        MAX(CASE WHEN cy.metric_type = 'AOP' THEN cy.period_value END) AS cy_aop,
        MAX(CASE WHEN cy.metric_type = 'Actual' THEN cy.period_value END) AS cy_actual,
        COALESCE(MAX(ly.ly_value), 0) AS ly_actual

    FROM 
        cy
    LEFT JOIN ly 
        ON cy.entity = ly.entity
        AND cy.metric = ly.metric
        AND STRFTIME(cy.date_my, '%b-%y') = STRFTIME(ly.ly_date + INTERVAL '1 year', '%b-%y')

    GROUP BY 
        cy.entity, cy.metric, cy.date_my
)

SELECT 
    p.entity,
    p.metric,
    p.period_date,
    p.cy_aop AS "CY AOP",
    p.cy_actual AS "CY Actual",
    p.ly_actual AS "LY Actual",
    p.cy_actual - p.cy_aop AS "Variance vs AOP",
    p.cy_actual - p.ly_actual AS "Variance vs LY"
FROM 
    pivoted p
LEFT JOIN metric_order m ON p.metric = m.metric
ORDER BY 
    m.sort_order;
```

```sql income_perc
WITH metric_order AS (
    SELECT 
        metric,
        ROW_NUMBER() OVER (ORDER BY MIN(date_my)) AS sort_order
    FROM income_statement
    WHERE 
        entity = 'Global Green India'  
        AND TRIM(metric) IS NOT NULL
        AND TRIM(metric) <> ''
        AND metric IN ('GROSS %', 'EBITDA %', 'EBT %', 'EBIT %')
    GROUP BY metric
),
base AS (
    SELECT 
        entity,
        metric,
        metric_type,
        date_my,
        period_value
    FROM income_statement
    WHERE 
        entity = CASE '${inputs.matric}'
            WHEN 'GGCL' THEN 'Global Green India'
            WHEN 'GGE' THEN 'Global Green Europe'
        END
        AND TRIM(metric) IS NOT NULL
        AND TRIM(metric) <> ''
        AND metric IN ('GROSS %', 'EBITDA %', 'EBT %', 'EBIT %')
),
cy AS (
    SELECT *
    FROM base
    WHERE 
        metric_type IN ('Actual', 'AOP')
        AND STRFTIME(date_my, '%b-%y') = '${inputs.date_filter.value}'
),
ly AS (
    SELECT 
        entity,
        metric,
        date_my AS ly_date,
        period_value AS ly_value
    FROM base
    WHERE metric_type = 'Actual'
),
pivoted AS (
    SELECT 
        cy.entity,
        cy.metric,
        cy.date_my AS period_date,

        MAX(CASE WHEN cy.metric_type = 'AOP' THEN cy.period_value END) * 100 AS cy_aop,
        MAX(CASE WHEN cy.metric_type = 'Actual' THEN cy.period_value END) * 100 AS cy_actual,
        COALESCE(MAX(ly.ly_value), 0) * 100 AS ly_actual

    FROM 
        cy
    LEFT JOIN ly 
        ON cy.entity = ly.entity
        AND cy.metric = ly.metric
        AND STRFTIME(cy.date_my, '%b-%y') = STRFTIME(ly.ly_date + INTERVAL '1 year', '%b-%y')

    GROUP BY 
        cy.entity, cy.metric, cy.date_my
)

SELECT 
    p.entity,
    p.metric,
    p.period_date,
    p.cy_aop AS "CY AOP",
    p.cy_actual AS "CY Actual",
    p.ly_actual AS "LY Actual",
    p.cy_actual - p.cy_aop AS "Variance vs AOP",
    p.cy_actual - p.ly_actual AS "Variance vs LY"
FROM 
    pivoted p
LEFT JOIN metric_order m ON p.metric = m.metric
ORDER BY 
    m.sort_order;

```

```sql max_date_inc
SELECT 
    STRFTIME(MAX(date_my), '%b-%y') AS max_date_inc
FROM 
    income_statement
WHERE 
    STRFTIME(date_my, '%b-%y') != 'Feb-25';

```

```sql date_cons
SELECT DISTINCT 
    STRFTIME(date_my, '%b-%y') AS date_cons,
    date_my AS date_sort
FROM income_statement
WHERE 
    date_my IS NOT NULL
    AND STRFTIME(date_my, '%b-%y') != 'Feb-25'
ORDER BY date_sort DESC;

```

```sql consolidated
WITH metric_order AS (
    SELECT 
        metric,
        ROW_NUMBER() OVER (ORDER BY MIN(date_my)) AS sort_order
    FROM income_statement
    WHERE 
        entity = 'Global Green India'  
        AND TRIM(metric) IS NOT NULL
        AND TRIM(metric) <> ''
        AND metric NOT IN ('GROSS %', 'EBITDA %', 'EBT %', 'EBIT %', 'DSO', 'DPO', 'Trade Payables')
    GROUP BY metric
),

base AS (
    SELECT 
        metric,
        metric_type,
        date_my,
        period_value
    FROM income_statement
    WHERE 
        entity IN ('Global Green India', 'Global Green Europe')
        AND TRIM(metric) IS NOT NULL
        AND TRIM(metric) <> ''
        AND metric NOT IN ('GROSS %', 'EBITDA %', 'EBT %', 'EBIT %', 'DSO', 'DPO', 'Trade Payables')
),

cy AS (
    SELECT *
    FROM base
    WHERE 
        metric_type IN ('Actual', 'AOP')
        AND STRFTIME(date_my, '%b-%y') = '${inputs.date_cons.value}'
),

ly AS (
    SELECT 
        metric,
        date_my AS ly_date,
        SUM(period_value) AS ly_value
    FROM base
    WHERE metric_type = 'Actual'
    GROUP BY metric, date_my
),

pivoted AS (
    SELECT 
        cy.metric,
        cy.date_my AS period_date,
        SUM(CASE WHEN cy.metric_type = 'AOP' THEN cy.period_value END) AS cy_aop,
        SUM(CASE WHEN cy.metric_type = 'Actual' THEN cy.period_value END) AS cy_actual,
        COALESCE(ly.ly_value, 0) AS ly_actual
    FROM cy
    LEFT JOIN ly 
        ON cy.metric = ly.metric
        AND cy.date_my = ly.ly_date + INTERVAL '1 year'
    GROUP BY 
        cy.metric, cy.date_my, ly.ly_value
)

SELECT 
    p.metric,
    p.period_date,
    p.cy_aop AS "CY AOP",
    p.cy_actual AS "CY Actual",
    p.ly_actual AS "LY Actual",
    p.cy_actual - p.cy_aop AS "Variance vs AOP",
    p.cy_actual - p.ly_actual AS "Variance vs LY"
FROM 
    pivoted p
LEFT JOIN metric_order m ON p.metric = m.metric
ORDER BY 
    m.sort_order;
```

```sql consolidated_perc
WITH metric_order AS (
    SELECT 
        metric,
        ROW_NUMBER() OVER (ORDER BY MIN(date_my)) AS sort_order
    FROM income_statement
    WHERE 
        entity = 'Global Green India'
        AND TRIM(metric) IS NOT NULL
        AND TRIM(metric) <> ''
        AND TRIM(metric) IN ('GROSS %', 'EBITDA %', 'EBT %', 'EBIT %')
    GROUP BY metric
),

base AS (
    SELECT 
        TRIM(metric) AS metric,
        metric_type,
        date_my,
        period_value
    FROM income_statement
    WHERE 
        entity IN ('Global Green India', 'Global Green Europe')
        AND TRIM(metric) IN ('Sales Revenue (Incl OI)', 'Gross Margin', 'EBITDA', 'EBIT', 'EBT')
),

cy_base AS (
    SELECT *
    FROM base
    WHERE 
        metric_type IN ('Actual', 'AOP')
        AND STRFTIME(date_my, '%b-%y') = '${inputs.date_cons.value}'
),

ly_base AS (
    SELECT 
        date_my AS ly_date,
        SUM(CASE WHEN metric = 'Sales Revenue (Incl OI)' THEN period_value ELSE 0 END) AS ly_sales,
        SUM(CASE WHEN metric = 'Gross Margin' THEN period_value ELSE 0 END) AS ly_gm,
        SUM(CASE WHEN metric = 'EBITDA' THEN period_value ELSE 0 END) AS ly_ebitda,
        SUM(CASE WHEN metric = 'EBIT' THEN period_value ELSE 0 END) AS ly_ebit,
        SUM(CASE WHEN metric = 'EBT' THEN period_value ELSE 0 END) AS ly_ebt
    FROM base
    WHERE metric_type = 'Actual'
    GROUP BY date_my
),

reshaped_cy AS (
    SELECT 
        date_my AS cy_date,
        STRFTIME(date_my, '%b-%y') AS period_date,

        SUM(CASE WHEN metric = 'Sales Revenue (Incl OI)' AND metric_type = 'AOP' THEN period_value ELSE 0 END) AS aop_sales,
        SUM(CASE WHEN metric = 'Sales Revenue (Incl OI)' AND metric_type = 'Actual' THEN period_value ELSE 0 END) AS actual_sales,

        SUM(CASE WHEN metric = 'Gross Margin' AND metric_type = 'AOP' THEN period_value ELSE 0 END) AS aop_gm,
        SUM(CASE WHEN metric = 'Gross Margin' AND metric_type = 'Actual' THEN period_value ELSE 0 END) AS actual_gm,

        SUM(CASE WHEN metric = 'EBITDA' AND metric_type = 'AOP' THEN period_value ELSE 0 END) AS aop_ebitda,
        SUM(CASE WHEN metric = 'EBITDA' AND metric_type = 'Actual' THEN period_value ELSE 0 END) AS actual_ebitda,

        SUM(CASE WHEN metric = 'EBIT' AND metric_type = 'AOP' THEN period_value ELSE 0 END) AS aop_ebit,
        SUM(CASE WHEN metric = 'EBIT' AND metric_type = 'Actual' THEN period_value ELSE 0 END) AS actual_ebit,

        SUM(CASE WHEN metric = 'EBT' AND metric_type = 'AOP' THEN period_value ELSE 0 END) AS aop_ebt,
        SUM(CASE WHEN metric = 'EBT' AND metric_type = 'Actual' THEN period_value ELSE 0 END) AS actual_ebt
    FROM cy_base
    GROUP BY date_my, STRFTIME(date_my, '%b-%y')
)

SELECT 
    m.metric,
    r.period_date,

    CASE m.metric
        WHEN 'GROSS %' THEN (r.aop_gm / NULLIF(r.aop_sales, 0)) * 100
        WHEN 'EBITDA %' THEN (r.aop_ebitda / NULLIF(r.aop_sales, 0)) * 100
        WHEN 'EBIT %' THEN (r.aop_ebit / NULLIF(r.aop_sales, 0)) * 100
        WHEN 'EBT %' THEN (r.aop_ebt / NULLIF(r.aop_sales, 0)) * 100
    END AS "CY AOP",

    CASE m.metric
        WHEN 'GROSS %' THEN (r.actual_gm / NULLIF(r.actual_sales, 0)) * 100
        WHEN 'EBITDA %' THEN (r.actual_ebitda / NULLIF(r.actual_sales, 0)) * 100
        WHEN 'EBIT %' THEN (r.actual_ebit / NULLIF(r.actual_sales, 0)) * 100
        WHEN 'EBT %' THEN (r.actual_ebt / NULLIF(r.actual_sales, 0)) * 100
    END AS "CY Actual",

    COALESCE(
    CASE m.metric
        WHEN 'GROSS %' THEN (l.ly_gm / NULLIF(l.ly_sales, 0)) * 100
        WHEN 'EBITDA %' THEN (l.ly_ebitda / NULLIF(l.ly_sales, 0)) * 100
        WHEN 'EBIT %' THEN (l.ly_ebit / NULLIF(l.ly_sales, 0)) * 100
        WHEN 'EBT %' THEN (l.ly_ebt / NULLIF(l.ly_sales, 0)) * 100
    END, 0
) AS "LY Actual",

COALESCE(
    CASE m.metric
        WHEN 'GROSS %' THEN ((r.actual_gm / NULLIF(r.actual_sales, 0)) - (r.aop_gm / NULLIF(r.aop_sales, 0))) * 100
        WHEN 'EBITDA %' THEN ((r.actual_ebitda / NULLIF(r.actual_sales, 0)) - (r.aop_ebitda / NULLIF(r.aop_sales, 0))) * 100
        WHEN 'EBIT %' THEN ((r.actual_ebit / NULLIF(r.actual_sales, 0)) - (r.aop_ebit / NULLIF(r.aop_sales, 0))) * 100
        WHEN 'EBT %' THEN ((r.actual_ebt / NULLIF(r.actual_sales, 0)) - (r.aop_ebt / NULLIF(r.aop_sales, 0))) * 100
    END, 0
) AS "Variance vs AOP",

COALESCE(
    CASE m.metric
        WHEN 'GROSS %' THEN ((r.actual_gm / NULLIF(r.actual_sales, 0)) - (l.ly_gm / NULLIF(l.ly_sales, 0))) * 100
        WHEN 'EBITDA %' THEN ((r.actual_ebitda / NULLIF(r.actual_sales, 0)) - (l.ly_ebitda / NULLIF(l.ly_sales, 0))) * 100
        WHEN 'EBIT %' THEN ((r.actual_ebit / NULLIF(r.actual_sales, 0)) - (l.ly_ebit / NULLIF(l.ly_sales, 0))) * 100
        WHEN 'EBT %' THEN ((r.actual_ebt / NULLIF(r.actual_sales, 0)) - (l.ly_ebt / NULLIF(l.ly_sales, 0))) * 100
    END, 0
) AS "Variance vs LY"

FROM reshaped_cy r
LEFT JOIN ly_base l ON r.cy_date = l.ly_date + INTERVAL '1 year'
CROSS JOIN metric_order m
ORDER BY m.sort_order;

```

```sql max_date_cons
SELECT 
    STRFTIME(MAX(date_my), '%b-%y') AS max_date_cons
FROM 
    income_statement
WHERE 
    STRFTIME(date_my, '%b-%y') != 'Feb-25';

```

```sql date_filter_ytd
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
        -- Derive the YTD year label
        CASE 
            WHEN EXTRACT(YEAR FROM date_my) = 2019 
                 AND EXTRACT(MONTH FROM date_my) BETWEEN 4 AND 12 THEN '2019'
            WHEN EXTRACT(YEAR FROM date_my) = 2020 THEN '2020'
            WHEN EXTRACT(YEAR FROM date_my) = 2021 THEN '2021'
            WHEN EXTRACT(YEAR FROM date_my) = 2022 THEN '2022'
            WHEN EXTRACT(YEAR FROM date_my) = 2023 THEN '2023'
            WHEN EXTRACT(YEAR FROM date_my) = 2024 THEN '2024'
            WHEN EXTRACT(YEAR FROM date_my) = 2025 THEN '2025'
        END AS date_filter_ytd,

        CASE 
            WHEN EXTRACT(YEAR FROM date_my) = 2019 
                 AND EXTRACT(MONTH FROM date_my) BETWEEN 4 AND 12 THEN DATE '2019-01-01'
            ELSE DATE_TRUNC('year', date_my)
        END AS date_sort,

        EXTRACT(MONTH FROM date_my) AS month_num
    FROM income_statement
    WHERE date_my IS NOT NULL
),
calendar_with_names AS (
    SELECT DISTINCT
        cy.date_filter_ytd,
        cy.date_sort,
        ml.month_name,
        cy.month_num
    FROM calendar_years cy
    JOIN month_lookup ml ON cy.month_num = ml.month_num
    WHERE cy.date_filter_ytd IS NOT NULL
),
aggregated_calendar AS (
    SELECT 
        date_filter_ytd,
        date_sort,
        STRING_AGG(month_name ORDER BY month_num) AS months_included
    FROM calendar_with_names
    GROUP BY date_filter_ytd, date_sort
)
SELECT 
    date_filter_ytd,
    date_sort,
    months_included
FROM 
    aggregated_calendar
ORDER BY 
    date_sort DESC;

```

```sql month_filter_ytd
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
    )

    SELECT 
        month_name AS month_filter_ytd,
        month_name AS label,
        month_num
    FROM month_lookup
    WHERE 
        '${inputs.date_filter_ytd.value}' != '2025'
        OR month_name = 'January'
    ORDER BY month_num;

```

```sql ytd_income
WITH metric_order AS (
    SELECT 
        metric,
        ROW_NUMBER() OVER (ORDER BY MIN(date_my)) AS sort_order
    FROM income_statement
    WHERE 
        entity = 'Global Green India'
        AND TRIM(metric) IS NOT NULL
        AND TRIM(metric) <> ''
        AND metric NOT IN ('GROSS %', 'EBITDA %', 'EBT %', 'EBIT %', 'DSO', 'DPO', 'Trade Payables')
    GROUP BY metric
),

ytd_window AS (
    SELECT 
        '${inputs.date_filter_ytd.value}'::INT AS ytd_year,

        CASE 
            WHEN '${inputs.month_filter_ytd.value}' = 'January' THEN 1
            WHEN '${inputs.month_filter_ytd.value}' = 'February' THEN 2
            WHEN '${inputs.month_filter_ytd.value}' = 'March' THEN 3
            WHEN '${inputs.month_filter_ytd.value}' = 'April' THEN 4
            WHEN '${inputs.month_filter_ytd.value}' = 'May' THEN 5
            WHEN '${inputs.month_filter_ytd.value}' = 'June' THEN 6
            WHEN '${inputs.month_filter_ytd.value}' = 'July' THEN 7
            WHEN '${inputs.month_filter_ytd.value}' = 'August' THEN 8
            WHEN '${inputs.month_filter_ytd.value}' = 'September' THEN 9
            WHEN '${inputs.month_filter_ytd.value}' = 'October' THEN 10
            WHEN '${inputs.month_filter_ytd.value}' = 'November' THEN 11
            WHEN '${inputs.month_filter_ytd.value}' = 'December' THEN 12
            ELSE 12
        END AS ytd_month,

        -- Current YTD Start Date
        CASE 
            WHEN '${inputs.date_filter_ytd.value}' = '2019' 
                THEN STRPTIME('2019-04-01', '%Y-%m-%d')
            ELSE STRPTIME('${inputs.date_filter_ytd.value}-01-01', '%Y-%m-%d')
        END AS start_date,

        -- Current YTD End Date
        (
            STRPTIME(
                '${inputs.date_filter_ytd.value}-' || 
                LPAD(CAST(
                    CASE 
                        WHEN '${inputs.month_filter_ytd.value}' = 'January' THEN 1
                        WHEN '${inputs.month_filter_ytd.value}' = 'February' THEN 2
                        WHEN '${inputs.month_filter_ytd.value}' = 'March' THEN 3
                        WHEN '${inputs.month_filter_ytd.value}' = 'April' THEN 4
                        WHEN '${inputs.month_filter_ytd.value}' = 'May' THEN 5
                        WHEN '${inputs.month_filter_ytd.value}' = 'June' THEN 6
                        WHEN '${inputs.month_filter_ytd.value}' = 'July' THEN 7
                        WHEN '${inputs.month_filter_ytd.value}' = 'August' THEN 8
                        WHEN '${inputs.month_filter_ytd.value}' = 'September' THEN 9
                        WHEN '${inputs.month_filter_ytd.value}' = 'October' THEN 10
                        WHEN '${inputs.month_filter_ytd.value}' = 'November' THEN 11
                        WHEN '${inputs.month_filter_ytd.value}' = 'December' THEN 12
                        ELSE 12
                    END AS TEXT
                ), 2, '0') || '-01', '%Y-%m-%d'
            ) + INTERVAL '1 month' - INTERVAL '1 day'
        ) AS end_date,

        -- Last Year YTD Start Date
        CASE 
            WHEN '${inputs.date_filter_ytd.value}' = '2019' 
                THEN STRPTIME('2018-04-01', '%Y-%m-%d')
            ELSE STRPTIME((CAST('${inputs.date_filter_ytd.value}' AS INT) - 1) || '-01-01', '%Y-%m-%d')
        END AS ly_start_date,

        -- Last Year YTD End Date
        (
            STRPTIME(
                (CAST('${inputs.date_filter_ytd.value}' AS INT) - 1) || '-' ||
                LPAD(CAST(
                    CASE 
                        WHEN '${inputs.month_filter_ytd.value}' = 'January' THEN 1
                        WHEN '${inputs.month_filter_ytd.value}' = 'February' THEN 2
                        WHEN '${inputs.month_filter_ytd.value}' = 'March' THEN 3
                        WHEN '${inputs.month_filter_ytd.value}' = 'April' THEN 4
                        WHEN '${inputs.month_filter_ytd.value}' = 'May' THEN 5
                        WHEN '${inputs.month_filter_ytd.value}' = 'June' THEN 6
                        WHEN '${inputs.month_filter_ytd.value}' = 'July' THEN 7
                        WHEN '${inputs.month_filter_ytd.value}' = 'August' THEN 8
                        WHEN '${inputs.month_filter_ytd.value}' = 'September' THEN 9
                        WHEN '${inputs.month_filter_ytd.value}' = 'October' THEN 10
                        WHEN '${inputs.month_filter_ytd.value}' = 'November' THEN 11
                        WHEN '${inputs.month_filter_ytd.value}' = 'December' THEN 12
                        ELSE 12
                    END AS TEXT
                ), 2, '0') || '-01', '%Y-%m-%d'
            ) + INTERVAL '1 month' - INTERVAL '1 day'
        ) AS ly_end_date
),

base AS (
    SELECT 
        metric,
        metric_type,
        date_my AS period_date,
        period_value
    FROM income_statement
    WHERE 
        TRIM(metric) IS NOT NULL
        AND TRIM(metric) <> ''
        AND metric NOT IN ('GROSS %', 'EBITDA %', 'EBT %', 'EBIT %', 'DSO', 'DPO', 'Trade Payables')
        AND entity = CASE COALESCE('${inputs.matric_ytd}', 'GGCL')
            WHEN 'GGCL' THEN 'Global Green India'
            WHEN 'GGE' THEN 'Global Green Europe'
        END
),

filtered AS (
    SELECT 
        b.metric,
        b.metric_type,
        b.period_value,
        b.period_date,
        w.start_date,
        w.end_date,
        w.ly_start_date,
        w.ly_end_date
    FROM base b
    CROSS JOIN ytd_window w
),

aggregated AS (
    SELECT 
        metric,

        COALESCE(SUM(CASE 
            WHEN metric_type = 'Actual' 
                AND period_date BETWEEN start_date AND end_date 
            THEN period_value END), 0) AS "YTD Actual",

        COALESCE(SUM(CASE 
            WHEN metric_type = 'AOP' 
                AND period_date BETWEEN start_date AND end_date 
            THEN period_value END), 0) AS "YTD AOP",

        COALESCE(SUM(CASE 
            WHEN metric_type = 'Actual' 
                AND period_date BETWEEN ly_start_date AND ly_end_date 
            THEN period_value END), 0) AS "LY Actual YTD"
        
    FROM filtered
    GROUP BY metric
)

SELECT 
    a.metric,
    a."YTD Actual",
    a."YTD AOP",
    a."LY Actual YTD",
    a."YTD Actual" - a."YTD AOP" AS "Variance vs AOP YTD",
    a."YTD Actual" - a."LY Actual YTD" AS "Variance vs LY YTD"
FROM aggregated a
LEFT JOIN metric_order m ON a.metric = m.metric
WHERE 
    a.metric NOT IN ('DSO', 'DPO') 
    AND (
        a."YTD Actual" <> 0
        OR a."YTD AOP" <> 0
        OR a."LY Actual YTD" <> 0
        OR a."YTD Actual" - a."YTD AOP" <> 0
        OR a."YTD Actual" - a."LY Actual YTD" <> 0
    )
ORDER BY m.sort_order;


```

```sql ytd_perc
WITH metric_order AS (
    SELECT 
        metric,
        ROW_NUMBER() OVER (ORDER BY MIN(date_my)) AS sort_order
    FROM income_statement
    WHERE 
        entity = 'Global Green India'
        AND TRIM(metric) IS NOT NULL
        AND TRIM(metric) <> ''
        AND metric IN ('GROSS %', 'EBITDA %', 'EBT %', 'EBIT %')
    GROUP BY metric
),

ytd_window AS (
    SELECT 
        '${inputs.date_filter_ytd.value}'::INT AS ytd_year,

        CASE 
            WHEN '${inputs.month_filter_ytd.value}' = 'January' THEN 1
            WHEN '${inputs.month_filter_ytd.value}' = 'February' THEN 2
            WHEN '${inputs.month_filter_ytd.value}' = 'March' THEN 3
            WHEN '${inputs.month_filter_ytd.value}' = 'April' THEN 4
            WHEN '${inputs.month_filter_ytd.value}' = 'May' THEN 5
            WHEN '${inputs.month_filter_ytd.value}' = 'June' THEN 6
            WHEN '${inputs.month_filter_ytd.value}' = 'July' THEN 7
            WHEN '${inputs.month_filter_ytd.value}' = 'August' THEN 8
            WHEN '${inputs.month_filter_ytd.value}' = 'September' THEN 9
            WHEN '${inputs.month_filter_ytd.value}' = 'October' THEN 10
            WHEN '${inputs.month_filter_ytd.value}' = 'November' THEN 11
            WHEN '${inputs.month_filter_ytd.value}' = 'December' THEN 12
            ELSE 12
        END AS ytd_month,

        CASE 
            WHEN '${inputs.date_filter_ytd.value}' = '2019'
                THEN STRPTIME('2019-04-01', '%Y-%m-%d')
            ELSE STRPTIME('${inputs.date_filter_ytd.value}-01-01', '%Y-%m-%d')
        END AS start_date,

        (
            STRPTIME(
                '${inputs.date_filter_ytd.value}-' || 
                LPAD(CAST(CASE 
                    WHEN '${inputs.month_filter_ytd.value}' = 'January' THEN 1
                    WHEN '${inputs.month_filter_ytd.value}' = 'February' THEN 2
                    WHEN '${inputs.month_filter_ytd.value}' = 'March' THEN 3
                    WHEN '${inputs.month_filter_ytd.value}' = 'April' THEN 4
                    WHEN '${inputs.month_filter_ytd.value}' = 'May' THEN 5
                    WHEN '${inputs.month_filter_ytd.value}' = 'June' THEN 6
                    WHEN '${inputs.month_filter_ytd.value}' = 'July' THEN 7
                    WHEN '${inputs.month_filter_ytd.value}' = 'August' THEN 8
                    WHEN '${inputs.month_filter_ytd.value}' = 'September' THEN 9
                    WHEN '${inputs.month_filter_ytd.value}' = 'October' THEN 10
                    WHEN '${inputs.month_filter_ytd.value}' = 'November' THEN 11
                    WHEN '${inputs.month_filter_ytd.value}' = 'December' THEN 12
                    ELSE 12
                END AS TEXT), 2, '0') || '-01', '%Y-%m-%d'
            ) + INTERVAL '1 month' - INTERVAL '1 day'
        ) AS end_date,

        CASE 
            WHEN '${inputs.date_filter_ytd.value}' = '2019'
                THEN STRPTIME('2018-04-01', '%Y-%m-%d')
            ELSE STRPTIME((CAST('${inputs.date_filter_ytd.value}' AS INT) - 1) || '-01-01', '%Y-%m-%d')
        END AS ly_start_date,

        (
            STRPTIME(
                (CAST('${inputs.date_filter_ytd.value}' AS INT) - 1) || '-' ||
                LPAD(CAST(CASE 
                    WHEN '${inputs.month_filter_ytd.value}' = 'January' THEN 1
                    WHEN '${inputs.month_filter_ytd.value}' = 'February' THEN 2
                    WHEN '${inputs.month_filter_ytd.value}' = 'March' THEN 3
                    WHEN '${inputs.month_filter_ytd.value}' = 'April' THEN 4
                    WHEN '${inputs.month_filter_ytd.value}' = 'May' THEN 5
                    WHEN '${inputs.month_filter_ytd.value}' = 'June' THEN 6
                    WHEN '${inputs.month_filter_ytd.value}' = 'July' THEN 7
                    WHEN '${inputs.month_filter_ytd.value}' = 'August' THEN 8
                    WHEN '${inputs.month_filter_ytd.value}' = 'September' THEN 9
                    WHEN '${inputs.month_filter_ytd.value}' = 'October' THEN 10
                    WHEN '${inputs.month_filter_ytd.value}' = 'November' THEN 11
                    WHEN '${inputs.month_filter_ytd.value}' = 'December' THEN 12
                    ELSE 12
                END AS TEXT), 2, '0') || '-01', '%Y-%m-%d'
            ) + INTERVAL '1 month' - INTERVAL '1 day'
        ) AS ly_end_date
),

base AS (
    SELECT 
        metric,
        metric_type,
        date_my AS period_date,
        period_value
    FROM income_statement
    WHERE 
        TRIM(metric) IS NOT NULL
        AND TRIM(metric) <> ''
        AND metric IN ('GROSS %', 'EBITDA %', 'EBT %', 'EBIT %')
        AND entity = CASE COALESCE('${inputs.matric_ytd}', 'GGCL')
            WHEN 'GGCL' THEN 'Global Green India'
            WHEN 'GGE' THEN 'Global Green Europe'
        END
),

filtered AS (
    SELECT 
        b.metric,
        b.metric_type,
        b.period_value,
        b.period_date,
        w.start_date,
        w.end_date,
        w.ly_start_date,
        w.ly_end_date
    FROM base b
    CROSS JOIN ytd_window w
),

aggregated AS (
    SELECT 
        metric,
        COALESCE(SUM(CASE 
            WHEN metric_type = 'Actual' 
             AND period_date BETWEEN start_date AND end_date 
        THEN period_value END), 0) * 100 AS "YTD Actual",

        COALESCE(SUM(CASE 
            WHEN metric_type = 'AOP' 
             AND period_date BETWEEN start_date AND end_date 
        THEN period_value END), 0) * 100 AS "YTD AOP",

        COALESCE(SUM(CASE 
            WHEN metric_type = 'Actual' 
             AND period_date BETWEEN ly_start_date AND ly_end_date 
        THEN period_value END), 0) * 100 AS "LY Actual YTD"
        
    FROM filtered
    GROUP BY metric
)

SELECT 
    a.metric,
    a."YTD Actual",
    a."YTD AOP",
    a."LY Actual YTD",
    a."YTD Actual" - a."YTD AOP" AS "Variance vs AOP YTD",
    a."YTD Actual" - a."LY Actual YTD" AS "Variance vs LY YTD"
FROM aggregated a
LEFT JOIN metric_order m ON a.metric = m.metric
WHERE 
    a.metric NOT IN ('DSO', 'DPO') 
    AND (
        a."YTD Actual" <> 0
        OR a."YTD AOP" <> 0
        OR a."LY Actual YTD" <> 0
        OR a."YTD Actual" - a."YTD AOP" <> 0
        OR a."YTD Actual" - a."LY Actual YTD" <> 0
    )
ORDER BY m.sort_order;

```

```sql max_date_ytd_income
SELECT 
    STRFTIME(MAX(date_my), '%b-%y') AS max_date_ytd_income
FROM 
    income_statement
WHERE 
    STRFTIME(date_my, '%b-%y') != 'Feb-25';
```

```sql date_filter_ytd_cons
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
        -- Derive the YTD year label
        CASE 
            WHEN EXTRACT(YEAR FROM date_my) = 2019 
                 AND EXTRACT(MONTH FROM date_my) BETWEEN 4 AND 12 THEN '2019'
            WHEN EXTRACT(YEAR FROM date_my) = 2020 THEN '2020'
            WHEN EXTRACT(YEAR FROM date_my) = 2021 THEN '2021'
            WHEN EXTRACT(YEAR FROM date_my) = 2022 THEN '2022'
            WHEN EXTRACT(YEAR FROM date_my) = 2023 THEN '2023'
            WHEN EXTRACT(YEAR FROM date_my) = 2024 THEN '2024'
            WHEN EXTRACT(YEAR FROM date_my) = 2025 THEN '2025'
        END AS date_filter_ytd_cons,

        CASE 
            WHEN EXTRACT(YEAR FROM date_my) = 2019 
                 AND EXTRACT(MONTH FROM date_my) BETWEEN 4 AND 12 THEN DATE '2019-01-01'
            ELSE DATE_TRUNC('year', date_my)
        END AS date_sort,

        EXTRACT(MONTH FROM date_my) AS month_num
    FROM income_statement
    WHERE date_my IS NOT NULL
),
calendar_with_names AS (
    SELECT DISTINCT
        cy.date_filter_ytd_cons,
        cy.date_sort,
        ml.month_name,
        cy.month_num
    FROM calendar_years cy
    JOIN month_lookup ml ON cy.month_num = ml.month_num
    WHERE cy.date_filter_ytd_cons IS NOT NULL
),
aggregated_calendar AS (
    SELECT 
        date_filter_ytd_cons,
        date_sort,
        STRING_AGG(month_name ORDER BY month_num) AS months_included
    FROM calendar_with_names
    GROUP BY date_filter_ytd_cons, date_sort
)
SELECT 
    date_filter_ytd_cons,
    date_sort,
    months_included
FROM 
    aggregated_calendar
ORDER BY 
    date_sort DESC;
```

```sql month_filter_ytd_cons
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
)
SELECT 
    month_name AS month_filter_ytd_cons,
    month_name AS label,
    month_num
FROM month_lookup
WHERE 
    '${inputs.date_filter_ytd.value}' != '2025'
    OR month_name = 'January'
ORDER BY month_num;

```

```sql ytd_income_cons
WITH metric_order AS (
    SELECT 
        metric,
        ROW_NUMBER() OVER (ORDER BY MIN(date_my)) AS sort_order
    FROM income_statement
    WHERE 
        entity = 'Global Green India'
        AND TRIM(metric) IS NOT NULL
        AND TRIM(metric) <> ''
        AND metric NOT IN ('GROSS %', 'EBITDA %', 'EBT %', 'EBIT %', 'DSO', 'DPO', 'Trade Payables')
    GROUP BY metric
),
ytd_window AS (
    SELECT 
        '${inputs.date_filter_ytd_cons.value}'::INT AS ytd_year,

        CASE 
            WHEN '${inputs.month_filter_ytd_cons.value}' = 'January' THEN 1
            WHEN '${inputs.month_filter_ytd_cons.value}' = 'February' THEN 2
            WHEN '${inputs.month_filter_ytd_cons.value}' = 'March' THEN 3
            WHEN '${inputs.month_filter_ytd_cons.value}' = 'April' THEN 4
            WHEN '${inputs.month_filter_ytd_cons.value}' = 'May' THEN 5
            WHEN '${inputs.month_filter_ytd_cons.value}' = 'June' THEN 6
            WHEN '${inputs.month_filter_ytd_cons.value}' = 'July' THEN 7
            WHEN '${inputs.month_filter_ytd_cons.value}' = 'August' THEN 8
            WHEN '${inputs.month_filter_ytd_cons.value}' = 'September' THEN 9
            WHEN '${inputs.month_filter_ytd_cons.value}' = 'October' THEN 10
            WHEN '${inputs.month_filter_ytd_cons.value}' = 'November' THEN 11
            WHEN '${inputs.month_filter_ytd_cons.value}' = 'December' THEN 12
            ELSE 12
        END AS ytd_month,

        -- Start of current YTD
        CASE 
            WHEN '${inputs.date_filter_ytd_cons.value}' = '2019'
                THEN STRPTIME('2019-04-01', '%Y-%m-%d')
            ELSE STRPTIME('${inputs.date_filter_ytd_cons.value}-01-01', '%Y-%m-%d')
        END AS start_date,

        -- End of current YTD
        STRPTIME(
            '${inputs.date_filter_ytd_cons.value}-' || LPAD(
                CAST(
                    CASE 
                        WHEN '${inputs.month_filter_ytd_cons.value}' = 'January' THEN 1
                        WHEN '${inputs.month_filter_ytd_cons.value}' = 'February' THEN 2
                        WHEN '${inputs.month_filter_ytd_cons.value}' = 'March' THEN 3
                        WHEN '${inputs.month_filter_ytd_cons.value}' = 'April' THEN 4
                        WHEN '${inputs.month_filter_ytd_cons.value}' = 'May' THEN 5
                        WHEN '${inputs.month_filter_ytd_cons.value}' = 'June' THEN 6
                        WHEN '${inputs.month_filter_ytd_cons.value}' = 'July' THEN 7
                        WHEN '${inputs.month_filter_ytd_cons.value}' = 'August' THEN 8
                        WHEN '${inputs.month_filter_ytd_cons.value}' = 'September' THEN 9
                        WHEN '${inputs.month_filter_ytd_cons.value}' = 'October' THEN 10
                        WHEN '${inputs.month_filter_ytd_cons.value}' = 'November' THEN 11
                        WHEN '${inputs.month_filter_ytd_cons.value}' = 'December' THEN 12
                        ELSE 12
                    END AS TEXT
                ), 2, '0'
            ) || '-01', '%Y-%m-%d'
        ) + INTERVAL '1 month' - INTERVAL '1 day' AS end_date,

        -- Start of LY YTD
        CASE 
            WHEN '${inputs.date_filter_ytd_cons.value}' = '2019'
                THEN STRPTIME('2018-04-01', '%Y-%m-%d')
            ELSE STRPTIME((CAST('${inputs.date_filter_ytd_cons.value}' AS INT) - 1) || '-01-01', '%Y-%m-%d')
        END AS ly_start_date,

        -- End of LY YTD
        STRPTIME(
            (CAST('${inputs.date_filter_ytd_cons.value}' AS INT) - 1) || '-' ||
            LPAD(
                CAST(
                    CASE 
                        WHEN '${inputs.month_filter_ytd_cons.value}' = 'January' THEN 1
                        WHEN '${inputs.month_filter_ytd_cons.value}' = 'February' THEN 2
                        WHEN '${inputs.month_filter_ytd_cons.value}' = 'March' THEN 3
                        WHEN '${inputs.month_filter_ytd_cons.value}' = 'April' THEN 4
                        WHEN '${inputs.month_filter_ytd_cons.value}' = 'May' THEN 5
                        WHEN '${inputs.month_filter_ytd_cons.value}' = 'June' THEN 6
                        WHEN '${inputs.month_filter_ytd_cons.value}' = 'July' THEN 7
                        WHEN '${inputs.month_filter_ytd_cons.value}' = 'August' THEN 8
                        WHEN '${inputs.month_filter_ytd_cons.value}' = 'September' THEN 9
                        WHEN '${inputs.month_filter_ytd_cons.value}' = 'October' THEN 10
                        WHEN '${inputs.month_filter_ytd_cons.value}' = 'November' THEN 11
                        WHEN '${inputs.month_filter_ytd_cons.value}' = 'December' THEN 12
                        ELSE 12
                    END AS TEXT
                ), 2, '0'
            ) || '-01', '%Y-%m-%d'
        ) + INTERVAL '1 month' - INTERVAL '1 day' AS ly_end_date
),
base AS (
    SELECT 
        metric,
        metric_type,
        date_my AS period_date,
        period_value
    FROM income_statement
    WHERE 
        entity IN ('Global Green India', 'Global Green Europe')
        AND TRIM(metric) IS NOT NULL
        AND TRIM(metric) <> ''
        AND metric NOT IN ('GROSS %', 'EBITDA %', 'EBT %', 'EBIT %', 'DSO', 'DPO', 'Trade Payables')
),
filtered AS (
    SELECT 
        b.metric,
        b.metric_type,
        b.period_value,
        b.period_date,
        w.start_date,
        w.end_date,
        w.ly_start_date,
        w.ly_end_date
    FROM base b
    CROSS JOIN ytd_window w
),
aggregated AS (
    SELECT 
        metric,

        COALESCE(SUM(CASE 
            WHEN metric_type = 'Actual' 
             AND period_date BETWEEN start_date AND end_date 
        THEN period_value END), 0) AS "YTD Actual",

        COALESCE(SUM(CASE 
            WHEN metric_type = 'AOP' 
             AND period_date BETWEEN start_date AND end_date 
        THEN period_value END), 0) AS "YTD AOP",

        COALESCE(SUM(CASE 
            WHEN metric_type = 'Actual' 
             AND period_date BETWEEN ly_start_date AND ly_end_date 
        THEN period_value END), 0) AS "LY Actual YTD"
        
    FROM filtered
    GROUP BY metric
)

SELECT 
    a.metric,
    a."YTD Actual",
    a."YTD AOP",
    a."LY Actual YTD",
    a."YTD Actual" - a."YTD AOP" AS "Variance vs AOP YTD",
    a."YTD Actual" - a."LY Actual YTD" AS "Variance vs LY YTD"
FROM aggregated a
LEFT JOIN metric_order m ON a.metric = m.metric
WHERE 
    a."YTD Actual" <> 0
    OR a."YTD AOP" <> 0
    OR a."LY Actual YTD" <> 0
    OR a."YTD Actual" - a."YTD AOP" <> 0
    OR a."YTD Actual" - a."LY Actual YTD" <> 0
ORDER BY m.sort_order;

```

```sql ytd_income_cons_perc
WITH metric_order AS (
    SELECT 
        metric,
        ROW_NUMBER() OVER (ORDER BY MIN(date_my)) AS sort_order
    FROM income_statement
    WHERE 
        entity = 'Global Green India'
        AND TRIM(metric) IN ('GROSS %', 'EBITDA %', 'EBT %', 'EBIT %')
    GROUP BY metric
),
ytd_window AS (
    SELECT 
        '${inputs.date_filter_ytd_cons.value}'::INT AS ytd_year,

        CASE 
            WHEN '${inputs.month_filter_ytd_cons.value}' = 'January' THEN 1
            WHEN '${inputs.month_filter_ytd_cons.value}' = 'February' THEN 2
            WHEN '${inputs.month_filter_ytd_cons.value}' = 'March' THEN 3
            WHEN '${inputs.month_filter_ytd_cons.value}' = 'April' THEN 4
            WHEN '${inputs.month_filter_ytd_cons.value}' = 'May' THEN 5
            WHEN '${inputs.month_filter_ytd_cons.value}' = 'June' THEN 6
            WHEN '${inputs.month_filter_ytd_cons.value}' = 'July' THEN 7
            WHEN '${inputs.month_filter_ytd_cons.value}' = 'August' THEN 8
            WHEN '${inputs.month_filter_ytd_cons.value}' = 'September' THEN 9
            WHEN '${inputs.month_filter_ytd_cons.value}' = 'October' THEN 10
            WHEN '${inputs.month_filter_ytd_cons.value}' = 'November' THEN 11
            WHEN '${inputs.month_filter_ytd_cons.value}' = 'December' THEN 12
            ELSE 12
        END AS ytd_month,

        -- Start of current YTD
        CASE 
            WHEN '${inputs.date_filter_ytd_cons.value}' = '2019'
                THEN STRPTIME('2019-04-01', '%Y-%m-%d')
            ELSE STRPTIME('${inputs.date_filter_ytd_cons.value}-01-01', '%Y-%m-%d')
        END AS start_date,

        -- End of current YTD
        (
            STRPTIME('${inputs.date_filter_ytd_cons.value}-' || 
                LPAD(
                    CAST(
                        CASE 
                            WHEN '${inputs.month_filter_ytd_cons.value}' = 'January' THEN 1
                            WHEN '${inputs.month_filter_ytd_cons.value}' = 'February' THEN 2
                            WHEN '${inputs.month_filter_ytd_cons.value}' = 'March' THEN 3
                            WHEN '${inputs.month_filter_ytd_cons.value}' = 'April' THEN 4
                            WHEN '${inputs.month_filter_ytd_cons.value}' = 'May' THEN 5
                            WHEN '${inputs.month_filter_ytd_cons.value}' = 'June' THEN 6
                            WHEN '${inputs.month_filter_ytd_cons.value}' = 'July' THEN 7
                            WHEN '${inputs.month_filter_ytd_cons.value}' = 'August' THEN 8
                            WHEN '${inputs.month_filter_ytd_cons.value}' = 'September' THEN 9
                            WHEN '${inputs.month_filter_ytd_cons.value}' = 'October' THEN 10
                            WHEN '${inputs.month_filter_ytd_cons.value}' = 'November' THEN 11
                            WHEN '${inputs.month_filter_ytd_cons.value}' = 'December' THEN 12
                            ELSE 12
                        END AS TEXT
                    ), 2, '0'
                ) || '-01', '%Y-%m-%d'
            ) + INTERVAL '1 month' - INTERVAL '1 day'
        ) AS end_date,

        -- LY Start
        CASE 
            WHEN '${inputs.date_filter_ytd_cons.value}' = '2019'
                THEN STRPTIME('2018-04-01', '%Y-%m-%d')
            ELSE STRPTIME((CAST('${inputs.date_filter_ytd_cons.value}' AS INT) - 1) || '-01-01', '%Y-%m-%d')
        END AS ly_start_date,

        -- LY End
        (
            STRPTIME((CAST('${inputs.date_filter_ytd_cons.value}' AS INT) - 1) || '-' ||
                LPAD(
                    CAST(
                        CASE 
                            WHEN '${inputs.month_filter_ytd_cons.value}' = 'January' THEN 1
                            WHEN '${inputs.month_filter_ytd_cons.value}' = 'February' THEN 2
                            WHEN '${inputs.month_filter_ytd_cons.value}' = 'March' THEN 3
                            WHEN '${inputs.month_filter_ytd_cons.value}' = 'April' THEN 4
                            WHEN '${inputs.month_filter_ytd_cons.value}' = 'May' THEN 5
                            WHEN '${inputs.month_filter_ytd_cons.value}' = 'June' THEN 6
                            WHEN '${inputs.month_filter_ytd_cons.value}' = 'July' THEN 7
                            WHEN '${inputs.month_filter_ytd_cons.value}' = 'August' THEN 8
                            WHEN '${inputs.month_filter_ytd_cons.value}' = 'September' THEN 9
                            WHEN '${inputs.month_filter_ytd_cons.value}' = 'October' THEN 10
                            WHEN '${inputs.month_filter_ytd_cons.value}' = 'November' THEN 11
                            WHEN '${inputs.month_filter_ytd_cons.value}' = 'December' THEN 12
                            ELSE 12
                        END AS TEXT
                    ), 2, '0'
                ) || '-01', '%Y-%m-%d'
            ) + INTERVAL '1 month' - INTERVAL '1 day'
        ) AS ly_end_date
),
base AS (
    SELECT 
        TRIM(metric) AS metric,
        metric_type,
        date_my AS period_date,
        period_value
    FROM income_statement
    WHERE 
        entity IN ('Global Green India', 'Global Green Europe')
        AND TRIM(metric) IN ('Sales Revenue (Incl OI)', 'Gross Margin', 'EBITDA', 'EBIT', 'EBT')
),
filtered AS (
    SELECT 
        b.metric,
        b.metric_type,
        b.period_value,
        b.period_date,
        w.start_date,
        w.end_date,
        w.ly_start_date,
        w.ly_end_date
    FROM base b
    CROSS JOIN ytd_window w
),
aggregated AS (
    SELECT
        SUM(CASE WHEN metric = 'Sales Revenue (Incl OI)' AND metric_type = 'Actual' AND period_date BETWEEN start_date AND end_date THEN period_value ELSE 0 END) AS ytd_sales_actual,
        SUM(CASE WHEN metric = 'Sales Revenue (Incl OI)' AND metric_type = 'AOP' AND period_date BETWEEN start_date AND end_date THEN period_value ELSE 0 END) AS ytd_sales_aop,
        SUM(CASE WHEN metric = 'Sales Revenue (Incl OI)' AND metric_type = 'Actual' AND period_date BETWEEN ly_start_date AND ly_end_date THEN period_value ELSE 0 END) AS ytd_sales_ly,

        SUM(CASE WHEN metric = 'Gross Margin' AND metric_type = 'Actual' AND period_date BETWEEN start_date AND end_date THEN period_value ELSE 0 END) AS ytd_gm_actual,
        SUM(CASE WHEN metric = 'Gross Margin' AND metric_type = 'AOP' AND period_date BETWEEN start_date AND end_date THEN period_value ELSE 0 END) AS ytd_gm_aop,
        SUM(CASE WHEN metric = 'Gross Margin' AND metric_type = 'Actual' AND period_date BETWEEN ly_start_date AND ly_end_date THEN period_value ELSE 0 END) AS ytd_gm_ly,

        SUM(CASE WHEN metric = 'EBITDA' AND metric_type = 'Actual' AND period_date BETWEEN start_date AND end_date THEN period_value ELSE 0 END) AS ytd_ebitda_actual,
        SUM(CASE WHEN metric = 'EBITDA' AND metric_type = 'AOP' AND period_date BETWEEN start_date AND end_date THEN period_value ELSE 0 END) AS ytd_ebitda_aop,
        SUM(CASE WHEN metric = 'EBITDA' AND metric_type = 'Actual' AND period_date BETWEEN ly_start_date AND ly_end_date THEN period_value ELSE 0 END) AS ytd_ebitda_ly,

        SUM(CASE WHEN metric = 'EBIT' AND metric_type = 'Actual' AND period_date BETWEEN start_date AND end_date THEN period_value ELSE 0 END) AS ytd_ebit_actual,
        SUM(CASE WHEN metric = 'EBIT' AND metric_type = 'AOP' AND period_date BETWEEN start_date AND end_date THEN period_value ELSE 0 END) AS ytd_ebit_aop,
        SUM(CASE WHEN metric = 'EBIT' AND metric_type = 'Actual' AND period_date BETWEEN ly_start_date AND ly_end_date THEN period_value ELSE 0 END) AS ytd_ebit_ly,

        SUM(CASE WHEN metric = 'EBT' AND metric_type = 'Actual' AND period_date BETWEEN start_date AND end_date THEN period_value ELSE 0 END) AS ytd_ebt_actual,
        SUM(CASE WHEN metric = 'EBT' AND metric_type = 'AOP' AND period_date BETWEEN start_date AND end_date THEN period_value ELSE 0 END) AS ytd_ebt_aop,
        SUM(CASE WHEN metric = 'EBT' AND metric_type = 'Actual' AND period_date BETWEEN ly_start_date AND ly_end_date THEN period_value ELSE 0 END) AS ytd_ebt_ly
    FROM filtered
)

SELECT 
    m.metric,

    CASE m.metric
        WHEN 'GROSS %' THEN (a.ytd_gm_actual / NULLIF(a.ytd_sales_actual, 0)) * 100
        WHEN 'EBITDA %' THEN (a.ytd_ebitda_actual / NULLIF(a.ytd_sales_actual, 0)) * 100
        WHEN 'EBIT %' THEN (a.ytd_ebit_actual / NULLIF(a.ytd_sales_actual, 0)) * 100
        WHEN 'EBT %' THEN (a.ytd_ebt_actual / NULLIF(a.ytd_sales_actual, 0)) * 100
    END AS "YTD Actual",

    CASE m.metric
        WHEN 'GROSS %' THEN (a.ytd_gm_aop / NULLIF(a.ytd_sales_aop, 0)) * 100
        WHEN 'EBITDA %' THEN (a.ytd_ebitda_aop / NULLIF(a.ytd_sales_aop, 0)) * 100
        WHEN 'EBIT %' THEN (a.ytd_ebit_aop / NULLIF(a.ytd_sales_aop, 0)) * 100
        WHEN 'EBT %' THEN (a.ytd_ebt_aop / NULLIF(a.ytd_sales_aop, 0)) * 100
    END AS "YTD AOP",

    COALESCE(
        CASE m.metric
            WHEN 'GROSS %' THEN (a.ytd_gm_ly / NULLIF(a.ytd_sales_ly, 0)) * 100
            WHEN 'EBITDA %' THEN (a.ytd_ebitda_ly / NULLIF(a.ytd_sales_ly, 0)) * 100
            WHEN 'EBIT %' THEN (a.ytd_ebit_ly / NULLIF(a.ytd_sales_ly, 0)) * 100
            WHEN 'EBT %' THEN (a.ytd_ebt_ly / NULLIF(a.ytd_sales_ly, 0)) * 100
        END, 0
    ) AS "LY Actual YTD",

    COALESCE(
        CASE m.metric
            WHEN 'GROSS %' THEN ((a.ytd_gm_actual / NULLIF(a.ytd_sales_actual, 0)) - (a.ytd_gm_aop / NULLIF(a.ytd_sales_aop, 0))) * 100
            WHEN 'EBITDA %' THEN ((a.ytd_ebitda_actual / NULLIF(a.ytd_sales_actual, 0)) - (a.ytd_ebitda_aop / NULLIF(a.ytd_sales_aop, 0))) * 100
            WHEN 'EBIT %' THEN ((a.ytd_ebit_actual / NULLIF(a.ytd_sales_actual, 0)) - (a.ytd_ebit_aop / NULLIF(a.ytd_sales_aop, 0))) * 100
            WHEN 'EBT %' THEN ((a.ytd_ebt_actual / NULLIF(a.ytd_sales_actual, 0)) - (a.ytd_ebt_aop / NULLIF(a.ytd_sales_aop, 0))) * 100
        END, 0
    ) AS "Variance vs AOP YTD",

    COALESCE(
        CASE m.metric
            WHEN 'GROSS %' THEN ((a.ytd_gm_actual / NULLIF(a.ytd_sales_actual, 0)) - (a.ytd_gm_ly / NULLIF(a.ytd_sales_ly, 0))) * 100
            WHEN 'EBITDA %' THEN ((a.ytd_ebitda_actual / NULLIF(a.ytd_sales_actual, 0)) - (a.ytd_ebitda_ly / NULLIF(a.ytd_sales_ly, 0))) * 100
            WHEN 'EBIT %' THEN ((a.ytd_ebit_actual / NULLIF(a.ytd_sales_actual, 0)) - (a.ytd_ebit_ly / NULLIF(a.ytd_sales_ly, 0))) * 100
            WHEN 'EBT %' THEN ((a.ytd_ebt_actual / NULLIF(a.ytd_sales_actual, 0)) - (a.ytd_ebt_ly / NULLIF(a.ytd_sales_ly, 0))) * 100
        END, 0
    ) AS "Variance vs LY YTD"

FROM aggregated a
CROSS JOIN metric_order m
ORDER BY m.sort_order;

```

```sql max_date_ytd_cons
SELECT 
    STRFTIME(MAX(date_my), '%b-%y') AS max_date_ytd_cons
FROM 
    income_statement
WHERE 
    STRFTIME(date_my, '%b-%y') != 'Feb-25';

```

```sql cons_inc_chart
WITH base_data AS (
  SELECT 
    metric AS Particulars,
    MAX(CASE WHEN entity = 'Global Green India' THEN TRY_CAST(period_value AS DOUBLE) END) AS India,
    MAX(CASE WHEN entity = 'Global Green Europe' THEN TRY_CAST(period_value AS DOUBLE) END) AS Europe
  FROM income_statement
  WHERE 
    entity IN ('Global Green India', 'Global Green Europe')
    AND metric IN ('Gross Margin', 'Variable Cost')
    AND metric_type = 'Actual'
    AND date_my = STRPTIME('${inputs.date_filter.value}', '%b-%y')
  GROUP BY metric
),

combined AS (
  SELECT 
    Particulars,
    India,
    Europe,
    COALESCE(India, 0) + COALESCE(Europe, 0) AS Consolidated
  FROM base_data

  UNION ALL

  SELECT 
    'Sales Revenue (Incl OI)' AS Particulars,
    SUM(CASE WHEN Particulars IN ('Gross Margin', 'Variable Cost') THEN India ELSE 0 END) AS India,
    SUM(CASE WHEN Particulars IN ('Gross Margin', 'Variable Cost') THEN Europe ELSE 0 END) AS Europe,
    SUM(CASE WHEN Particulars IN ('Gross Margin', 'Variable Cost') THEN COALESCE(India, 0) + COALESCE(Europe, 0) ELSE 0 END) AS Consolidated
  FROM base_data
)

SELECT * 
FROM combined
ORDER BY 
  CASE 
    WHEN Particulars = 'Sales Revenue (Incl OI)' THEN 0
    WHEN Particulars = 'Gross Margin' THEN 1
    WHEN Particulars = 'Variable Cost' THEN 2
    ELSE 99
  END;


```

```sql cons_ytd_inc
WITH base_data AS (
  SELECT 
    metric AS Particulars,
    entity,
    SUM(TRY_CAST(period_value AS DOUBLE)) AS value
  FROM income_statement
  WHERE 
    entity IN ('Global Green India', 'Global Green Europe')
    AND metric IN ('Gross Margin', 'Variable Cost')
    AND metric_type = 'Actual'
    AND EXTRACT(YEAR FROM date_my) = ${inputs.date_filter_ytd.value}::INT
  GROUP BY metric, entity
),

pivoted AS (
  SELECT 
    Particulars,
    SUM(CASE WHEN entity = 'Global Green India' THEN value ELSE 0 END) AS India,
    SUM(CASE WHEN entity = 'Global Green Europe' THEN value ELSE 0 END) AS Europe
  FROM base_data
  GROUP BY Particulars
),

combined AS (
  SELECT 
    Particulars,
    ROUND(India, 2) AS India,
    ROUND(Europe, 2) AS Europe,
    ROUND(COALESCE(India, 0) + COALESCE(Europe, 0), 2) AS Consolidated
  FROM pivoted

  UNION ALL

  SELECT 
    'Sales Revenue (Incl OI)' AS Particulars,
    ROUND(SUM(CASE WHEN Particulars IN ('Gross Margin', 'Variable Cost') THEN India ELSE 0 END), 2),
    ROUND(SUM(CASE WHEN Particulars IN ('Gross Margin', 'Variable Cost') THEN Europe ELSE 0 END), 2),
    ROUND(SUM(CASE WHEN Particulars IN ('Gross Margin', 'Variable Cost') THEN COALESCE(India, 0) + COALESCE(Europe, 0) ELSE 0 END), 2)
  FROM pivoted
)

SELECT *
FROM combined
ORDER BY 
  CASE 
    WHEN Particulars = 'Sales Revenue (Incl OI)' THEN 0
    WHEN Particulars = 'Gross Margin' THEN 1
    WHEN Particulars = 'Variable Cost' THEN 2
    ELSE 99
  END;

```

```sql selected_date_income
SELECT '${inputs.date_filter.value}' AS Selected_Date;
```

```sql selected_year_ytd
SELECT '${inputs.date_filter_ytd.value}' AS Selected_year
```
