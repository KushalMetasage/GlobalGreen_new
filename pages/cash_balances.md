<Grid cols = 3>

## Cash Balances Monthly

<div class = "relative mt-1 ml-40">
<Dropdown data={date_filter} name=date_filter value=date_filter title="Month" defaultValue="Dec-24" order = 'date_sort desc'>
</Dropdown>
</div>

<div class= "relative mt-5 ml-32">
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

<DataTable data={cash_bal_mon}
  rowshadowing={true}
  headerFontColor="Bold"
  headerColor="#FFD700"
  title = "Values are in Million USD ($)"
>
<Column id = "cash_balance" Title = "Cash Balance" fmt = '$0.00' align='center'/>
</DataTable>


<Grid cols = 2>

## Cash Balances Yearly

<div class = "relative mt-1">
<Dropdown data={date_filter_yearly} name=date_filter_yearly value=date_filter_yearly title="Year" defaultValue="2024" order = 'date_sort desc'>
</Dropdown>
</div>

</Grid>

<div class="flex items-center justify-between w-full">
<ButtonGroup name="matric_yearly" display="tabs">
        <ButtonGroupItem valueLabel="Global Green India" value="GGCL" default />
        <ButtonGroupItem valueLabel="Global Green Europe" value="GGE" />
</ButtonGroup>
</div>

<DataTable data={cash_bal_yearly}
  rowshadowing={true}
  headerFontColor="Bold"
  headerColor="#FFD700"
  title = "Values are in Million USD ($)"
>
<Column id = "cash_balance" Title = "Cash Balance" fmt = '$0.00' align='center'/>
</DataTable>

```sql date_filter
SELECT DISTINCT 
  period_date AS date_filter,
  STRPTIME(period_date, '%b-%y') AS date_sort
FROM income_statement
WHERE 
  TRIM(period_date) IS NOT NULL
  AND TRIM(period_date) <> ''
  AND period_date != 'Feb-25' 
  AND period_date != 'Jan-25' 
ORDER BY date_sort DESC;

```

```sql date_filter_yearly
SELECT DISTINCT 
  '20' || RIGHT(period_date, 2) AS date_filter_yearly,
  CAST('20' || RIGHT(period_date, 2) AS INTEGER) AS date_sort
FROM income_statement
WHERE 
  TRIM(period_date) IS NOT NULL
  AND TRIM(period_date) <> ''
  AND period_date NOT IN ('Feb-25', 'Jan-25')
ORDER BY date_sort DESC;
```


```sql cash_bal_mon
SELECT
  period_date,
  entity,
  SUM(period_value) AS cash_balance
FROM balance_sheet
WHERE particulars = 'Cash and Bank Balances'
AND period_date = '${inputs.date_filter.value}'
AND entity = CASE '${inputs.matric}'
    WHEN 'GGCL' THEN 'Global Green India'
    WHEN 'GGE' THEN 'Global Green Europe'
  END
GROUP BY entity, period_date
ORDER BY entity, period_date;
```

```sql cash_bal_yearly
SELECT
  entity,
  '20' || RIGHT(period_date, 2) AS year,
  SUM(period_value) AS cash_balance
FROM balance_sheet
WHERE particulars = 'Cash and Bank Balances'
  AND '20' || RIGHT(period_date, 2) = '${inputs.date_filter_yearly.value}'
  AND entity = CASE '${inputs.matric_yearly}'
    WHEN 'GGCL' THEN 'Global Green India'
    WHEN 'GGE' THEN 'Global Green Europe'
  END
GROUP BY entity, year
ORDER BY entity, year;

```

```sql max_date
SELECT 
    STRFTIME(MAX(STRPTIME(period_date, '%b-%y')), '%b-%y') AS max_date
FROM 
    balance_sheet;
```