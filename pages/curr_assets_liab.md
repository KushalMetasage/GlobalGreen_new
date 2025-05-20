<Grid cols = 2>

## Current Assets and Liabilities

<div class = "relative relative mb-5 mt-1">

<Dropdown data={date_filter} name=date_filter value=date_filter title="Year" defaultValue="2024" order = 'date_sort desc'>
</Dropdown>
</div>

</Grid>

<div class="flex items-center justify-between w-full">
<ButtonGroup name="matric" display="tabs">
        <ButtonGroupItem valueLabel="Global Green India" value="GGCL" default />
        <ButtonGroupItem valueLabel="Global Green Europe" value="GGE" />
</ButtonGroup>
</div>

<DataTable data={curr_assets_liab} groupsOpen={true} rowshadowing={true} headerFontColor="Bold"
headerColor="#FFD700" title="Values in Million USD ($)"
>

<Column id = "current_assets" title = "Current Assets" fmt = usd align = 'center'/>
<Column id = "current_liabilities" title = "Current Liabilities" fmt = usd align = 'center'/>
<Column id = "next_assets" title = "Next Assets" fmt = usd align = 'center'/>
<Column id = "next_liabilities" title = "Next Liabilities" fmt = usd align = 'center'/>
<Column id = "yoy_change" title = "YoY change" align = 'center' contentType = delta/>

</DataTable>


```sql date_filter
SELECT 
  STRFTIME(STRPTIME(bs.period_date, '%b-%y'), '%Y') AS date_filter,
  STRFTIME(STRPTIME(bs.period_date, '%b-%y'), '%Y') AS label,
  MAX(STRPTIME(bs.period_date, '%b-%y')) AS date_sort
FROM balance_sheet bs
GROUP BY date_filter
ORDER BY date_sort DESC;
```

```sql next_year_date
SELECT 
  CAST(CAST(${inputs.date_filter.value} AS INTEGER) + 1 AS TEXT) AS next_year_date
```

```sql curr_assets_liab
WITH params AS (
  SELECT
    '${inputs.date_filter.value}' AS selected_year,
    CAST('${inputs.date_filter.value}' AS INTEGER) + 1 AS next_year
),
current_year AS (
  SELECT
    bs.entity,
    bs.sub_category AS subcategory,
    bs.particulars,
    STRFTIME(STRPTIME(bs.period_date, '%b-%y'), '%Y') AS year_value,
    SUM(bs.period_value) AS current_value
  FROM balance_sheet bs, params
  WHERE STRFTIME(STRPTIME(bs.period_date, '%b-%y'), '%Y') = params.selected_year
    AND bs.entity = CASE '${inputs.matric}'
      WHEN 'GGCL' THEN 'Global Green India'
      WHEN 'GGE' THEN 'Global Green Europe'
    END
  GROUP BY bs.entity, bs.sub_category, bs.particulars, year_value
),
next_year AS (
  SELECT
    bs.entity,
    bs.sub_category,
    bs.particulars,
    STRFTIME(STRPTIME(bs.period_date, '%b-%y'), '%Y') AS year_value,
    SUM(bs.period_value) AS next_value
  FROM balance_sheet bs, params
  WHERE STRFTIME(STRPTIME(bs.period_date, '%b-%y'), '%Y') = CAST(params.next_year AS TEXT)
    AND bs.entity = CASE '${inputs.matric}'
      WHEN 'GGCL' THEN 'Global Green India'
      WHEN 'GGE' THEN 'Global Green Europe'
    END
  GROUP BY bs.entity, bs.sub_category, bs.particulars, year_value
),
merged AS (
  SELECT
    c.entity,
    c.subcategory,
    c.particulars,
    c.year_value,
    c.current_value,
    n.next_value
  FROM current_year c
  LEFT JOIN next_year n
    ON c.entity = n.entity
    AND c.subcategory = n.sub_category
    AND c.particulars = n.particulars
),
grouped AS (
  SELECT *,

    CASE 
      WHEN particulars IN (
        'Fixed Assets',
        'Investments',
        'Property',
        'Non-Current Assets',
        'Non-Current Assets-Investment in Subsidiary'
      ) THEN 'Non Current Assets'
      
      WHEN particulars IN (
        'Inventory',
        'Inventories',
        'Receivables',
        'Cash',
        'Cash and Bank Balances',
        'Loans and advances',
        'Sundry Debtors',
        'Other Current Assets'
      ) THEN 'Current Assets'
      
      WHEN particulars IN (
        'Equity Capital',
        'Reserves',
        'Retained Earnings',
        'Share Capital',
        'Reserve & Surplus'
      ) THEN 'Shareholders'' funds'
      
      WHEN particulars IN (
        'Long Term Loan',
        'Bonds Payable',
        'Other Long Liabilities',
        'Redeemable Preference Shares & Other liabilities'
      ) THEN 'Non Current Liabilities'
      
      WHEN particulars IN (
        'Short Term Loan',
        'Payables',
        'Tax Payable',
        'Bank Borrowings',
        'Other Current Liabilities & Provisions',
        'Trade Payables'
      ) THEN 'Current Liabilities'
      
      ELSE 'Unmapped'
    END AS subcategory_group
  FROM merged
),
pivoted AS (
  SELECT
    entity,
    year_value,
    MAX(CASE WHEN subcategory_group = 'Current Assets' THEN current_value END) AS current_assets,
    MAX(CASE WHEN subcategory_group = 'Current Liabilities' THEN current_value END) AS current_liabilities,
    MAX(CASE WHEN subcategory_group = 'Current Assets' THEN next_value END) AS next_assets,
    MAX(CASE WHEN subcategory_group = 'Current Liabilities' THEN next_value END) AS next_liabilities
  FROM grouped
  GROUP BY entity, year_value
)

SELECT
  entity,
  year_value,
  ROUND(current_assets, 2) AS current_assets,
  ROUND(current_liabilities, 2) AS current_liabilities,
  ROUND(current_assets / current_liabilities, 2) AS current_ratio,
  
  -- Show next year values only if available
  CASE WHEN next_assets IS NOT NULL THEN ROUND(next_assets, 2) ELSE NULL END AS next_assets,
  CASE WHEN next_liabilities IS NOT NULL THEN ROUND(next_liabilities, 2) ELSE NULL END AS next_liabilities,
  CASE 
    WHEN next_assets IS NOT NULL AND next_liabilities IS NOT NULL 
    THEN ROUND(next_assets / next_liabilities, 2) 
    ELSE NULL 
  END AS next_ratio,

 
CASE 
  WHEN next_assets IS NOT NULL AND next_liabilities IS NOT NULL THEN
    CASE 
      WHEN ABS((next_assets / next_liabilities) - (current_assets / current_liabilities)) < 0.005 
      THEN 'No change'
      ELSE CAST(ROUND((next_assets / next_liabilities) - (current_assets / current_liabilities), 2) AS TEXT)
    END
  ELSE NULL
END AS yoy_change

FROM pivoted;

```
