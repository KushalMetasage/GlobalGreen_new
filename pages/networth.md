<Grid cols = 3>

## 💼Net Worth

<div class = "relative relative mb-5 mt-1">

<Dropdown data={date_filter} name=date_filter value=date_filter title="Start" defaultValue="Dec-23" order = 'date_sort desc'>
</Dropdown>

<Dropdown data={next_year_date} name=next_year_date value=next_year_date title="End" defaultValue="Dec-24">
</Dropdown>

</div>

<div class= "relative mt-5 ml-30">
 <p class="text-sm text-grey ml-auto">
        📅 Last Updated: <Value data={max_date} />
    </p>
</div>
</Grid>

<div class="flex items-center justify-between w-full">
<ButtonGroup name="matric" display="tabs">
        <ButtonGroupItem valueLabel="Global Green India" value="GGCL" default />
        <ButtonGroupItem valueLabel="Global Green Europe" value="GGE" />
</ButtonGroup>
</div>


<DataTable data={net_worth} groupBy="subcategory" subtotals={true} 
    totalRow={true}
    groupsOpen={true}
    totalLabel="Total"
    rowshadowing={true}
    headerFontColor="Bold"
    headerColor="#FFD700"
    title="Net Worth (Shareholders' Funds) – Values are in Million USD ($)">

  <Column id="subcategory" totalFmt="Total" totalAgg="" subtotalFmt="@value" />
  <Column id="particulars" totalFmt='0 "Line Items"' totalAgg="" />
  <Column id="current_value" title="{inputs.date_filter.value}" fmt="$0.00" totalAgg="sum" subtotalAgg="sum" />
  <Column id="next_year_value" title="{inputs.next_year_date.value}" fmt="$0.00" totalAgg="sum" subtotalAgg="sum" />
  <Column id="variance" fmt="$0.00" contentType="delta" totalAgg="sum" subtotalAgg="sum" />

</DataTable>


<Grid cols = 3>

## 💼Consolidated Net Worth

<div class = "relative relative mb-5 mt-1">

<Dropdown data={date_filter_cons} name=date_filter_cons value=date_filter_cons title="Start" defaultValue="Dec-23" order = 'date_sort desc'>
</Dropdown>

<Dropdown data={next_year_date_cons} name=next_year_date_cons value=next_year_date_cons title="End" defaultValue="Dec-24">
</Dropdown>

</div>

<div class= "relative mt-5 ml-30">
 <p class="text-sm text-grey ml-auto">
        📅 Last Updated: <Value data={max_date} />
    </p>
</div>

</Grid>

<DataTable data={net_worth_cons} groupBy="subcategory" subtotals={true} 
    totalRow={true}
    groupsOpen={true}
    totalLabel="Total"
    rowshadowing={true}
    headerFontColor="Bold"
    headerColor="#FFD700"
    title="Net Worth (Shareholders' Funds) – Values are in Million USD ($)">

  <Column id="subcategory" totalFmt="Total" totalAgg="" subtotalFmt="@value" />
  <Column id="particulars" totalFmt='0 "Line Items"' totalAgg="" />
  <Column id="current_value" title="{inputs.date_filter_cons.value}" fmt="$0.00" totalAgg="sum" subtotalAgg="sum" />
  <Column id="next_year_value" title="{inputs.next_year_date_cons.value}" fmt="$0.00" totalAgg="sum" subtotalAgg="sum" />
  <Column id="variance" fmt="$0.00" contentType="delta" totalAgg="sum" subtotalAgg="sum" />

</DataTable>


```sql date_filter
SELECT 
  bs.period_date AS date_filter,
  STRPTIME(bs.period_date, '%b-%y') AS date_sort
FROM balance_sheet bs
WHERE EXISTS (
  SELECT 1
  FROM balance_sheet bs_next
  WHERE STRPTIME(bs_next.period_date, '%b-%y') = STRPTIME(bs.period_date, '%b-%y') + INTERVAL 1 year
)
GROUP BY ALL
ORDER BY date_sort DESC;
```

```sql date_filter_cons
SELECT 
  bs.period_date AS date_filter_cons,
  STRPTIME(bs.period_date, '%b-%y') AS date_sort
FROM balance_sheet bs
WHERE EXISTS (
  SELECT 1
  FROM balance_sheet bs_next
  WHERE STRPTIME(bs_next.period_date, '%b-%y') = STRPTIME(bs.period_date, '%b-%y') + INTERVAL 1 year
)
GROUP BY ALL
ORDER BY date_sort DESC;
```

