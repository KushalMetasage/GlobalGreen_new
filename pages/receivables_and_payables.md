<Grid cols = 3>

## Receivables and Payables

<div class = "relative relative mb-5 mt-1 ml-25">

<Dropdown data={date_filter} name=date_filter value=date_filter title="Month" defaultValue="Dec-24" order = 'date_sort desc'>
</Dropdown>

</div>

<div class= "relative mt-5 ml-30">
 <p class="text-sm text-grey ml-auto">
        📅 Last Updated: <Value data={max_date} />
    </p>
</div>

</Grid>


<DataTable data={receivables_and_payables}
  groupsOpen={true}
  rowshadowing={true}
  headerFontColor="Bold"
  headerColor="#FFD700"
  title="Values in Million USD ($)"
  >
 <Column id = "particulars"/>
 <Column id = "ggcl" title = "Global Green India" fmt=usd align="center"/>
 <Column id = "gge" title = "Global Green Europe" fmt=usd align="center"/>

</DataTable>


```sql date_filter
SELECT DISTINCT Date AS date_filter,
STRPTIME(Date, '%b-%y') AS date_sort
FROM financial_bs
WHERE TRIM(Date) IS NOT NULL
  AND TRIM(Date) <> ''
ORDER BY date_sort DESC;
```

```sql receivables_and_payables
SELECT
  Particulars,
  gge,
  ggcl
FROM
  financial_bs
WHERE
  LOWER(Particulars) IN ('dso', 'dpo')
  AND Date = '${inputs.date_filter.value}';

```

```sql max_date
SELECT 
    STRFTIME(MAX(STRPTIME(period_date, '%b-%y')), '%b-%y') AS max_date
FROM 
    balance_sheet;
```