<div class="relative">  
    <h1 class="text-lg m-0 font-bold">💰 Cash Flow </h1>
</div>

<ButtonGroup name="matric" display="tabs">
        <ButtonGroupItem valueLabel="Global Green India" value="GGCL" default />
        <ButtonGroupItem valueLabel="Global Green Europe" value="GGE" />
</ButtonGroup>

<div class="bg-gray-800 text-white p-6 shadow-lg rounded-lg mb-10">

        <!-- Display Comments Dynamically -->
        <Details title='Cash Flow Commentary' open = true>
            {#each comm as comment}
                <p class="text-gray-300 text-sm">
                    {inputs.matric === "GGCL" ? comment.global_green_india : comment.global_green_europe}
                </p>
            {/each}
        </Details>
    </div>

<DataTable data = {cash_flow} rowshadowing={true} headerFontColor=Bold headerColor=#FFD700 title="Values are in Million USD ($)">
<Column id = 'Particulars'/>
<Column id = 'Dec-23' fmt = '0.00'/>
<Column id = 'Dec-24' fmt = '0.00'/>
<Column id = 'Net Change' fmt = '0.00' contentType = 'delta'/>
</DataTable>


```sql cash_flow
SELECT 
    company_name,
    particular AS Particulars,
    MAX(CAST(NULLIF(TRIM(CASE WHEN period_date = 'Dec-23' THEN period_value END), '') AS DECIMAL(10,2))) AS "Dec-23",
    MAX(CAST(NULLIF(TRIM(CASE WHEN period_date = 'Dec-24' THEN period_value END), '') AS DECIMAL(10,2))) AS "Dec-24",
    
    -- Net Change = Dec-24 - Dec-23
    MAX(CAST(NULLIF(TRIM(CASE WHEN period_date = 'Dec-24' THEN period_value END), '') AS DOUBLE)) -
    MAX(CAST(NULLIF(TRIM(CASE WHEN period_date = 'Dec-23' THEN period_value END), '') AS DOUBLE)) AS "Net Change"

FROM 
    cashflow
WHERE 
    company_name = CASE '${inputs.matric}'
        WHEN 'GGCL' THEN 'Global Green India'
        WHEN 'GGE' THEN 'Global Green Europe'
    END
    AND period_date IN ('Dec-23', 'Dec-24')
GROUP BY 
    company_name, particular
```

```sql comm
SELECT DISTINCT global_green_india, global_green_europe 
FROM cashflow_comments
```

