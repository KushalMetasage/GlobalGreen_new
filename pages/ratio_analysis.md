<Grid cols = 3>

## Balance Sheet Ratio Analysis

<div class = "relative relative mb-5 mt-1 ml-25">

<Dropdown data={date_filter} name=date_filter value=date_filter title="Month" defaultValue="Dec-24" order = 'date_sort desc'>
</Dropdown>
</div>

<div class= "relative mt-5 ml-10">
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

<DataTable data={ratio_analysis_bs}
  rowshadowing={true}
  headerFontColor="Bold"
  headerColor="#FFD700"
  title="Values in Million USD ($)"
>
  <Column id="current_ratio" title="Current Ratio" fmt=usd align="center" />
  <Column id="working_capital" title="Working Capital" fmt=usd align="center" />
  <Column id="debt_to_equity" title="Debt-to-Equity" fmt=usd align="center" />
  <Column id="equity_ratio" title="Equity Ratio" fmt=usd align="center" />
</DataTable>


<Grid cols = 3>

## Income Statement Ratio Analysis

<div class = "relative relative mb-5 mt-1 ml-25">

<Dropdown data={date_filter_inc} name=date_filter_inc value=date_filter_inc title="Month" defaultValue="Dec-24" order = 'date_sort desc'>
</Dropdown>

</div>

<div class= "relative mt-5 ml-10">
 <p class="text-sm text-grey ml-auto">
        📅 Last Updated: <Value data={max_date_inc} />
    </p>
</div>

</Grid>

<div class="flex items-center justify-between w-full">
<ButtonGroup name="matric_inc" display="tabs">
        <ButtonGroupItem valueLabel="Global Green India" value="GGCL" default />
        <ButtonGroupItem valueLabel="Global Green Europe" value="GGE" />
</ButtonGroup>
</div>

<DataTable data={ratio_analysis_inc}
  rowshadowing={true}
  headerFontColor="Bold"
  headerColor="#FFD700"
>
  <Column id="gross_margin" title="Gross Margin" fmt='0.00"%"' align="center" />
  <Column id="ebitda_margin" title="EBITDA Margin" fmt='0.00"%"' align="center" />
  <Column id="ebit_margin" title="EBIT Margin" fmt='0.00"%"' align="center" />
  <Column id="net_margin" title="Net Profit Margin" fmt='0.00"%"' align="center" />
  <Column id="interest_coverage" title="Interest Coverage" fmt=usd align="center" />
</DataTable>


```sql date_filter
SELECT DISTINCT period_date AS date_filter,
STRPTIME(period_date, '%b-%y') AS date_sort
FROM balance_sheet
WHERE TRIM(period_date) IS NOT NULL
  AND TRIM(period_date) <> ''
ORDER BY date_sort DESC;
```
```sql date_filter_inc
SELECT DISTINCT period_date AS date_filter_inc,
STRPTIME(period_date, '%b-%y') AS date_sort
FROM income_statement
WHERE TRIM(period_date) IS NOT NULL
  AND TRIM(period_date) <> ''
  AND period_date!='Feb-25'
ORDER BY date_sort DESC;
```


```sql ratio_analysis_bs
WITH bs_filtered AS (
  SELECT *
  FROM balance_sheet
  WHERE entity = CASE '${inputs.matric}'
    WHEN 'GGCL' THEN 'Global Green India'
    WHEN 'GGE' THEN 'Global Green Europe'
  END
    AND period_date = '${inputs.date_filter.value}'
),
aggregated AS (
  SELECT
    -- Balance Sheet Metrics
    SUM(CASE WHEN particulars IN (
      'Cash and Bank Balances',
      'Inventories',
      'Other Current Assets',
      'Sundry Debtors',
      'Loans and advances'
    ) THEN period_value ELSE 0 END) AS current_assets,

    -- Handle different naming for current liabilities
    SUM(CASE 
      WHEN sub_category IN (
        'Current Liabilities', 
        'Current Liabilities and Provisions'
      ) THEN period_value ELSE 0 
    END) AS current_liabilities,

    -- Handle different naming for equity
    SUM(CASE 
      WHEN (
        (sub_category = 'Shareholders'' funds') OR
        (particulars IN ('Share Capital', 'Reserve & Surplus'))
      ) THEN period_value ELSE 0 
    END) AS equity,

    SUM(CASE WHEN particulars = 'Bank Borrowings' THEN period_value ELSE 0 END) AS borrowings,

    SUM(CASE WHEN particulars = 'Other Long Liabilities' THEN period_value ELSE 0 END) AS other_long_liabilities
  FROM bs_filtered
)

SELECT
  -- Liquidity Ratios
  current_assets / NULLIF(current_liabilities, 0) AS current_ratio,
  current_assets - current_liabilities AS working_capital,

  -- Solvency Ratios
  (borrowings + other_long_liabilities) / NULLIF(equity, 0) AS debt_to_equity,
  equity / NULLIF((equity + borrowings + other_long_liabilities), 0) AS equity_ratio
FROM aggregated;

```

```sql ratio_analysis_inc
WITH is_filtered AS (
  SELECT *
  FROM income_statement
  WHERE entity = CASE '${inputs.matric_inc}'
    WHEN 'GGCL' THEN 'Global Green India'
    WHEN 'GGE' THEN 'Global Green Europe'
  END
    AND period_date = '${inputs.date_filter_inc.value}'
    AND metric_type IN ('Actual', 'CY-25 ACT')  -- Allow both types of actuals
),
aggregated AS (
  SELECT
    MAX(CASE WHEN metric = 'Sales Revenue (Incl OI)' THEN period_value ELSE NULL END) AS revenue,
    MAX(CASE WHEN metric = 'Variable Cost' THEN period_value ELSE NULL END) AS variable_cost,
    MAX(CASE WHEN metric = 'EBITDA' THEN period_value ELSE NULL END) AS ebitda,
    MAX(CASE WHEN metric = 'EBIT' THEN period_value ELSE NULL END) AS ebit,
    MAX(CASE WHEN metric = 'Interest Expenses' THEN period_value ELSE NULL END) AS interest_expenses,
    MAX(CASE WHEN metric = 'PBT - (from operations)' THEN period_value ELSE NULL END) AS net_profit
  FROM is_filtered
)

SELECT
  -- Profitability Ratios
  (revenue - variable_cost) / NULLIF(revenue, 0) AS gross_margin,
  ebitda / NULLIF(revenue, 0) AS ebitda_margin,
  ebit / NULLIF(revenue, 0) AS ebit_margin,
  net_profit / NULLIF(revenue, 0) AS net_margin,

  -- Coverage Ratio
  ebit / NULLIF(interest_expenses, 0) AS interest_coverage
FROM aggregated;

```

```sql max_date
SELECT 
    STRFTIME(MAX(STRPTIME(period_date, '%b-%y')), '%b-%y') AS max_date
FROM 
    balance_sheet;
```

```sql max_date_inc
SELECT 
    STRFTIME(MAX(STRPTIME(period_date, '%b-%y')), '%b-%y') AS max_date
FROM 
    income_statement;
  WHERE period_date!='Feb-25'
```