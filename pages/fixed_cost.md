<Grid cols = 3>

## 🧾 Fixed Cost

<div class = "relative relative mb-5 mt-1 ml-20">
<Dropdown data={date_filter} name=date_filter value=date_filter title="Month" defaultValue="Jan-25" order = 'date_sort desc'>
</Dropdown>
</div>

<div class = "relative mt-5 ml-25">
 <p class="text-sm text-grey ml-auto">
        📅 Last Updated: <Value data={max_fixed_cost_date} />
    </p>
</div>

</Grid>



<div class="flex items-center justify-between w-full">
<ButtonGroup name="matric" display="tabs">
        <ButtonGroupItem valueLabel="Global Green India" value="GGCL" default />
        <ButtonGroupItem valueLabel="Global Green Europe" value="GGE" />
</ButtonGroup>
</div>

<DataTable data={fixed_cost_data} 
    totalRow={true}
    rowshadowing={true}
    groupsOpen={true}
    totalLabel="Total"
    headerFontColor="Bold"
    headerColor="#FFD700"
    title = "Values are in Million"
    rows={20}>

  <Column id="metric" totalAgg="" />

  <Column 
    id="cy_24_act" 
    title="CY-24 ACTUAL" 
    fmt="{inputs.matric === 'GGE' ? '€0.00' : '$0.00'}" 
  />
  <Column 
    id="cy_25_act" 
    title="CY-25 ACTUAL" 
    fmt="{inputs.matric === 'GGE' ? '€0.00' : '$0.00'}" 
  />
  <Column 
    id="cy_25_aop" 
    title="CY-25 AOP" 
    fmt="{inputs.matric === 'GGE' ? '€0.00' : '$0.00'}" 
  />
  <Column 
    id="variance_vs_aop" 
    title="Variance vs AOP" 
    fmt="{inputs.matric === 'GGE' ? '€0.00' : '$0.00'}" 
    contentType="delta" 
  />
  <Column 
    id="variance_vs_ly" 
    title="Variance vs LY" 
    fmt="{inputs.matric === 'GGE' ? '€0.00' : '$0.00'}" 
    contentType="delta" 
  />

</DataTable>

<Grid cols = 3>

## 🧾 Fixed Cost YTD

<div class = "relative relative mb-5 mt-1 ml-20">
<Dropdown data={date_filter_ytd} name=date_filter_ytd value=date_filter_ytd title="Month" defaultValue="Jan-25" order = 'date_sort desc'>
</Dropdown>
<Info description="Data not available for Jan-25 (Global Green India)" color="red" />
</div>

<div class = "relative mt-5 ml-25">
 <p class="text-sm text-grey ml-auto">
        📅 Last Updated: <Value data={max_fixed_cost_ytd} />
    </p>
</div>

</Grid>



<div class="flex items-center justify-between w-full">
<ButtonGroup name="matric_ytd" display="tabs">
        <ButtonGroupItem valueLabel="Global Green India" value="GGCL" default />
        <ButtonGroupItem valueLabel="Global Green Europe" value="GGE" />
</ButtonGroup>
</div>

<DataTable data={fixed_cost_data_ytd} 
    totalRow={true}
    rowshadowing={true}
    groupsOpen={true}
    totalLabel="Total"
    headerFontColor="Bold"
    headerColor="#FFD700"
    title = "Values are in Million"
    rows={20}>

  <Column id="metric" totalAgg="" />

  <Column 
    id="cy_24_act" 
    title="CY-24 ACTUAL" 
    fmt="$0.00" 
  />
  <Column 
    id="cy_25_act" 
    title="CY-25 ACTUAL" 
    fmt="$0.00" 
  />
  <Column 
    id="cy_25_aop" 
    title="CY-25 AOP" 
    fmt="$0.00" 
  />
  <Column 
    id="variance_vs_aop" 
    title="Variance vs AOP" 
    fmt="$0.00" 
    contentType="delta" 
  />
  <Column 
    id="variance_vs_ly" 
    title="Variance vs LY" 
    fmt="$0.00" 
    contentType="delta" 
  />

</DataTable>

<Grid cols = 3>

## 🧾 Fixed Cost Consolidated

<div class = "relative relative mb-5 mt-1 ml-20">
<Dropdown data={date_filter_cons} name=date_filter_cons value=date_filter_cons title="Month" defaultValue="Jan-25" order = 'date_sort desc'>
</Dropdown>
</div>

<div class = "relative mt-5 ml-25">
 <p class="text-sm text-grey ml-auto">
        📅 Last Updated: <Value data={max_fixed_cost_date} />
    </p>
