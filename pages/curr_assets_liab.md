
## Current Assets and Liabilities


<div class="flex items-center justify-between w-full">
<ButtonGroup name="matric" display="tabs">
        <ButtonGroupItem valueLabel="Global Green India" value="GGCL" default />
        <ButtonGroupItem valueLabel="Global Green Europe" value="GGE" />
</ButtonGroup>
</div>

## Current Assets
<div class = 'mb-5'></div>

<LineChart 
  data={curr_assets}
  x="month"                           
  y="total_current_assets"
  markers={true}
  sort={true}
  title = "Values are in Million USD ($)"
  xFmt="mmm-yy"                       
  tooltipTitle="month_label"         
/>

## Current Liabilities
<div class = 'mb-5'></div>

<LineChart 
  data={curr_liab}
  x="month"
  y="total_current_liabilities"
  markers={true}
  title = "Values are in Million USD ($)"
  sort={true}
  xFmt="mmm-yy"
/>

## Trade Payables
<div class = 'mb-5'></div>

<LineChart 
  data={trade_payables}
  x="month"                         
  y="value"                        
  markers={true}
  title = "Values are in Million USD ($)"
  sort={true}
  xFmt="mmm-yy"
/>

## DSO
<div class = 'mb-5'></div>

<LineChart 
  data={dso}
  y="value"                        
  markers={true}
  title = "Values are in Million USD ($)"
  sort={true}
  xFmt="mmm-yy"
/>

## DPO
<div class = 'mb-5'></div>

<LineChart 
  data={dpo}
  y="value"                        
  markers={true}
  title = "Values are in Million USD ($)"
  sort={true}
  xFmt="mmm-yy"
/>


```sql date_filter
SELECT 
  STRFTIME(STRPTIME(bs.period_date, '%b-%y'), '%Y-%m') AS date_filter,
  STRFTIME(STRPTIME(bs.period_date, '%b-%y'), '%b-%y') AS label,
  STRPTIME(bs.period_date, '%b-%y') AS date_sort
FROM balance_sheet bs
GROUP BY date_filter, label,period_date
ORDER BY date_sort ASC;
```


```sql curr_assets
WITH base AS (
  SELECT
    bs.entity,
    bs.sub_category AS subcategory,
    bs.particulars,
    STRPTIME(bs.period_date, '%b-%y') AS month,                                
    STRFTIME(STRPTIME(bs.period_date, '%b-%y'), '%b-%y') AS month_label,       
    SUM(bs.period_value) AS current_value
  FROM balance_sheet bs
  WHERE bs.entity = CASE '${inputs.matric}'
    WHEN 'GGCL' THEN 'Global Green India'
    WHEN 'GGE' THEN 'Global Green Europe'
  END
  GROUP BY bs.entity, bs.sub_category, bs.particulars, month, month_label
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
  SELECT * FROM grouped WHERE subcategory_group = 'Current Assets'
)

SELECT
  entity,
  month,
  month_label,
  ROUND(SUM(current_value), 2) AS total_current_assets
FROM filtered
GROUP BY entity, month, month_label
ORDER BY entity, month;


```

```sql curr_liab

WITH current_year AS (
  SELECT
    bs.entity,
    bs.sub_category AS subcategory,
    bs.particulars,
    STRPTIME(bs.period_date, '%b-%y') AS month,                                 
    STRFTIME(STRPTIME(bs.period_date, '%b-%y'), '%Y') AS year_value,
    STRFTIME(STRPTIME(bs.period_date, '%b-%y'), '%m') AS month_number,
    STRFTIME(STRPTIME(bs.period_date, '%b-%y'), '%b-%y') AS month_label,
    STRPTIME(bs.period_date, '%b-%y') AS date_sort,
    SUM(bs.period_value) AS current_value
  FROM balance_sheet bs
  WHERE bs.entity = CASE '${inputs.matric}'
    WHEN 'GGCL' THEN 'Global Green India'
    WHEN 'GGE' THEN 'Global Green Europe'
  END
  GROUP BY bs.entity, bs.sub_category, bs.particulars, month, year_value, month_number, month_label, date_sort
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
  SELECT * FROM grouped WHERE subcategory_group = 'Current Liabilities'
)

SELECT
  entity,
  year_value,
  month,
  month_label,
  date_sort,
  ROUND(SUM(current_value), 2) AS total_current_liabilities
FROM filtered
GROUP BY entity, year_value, month, month_label, date_sort
ORDER BY entity, date_sort;

```

```sql trade_payables
SELECT
  STRPTIME(Date, '%b-%y') AS month,
  STRFTIME(STRPTIME(Date, '%b-%y'), '%b-%y') AS month_label,
  'Trade Payables' AS Particulars,
  CASE '${inputs.matric}'
    WHEN 'GGCL' THEN ggcl
    WHEN 'GGE' THEN gge
  END AS value
FROM financial_bs
WHERE Particulars = 'Trade Payables'

```

```sql dso
SELECT
  STRPTIME(Date, '%b-%y') AS month,
  STRFTIME(STRPTIME(Date, '%b-%y'), '%b-%y') AS month_label,
  'Trade Payables' AS Particulars,
  CASE '${inputs.matric}'
    WHEN 'GGCL' THEN ggcl
    WHEN 'GGE' THEN gge
  END AS value
FROM financial_bs
WHERE 
  Particulars = 'DSO'
  AND CASE '${inputs.matric}'
    WHEN 'GGCL' THEN ggcl
    WHEN 'GGE' THEN gge
  END != 0

```

```sql dpo
SELECT
  STRPTIME(Date, '%b-%y') AS month,
  STRFTIME(STRPTIME(Date, '%b-%y'), '%b-%y') AS month_label,
  'Trade Payables' AS Particulars,
  CASE '${inputs.matric}'
    WHEN 'GGCL' THEN ggcl
    WHEN 'GGE' THEN gge
  END AS value
FROM financial_bs
WHERE 
  Particulars = 'DPO'
  AND CASE '${inputs.matric}'
    WHEN 'GGCL' THEN ggcl
    WHEN 'GGE' THEN gge
  END != 0

```
