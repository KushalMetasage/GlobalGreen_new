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
<Column id = 'Dec-23' fmt = '$0.00'/>
<Column id = 'Dec-24' fmt = '$0.00'/>
<Column id = 'Net Change' fmt = '$0.00' contentType = 'delta'/>
</DataTable>

<!-- <ButtonGroup name="period_button" display="tabs">
        <ButtonGroupItem valueLabel="Dec-23" value="Dec-23" default />
        <ButtonGroupItem valueLabel="Dec-24" value="Dec-24" />
</ButtonGroup> -->


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

<!-- ```sql date_pie
SELECT 
  company_name,
  particular,
  period_date,
  CAST(NULLIF(TRIM(period_value), '') AS DECIMAL(10,2)) AS value
FROM 
  cashflow
WHERE 
  company_name = CASE '${inputs.matric}'
    WHEN 'GGCL' THEN 'Global Green India'
    WHEN 'GGE' THEN 'Global Green Europe'
  END
  AND period_date = '${inputs.period_button}'
ORDER BY 
  particular

``` -->

```sql comm
SELECT DISTINCT global_green_india, global_green_europe 
FROM cashflow_comments
```

<!--
```sql pie_query
SELECT 
  particular AS pie,
  MAX(CAST(NULLIF(TRIM(period_value), '') AS DECIMAL(10,2))) AS count
FROM 
  cashflow
WHERE 
  company_name = CASE '${inputs.matric}'
    WHEN 'GGCL' THEN 'Global Green India'
    WHEN 'GGE' THEN 'Global Green Europe'
  END
  AND period_date = '${inputs.period_button}'
GROUP BY 
  particular
```

```sql pie_data
SELECT 
  pie AS name, 
  count AS raw_value,
  ABS(count) AS value  -- use absolute value for pie chart size
FROM ${pie_query}
```

<ECharts config={{
  title: {
    text: `Cash Flow - ${inputs.period_button} (${inputs.matric === 'GGCL' ? 'India' : 'Europe'})`,
    left: 'center',
    top: 10, // position title 10px from top
    textStyle: {
      fontSize: 16,
      fontWeight: 'bold'
    }
  },
  tooltip: {
    formatter: (params) => {
      const { name, data } = params;
      return `${name}: ${data.raw_value} (${params.percent}%)`;
    }
  },
  series: [
    {
      type: 'pie',
      data: [...pie_data],
      encode: {
        value: 'value',
        tooltip: ['raw_value']
      },
      radius: '60%', // optional: size of pie
      center: ['50%', '60%'], // shift chart down to create margin
      label: {
        show: true,
        formatter: '{b}',
        overflow: 'break',
        minAngle: 2
      },
      labelLine: {
        length: 15,
        length2: 10
      }
    }
  ]
}} />

-->