</div>

</Grid>



<DataTable data={fixed_cost_data_cons} 
    totalRow={true}
    rowshadowing={true}
    groupsOpen={true}
    totalLabel="Total"
    headerFontColor="Bold"
    headerColor="#FFD700"
    title = "Values are in Million"
    rows={20}>

  <Column id="metric" totalAgg="" />

  <Column 
    id="cy_24_act" 
    title="CY-24 ACTUAL" 
    fmt="$0.00" 
  />
  <Column 
    id="cy_25_act" 
    title="CY-25 ACTUAL" 
    fmt="$0.00" 
  />
  <Column 
    id="cy_25_aop" 
    title="CY-25 AOP" 
    fmt="$0.00" 
  />
  <Column 
    id="variance_vs_aop" 
    title="Variance vs AOP" 
    fmt="$0.00" 
    contentType="delta" 
  />
  <Column 
    id="variance_vs_ly" 
    title="Variance vs LY" 
    fmt="$0.00" 
    contentType="delta" 
  />

</DataTable>

<Grid cols = 3>

## 🧾 Fixed Cost Consolidated YTD

<div class = "relative relative mb-5 mt-1 ml-20">
<Dropdown data={date_filter_ytd_cons} name=date_filter_ytd_cons value=date_filter_ytd_cons title="Month" defaultValue="Jan-25" order = 'date_sort desc'>
</Dropdown>
<Info description="Data not available for Jan-25" color="red" />
</div>

<div class = "relative mt-5 ml-25">
 <p class="text-sm text-grey ml-auto">
        📅 Last Updated: <Value data={max_fixed_cost_ytd} />
    </p>
</div>

</Grid>



<DataTable data={fixed_cost_data__ytd_cons} 
    totalRow={true}
    rowshadowing={true}
    groupsOpen={true}
    totalLabel="Total"
    headerFontColor="Bold"
    headerColor="#FFD700"
    title = "Values are in Million"
    rows={20}>

  <Column id="metric" totalAgg="" />

  <Column 
    id="cy_24_act" 
    title="CY-24 ACTUAL" 
    fmt="$0.00" 
  />
  <Column 
    id="cy_25_act" 
    title="CY-25 ACTUAL" 
    fmt="$0.00" 
  />
  <Column 
    id="cy_25_aop" 
    title="CY-25 AOP" 
    fmt="$0.00" 
  />
  <Column 
    id="variance_vs_aop" 
    title="Variance vs AOP" 
    fmt="$0.00" 
    contentType="delta" 
  />
  <Column 
    id="variance_vs_ly" 
    title="Variance vs LY" 
    fmt="$0.00" 
    contentType="delta" 
  />

</DataTable>

<div class = 'mb-15'> </div>

```sql date_filter
SELECT 
  DISTINCT period_date AS date_filter,
  STRPTIME(period_date, '%b-%y') AS date_sort
FROM fixed_cost_metrics
WHERE source_section = 'Fixed Cost'
  AND period_date IS NOT NULL
  AND TRIM(period_date) <> ''
ORDER BY date_sort DESC;
```

```sql date_filter_ytd
SELECT 
  DISTINCT ytd AS date_filter_ytd,
  STRPTIME(ytd, '%b-%y') AS date_sort
FROM fixed_cost_metrics
WHERE source_section = 'Fixed Cost'
  AND ytd IS NOT NULL
  AND TRIM(ytd) <> ''
ORDER BY date_sort DESC;
```

```sql date_filter_cons
SELECT 
  DISTINCT period_date AS date_filter_cons,
  STRPTIME(period_date, '%b-%y') AS date_sort
FROM fixed_cost_metrics
WHERE source_section = 'Fixed Cost'
  AND period_date IS NOT NULL
  AND TRIM(period_date) <> ''
ORDER BY date_sort DESC;
```

```sql date_filter_ytd_cons
SELECT 
  DISTINCT ytd AS date_filter_ytd_cons,
  STRPTIME(ytd, '%b-%y') AS date_sort
FROM fixed_cost_metrics
WHERE source_section = 'Fixed Cost'
  AND ytd IS NOT NULL
  AND TRIM(ytd) <> ''
ORDER BY date_sort DESC;
```

