

<div class="flex items-center justify-between w-full">
<ButtonGroup name="matric" display="tabs">
        <ButtonGroupItem valueLabel="Global Green India" value="GGCL" default />
        <ButtonGroupItem valueLabel="Global Green Europe" value="GGE" />
</ButtonGroup>
</div>

<Grid cols = 2>

## 💵 Current Assets and Liabilities

<Dropdown data={date_filter_bs} name=date_filter_bs value=date_filter_bs title="Year" defaultValue="2024" order = 'date_sort desc'>
</Dropdown>

</Grid>

<div class = 'mb-5'> </div>

<Grid cols = 2>

<LineChart 
  data={sel_year_curr_assets}
  x="month"                            
  y="total_current_assets"
  markers={true}
  title="Current Assets"
  yAxisTitle="Values are in Million"
  tooltipTitle="month_label"
  xFmt = "mmm-yy"
  yFmt="0"
/>




<LineChart 
  data={sel_year_curr_liab}
  x="month"
  y="total_current_liabilities"
  markers={true}
  title="Current Liabilities"
  yAxisTitle="Values are in Million"
  sort={true}
  xFmt="mmm-yy"
  yFmt="0"
/>



</Grid>

<Grid cols = 2>

## 📦 Efficiency Metrics


<Dropdown data={date_filter_inc} name=date_filter_inc value=date_filter_inc title="Year" defaultValue="2024" order = 'date_sort desc'>
</Dropdown>


</Grid>

<div class = 'mb-5'> </div>

<Grid cols = 2>

<LineChart 
  data={sel_year_dso}
  x="month"                    
  y="dso"                            
  markers={true}
  yAxisTitle="Values are in Million"
  title="DSO"
  sort={true}
  xFmt="mmm-yy"
  yFmt="0"
  labelFmt="0"
  tooltipFmt="0" 
/>

<LineChart 
  data={sel_year_dpo}
  x="month"
  y="dpo"
  markers={true}
  title="DPO"
  yAxisTitle="Values are in Million"
  sort={true}
  xFmt="mmm-yy"
  yFmt="0"
  tooltipTitle="month_label"
/>


</Grid>

## 📤 Trade Payables
<div class = 'mb-5'></div>

<LineChart 
  data={sel_year_trade_payable}
  x="month"                          
  y="trade_payables"                       
  markers={true}
  yAxisTitle="Values are in Million"
  sort={true}
  xFmt="mmm-yy"
  yFmt="0"
  tooltipTitle="month_label"
/>


<div class = mb-15> </div>


```sql date_filter_inc
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
        END AS date_filter_inc,

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
        date_filter_inc,
        date_sort,
        month_num,
        month_label
    FROM calendar_years
    WHERE date_filter_inc IS NOT NULL
),

aggregated_calendar AS (
    SELECT 
        date_filter_inc,
        date_sort,
        STRING_AGG(month_label ORDER BY month_num) AS months_included
    FROM calendar_labels
    GROUP BY date_filter_inc, date_sort
)

SELECT 
    date_filter_inc,
    date_sort,
    months_included
FROM 
    aggregated_calendar
ORDER BY 
    date_sort DESC;

```

```sql date_filter_bs
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
        END AS date_filter_bs,

        CASE 
            WHEN EXTRACT(YEAR FROM date_my) = 2019 AND EXTRACT(MONTH FROM date_my) BETWEEN 4 AND 12 THEN DATE '2019-01-01'
            ELSE DATE_TRUNC('year', date_my)
        END AS date_sort,

        EXTRACT(MONTH FROM date_my) AS month_num,
        STRFTIME(date_my, '%b-%y') AS month_label
    FROM balance_sheet
    WHERE date_my IS NOT NULL
),

calendar_labels AS (
    SELECT DISTINCT
        date_filter_bs,
        date_sort,
        month_num,
        month_label
    FROM calendar_years
    WHERE date_filter_bs IS NOT NULL
),

aggregated_calendar AS (
    SELECT 
        date_filter_bs,
        date_sort,
        STRING_AGG(month_label ORDER BY month_num) AS months_included
    FROM calendar_labels
    GROUP BY date_filter_bs, date_sort
)

SELECT 
    date_filter_bs,
    date_sort,
    months_included
FROM 
    aggregated_calendar
ORDER BY 
    date_sort DESC;

```

```sql sel_year_trade_payable
WITH base AS (
    SELECT 
        entity,
        date_my AS month,
        EXTRACT(YEAR FROM date_my) AS year,
        EXTRACT(MONTH FROM date_my) AS month_num,
        STRFTIME(date_my, '%b-%y') AS month_label,
        period_value AS trade_payables
    FROM income_statement
    WHERE 
        metric = 'Trade Payables'
        AND entity = CASE '${inputs.matric}'
            WHEN 'GGCL' THEN 'Global Green India'
            WHEN 'GGE' THEN 'Global Green Europe'
        END
        AND month IS NOT NULL
),

filtered AS (
    SELECT 
        month_label,
        month,
        CAST(month_num AS INTEGER) AS month_sort,
        ROUND(SUM(trade_payables), 0) AS trade_payables
    FROM base
    WHERE year = CAST('${inputs.date_filter_inc.value}' AS INTEGER)
    GROUP BY month_label, month_sort, month
)

SELECT 
    month_label,
    month,
    month_sort,
    'Trade Payables' AS Particulars,
    trade_payables
FROM filtered
ORDER BY month_sort;

```