```sql next_year_date
SELECT 
  bs.period_date AS next_year_date,
  STRPTIME(bs.period_date, '%b-%y') AS date_sort
FROM balance_sheet bs
WHERE bs.period_date = STRFTIME(
  STRPTIME('${inputs.date_filter.value}', '%b-%y') + INTERVAL 1 year, '%b-%y'
)
GROUP BY ALL
```

```sql next_year_date_cons
SELECT 
  bs.period_date AS next_year_date_cons,
  STRPTIME(bs.period_date, '%b-%y') AS date_sort
FROM balance_sheet bs
WHERE bs.period_date = STRFTIME(
  STRPTIME('${inputs.date_filter_cons.value}', '%b-%y') + INTERVAL 1 year, '%b-%y'
)
GROUP BY ALL
```

```sql net_worth
WITH current_year AS (
  SELECT
    entity,
    sub_category AS subcategory,
    particulars,
    period_date AS current_year_date,
    STRPTIME(period_date, '%b-%y') AS parsed_date,
    period_value AS current_value
  FROM balance_sheet
  WHERE entity = CASE '${inputs.matric}'
    WHEN 'GGCL' THEN 'Global Green India'
    WHEN 'GGE' THEN 'Global Green Europe'
  END
  AND period_date = '${inputs.date_filter.value}'
),
next_year AS (
  SELECT
    entity,
    sub_category,
    particulars,
    period_date AS next_year_date,
    STRPTIME(period_date, '%b-%y') AS parsed_date,
    period_value AS next_year_value
  FROM balance_sheet
  WHERE entity = CASE '${inputs.matric}'
    WHEN 'GGCL' THEN 'Global Green India'
    WHEN 'GGE' THEN 'Global Green Europe'
  END
  AND period_date = '${inputs.next_year_date.value}'  
),
merged AS (
  SELECT
    c.entity,
    c.subcategory,
    c.particulars,
    c.current_year_date,
    n.next_year_date,
    c.current_value,
    n.next_year_value,
    (n.next_year_value - c.current_value) AS variance
  FROM current_year c
  LEFT JOIN next_year n
    ON c.subcategory = n.sub_category
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
        'Reserve & Surplus',
        'Shareholders'' funds'  
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
)

SELECT
  subcategory_group,
  subcategory,
  particulars,
  current_year_date,
  next_year_date,
  current_value,
  next_year_value,
  variance
FROM grouped
WHERE subcategory_group = 'Shareholders'' funds'
ORDER BY subcategory, particulars;

```

```sql net_worth_cons
WITH current_year AS (
  SELECT
    entity,
    sub_category AS subcategory,
    particulars,
    period_date AS current_year_date,
    STRPTIME(period_date, '%b-%y') AS parsed_date,
    period_value AS current_value
  FROM balance_sheet
  WHERE period_date = '${inputs.date_filter_cons.value}'
    AND particulars IN (
      'Equity Capital',
      'Reserves',
      'Retained Earnings',
      'Share Capital',
      'Reserve & Surplus',
      'Shareholders'' funds'
    )
),
next_year AS (
  SELECT
    entity,
    sub_category,
    particulars,
    period_date AS next_year_date,
    STRPTIME(period_date, '%b-%y') AS parsed_date,
    period_value AS next_year_value
  FROM balance_sheet
  WHERE period_date = '${inputs.next_year_date_cons.value}'  
    AND particulars IN (
      'Equity Capital',
      'Reserves',
      'Retained Earnings',
      'Share Capital',
      'Reserve & Surplus',
      'Shareholders'' funds'
    )
),
merged AS (
  SELECT
    c.subcategory,
    c.particulars,
    c.current_year_date,
    n.next_year_date,
    SUM(c.current_value) AS current_value,
    SUM(n.next_year_value) AS next_year_value,
    SUM(n.next_year_value - c.current_value) AS variance
  FROM current_year c
  LEFT JOIN next_year n
    ON c.particulars = n.particulars  
  GROUP BY c.subcategory, c.particulars, c.current_year_date, n.next_year_date
)

SELECT
  'Shareholders'' funds' AS subcategory_group,
  subcategory,
  particulars,
  current_year_date,
  next_year_date,
  current_value,
  next_year_value,
  variance
FROM merged
ORDER BY subcategory, particulars;

```

```sql max_date
SELECT 
    STRFTIME(MAX(STRPTIME(period_date, '%b-%y')), '%b-%y') AS max_date
FROM 
    balance_sheet;
```