```sql fixed_cost_data
SELECT 
  entity,
  period_date,
  metric,

  MAX(CASE WHEN metric_type = 'CY-24 ACT' THEN period_value END) AS cy_24_act,
  MAX(CASE WHEN metric_type = 'CY-25 ACT' THEN period_value END) AS cy_25_act,
  MAX(CASE WHEN metric_type = 'CY-25 AOP' THEN period_value END) AS cy_25_aop,
  MAX(CASE WHEN metric_type = 'Variance vs AOP' THEN period_value END) AS variance_vs_aop,
  MAX(CASE WHEN metric_type = 'Variance vs LY' THEN period_value END) AS variance_vs_ly

FROM fixed_cost_metrics
WHERE source_section = 'Fixed Cost'
  AND entity = CASE '${inputs.matric}'
    WHEN 'GGCL' THEN 'Global Green India'
    WHEN 'GGE' THEN 'Global Green Europe'
  END
  AND period_date = '${inputs.date_filter.value}'
  AND TRIM(period_date) <> ''
GROUP BY entity, period_date, metric
ORDER BY period_date, metric;

```

```sql fixed_cost_data_ytd
SELECT 
  entity,
  period_date,
  ytd,
  metric,

  MAX(CASE WHEN metric_type = 'CY-24 ACT' THEN period_value END) AS cy_24_act,
  MAX(CASE WHEN metric_type = 'CY-25 ACT' THEN period_value END) AS cy_25_act,
  MAX(CASE WHEN metric_type = 'CY-25 AOP' THEN period_value END) AS cy_25_aop,
  MAX(CASE WHEN metric_type = 'Variance vs AOP' THEN period_value END) AS variance_vs_aop,
  MAX(CASE WHEN metric_type = 'Variance vs LY' THEN period_value END) AS variance_vs_ly

FROM fixed_cost_metrics
WHERE source_section = 'Fixed Cost'
  AND entity = CASE '${inputs.matric_ytd}'
    WHEN 'GGCL' THEN 'Global Green India'
    WHEN 'GGE' THEN 'Global Green Europe'
  END
  AND ytd = '${inputs.date_filter_ytd.value}'
  AND TRIM(ytd) <> ''
GROUP BY entity, period_date, ytd, metric
ORDER BY period_date, metric;

 ```

 ```sql fixed_cost_data_cons
 SELECT 
  period_date,
  ytd,
  metric,

  MAX(CASE WHEN metric_type = 'CY-24 ACT' THEN period_value END) AS cy_24_act,
  MAX(CASE WHEN metric_type = 'CY-25 ACT' THEN period_value END) AS cy_25_act,
  MAX(CASE WHEN metric_type = 'CY-25 AOP' THEN period_value END) AS cy_25_aop,
  MAX(CASE WHEN metric_type = 'Variance vs AOP' THEN period_value END) AS variance_vs_aop,
  MAX(CASE WHEN metric_type = 'Variance vs LY' THEN period_value END) AS variance_vs_ly

FROM fixed_cost_metrics
WHERE source_section = 'Fixed Cost'
  AND entity = 'Global Green'
  AND period_date = '${inputs.date_filter_cons.value}'
  AND TRIM(period_date) <> ''
GROUP BY period_date, ytd, metric
ORDER BY period_date, metric;
```

```sql fixed_cost_data__ytd_cons
 SELECT 
  period_date,
  ytd,
  metric,

  MAX(CASE WHEN metric_type = 'CY-24 ACT' THEN period_value END) AS cy_24_act,
  MAX(CASE WHEN metric_type = 'CY-25 ACT' THEN period_value END) AS cy_25_act,
  MAX(CASE WHEN metric_type = 'CY-25 AOP' THEN period_value END) AS cy_25_aop,
  MAX(CASE WHEN metric_type = 'Variance vs AOP' THEN period_value END) AS variance_vs_aop,
  MAX(CASE WHEN metric_type = 'Variance vs LY' THEN period_value END) AS variance_vs_ly

FROM fixed_cost_metrics
WHERE source_section = 'Fixed Cost'
  AND entity = 'Global Green'
  AND ytd = '${inputs.date_filter_ytd_cons.value}'
  AND TRIM(ytd) <> ''
GROUP BY period_date, ytd, metric
ORDER BY period_date, metric;
```

```sql max_fixed_cost_date
SELECT 
    STRFTIME(MAX(STRPTIME(period_date, '%b-%y')), '%b-%y') AS max_fixed_cost_date
FROM 
    fixed_cost_metrics
WHERE 
    period_date != 'Feb-25';
```    

```sql max_fixed_cost_ytd
SELECT 
    STRFTIME(MAX(STRPTIME(period_date, '%b-%y')), '%b-%y') AS max_fixed_cost_date
FROM 
    fixed_cost_metrics
```    