```sql sel_year_dso
WITH base AS (
    SELECT 
        entity,
        date_my AS month,
        EXTRACT(YEAR FROM date_my) AS year,
        EXTRACT(MONTH FROM date_my) AS month_num,
        STRFTIME(date_my, '%b-%y') AS month_label,
        period_value AS dso
    FROM income_statement
    WHERE 
        metric = 'DSO'
        AND entity = CASE '${inputs.matric}'
            WHEN 'GGCL' THEN 'Global Green India'
            WHEN 'GGE' THEN 'Global Green Europe'
        END
        AND month IS NOT NULL
),

filtered AS (
    SELECT 
        month_label, month,
        CAST(month_num AS INTEGER) AS month_sort,
        ROUND(SUM(dso), 0) AS dso
    FROM base
    WHERE year = CAST('${inputs.date_filter_inc.value}' AS INTEGER)
    GROUP BY month_label, month_sort, month
    HAVING ROUND(SUM(dso), 0) != 0  
)

SELECT 
    month_label,
    month,
    month_sort,
    'DSO' AS Particulars,
    dso
FROM filtered
ORDER BY month_sort;


```

```sql sel_year_dpo
WITH base AS (
    SELECT 
        entity,
        date_my AS month,
        EXTRACT(YEAR FROM date_my) AS year,
        EXTRACT(MONTH FROM date_my) AS month_num,
        STRFTIME(date_my, '%b-%y') AS month_label,
        period_value AS dpo
    FROM income_statement
    WHERE 
        metric = 'DPO'
        AND entity = CASE '${inputs.matric}'
            WHEN 'GGCL' THEN 'Global Green India'
            WHEN 'GGE' THEN 'Global Green Europe'
        END
        AND month IS NOT NULL
),

filtered AS (
    SELECT 
        month_label,
        month,
        CAST(month_num AS INTEGER) AS month_sort,
        ROUND(SUM(dpo), 0) AS dpo
    FROM base
    WHERE year = CAST('${inputs.date_filter_inc.value}' AS INTEGER)
    GROUP BY month_label, month_sort, month
    HAVING ROUND(SUM(dpo), 0) != 0
)

SELECT 
    month_label,
    month,
    month_sort,
    'DPO' AS Particulars,
    dpo
FROM filtered
ORDER BY month_sort;

```
```sql sel_year_curr_assets
WITH base AS (
  SELECT
    bs.entity,
    bs.sub_category AS subcategory,
    bs.particulars,
    STRPTIME(bs.period_date, '%b-%y') AS month,
    STRFTIME(STRPTIME(bs.period_date, '%b-%y'), '%Y') AS year,
    STRFTIME(STRPTIME(bs.period_date, '%b-%y'), '%b-%y') AS month_label,
    SUM(bs.period_value) AS current_value
  FROM balance_sheet bs
  WHERE bs.entity = CASE '${inputs.matric}'
    WHEN 'GGCL' THEN 'Global Green India'
    WHEN 'GGE' THEN 'Global Green Europe'
  END
  GROUP BY bs.entity, bs.sub_category, bs.particulars, month, year, month_label
),

grouped AS (
  SELECT *,
    CASE 
      WHEN particulars IN (
        'Inventory', 'Inventories', 'Receivables', 'Cash', 'Cash and Bank Balances',
        'Loans and advances', 'Sundry Debtors', 'Other Current Assets'
      ) THEN 'Current Assets'
      ELSE 'Other'
    END AS subcategory_group
  FROM base
),

filtered AS (
  SELECT *
  FROM grouped
  WHERE 
    subcategory_group = 'Current Assets'
    AND year = '${inputs.date_filter_bs.value}'
)

SELECT
  entity,
  month,
  month_label,
  ROUND(SUM(current_value), 2) AS total_current_assets
FROM filtered
GROUP BY entity, month, month_label
ORDER BY entity, month, month_label;

```

```sql sel_year_curr_liab
WITH current_year AS (
  SELECT
    bs.entity,
    bs.sub_category AS subcategory,
    bs.particulars,
    STRPTIME(bs.period_date, '%b-%y') AS month,
    STRFTIME(STRPTIME(bs.period_date, '%b-%y'), '%Y') AS year_value,
    STRFTIME(STRPTIME(bs.period_date, '%b-%y'), '%m') AS month_number,
    -- STRFTIME(STRPTIME(bs.period_date, '%b-%y'), '%b-%y') AS month_label,
    STRPTIME(bs.period_date, '%b-%y') AS date_sort,
    SUM(bs.period_value) AS current_value
  FROM balance_sheet bs
  WHERE bs.entity = CASE '${inputs.matric}'
    WHEN 'GGCL' THEN 'Global Green India'
    WHEN 'GGE' THEN 'Global Green Europe'
  END
  GROUP BY bs.entity, bs.sub_category, bs.particulars, month, year_value, month_number,date_sort
),

grouped AS (
  SELECT *,
    CASE 
      WHEN particulars IN (
        'Short Term Loan', 'Payables', 'Tax Payable', 'Bank Borrowings',
        'Other Current Liabilities & Provisions', 'Trade Payables'
      ) THEN 'Current Liabilities'
      ELSE 'Other'
    END AS subcategory_group
  FROM current_year
),

filtered AS (
  SELECT *
  FROM grouped
  WHERE 
    subcategory_group = 'Current Liabilities'
    AND year_value = '${inputs.date_filter_bs.value}'
)

SELECT
  entity,
  year_value,
  month,
  -- month_label,
  date_sort,
  ROUND(SUM(current_value), 2) AS total_current_liabilities
FROM filtered
GROUP BY entity, year_value, month,date_sort
ORDER BY entity, date_sort;

```