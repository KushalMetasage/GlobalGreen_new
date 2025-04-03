<Grid cols = 3>

<div class="relative mt-3">  
    <h1 class="text-lg m-0 font-bold">🏭 Plant Utilization</h1>
</div>

<div class = "relative relative mb-5 mt-1 ml-25">
<Dropdown data={date_filter} name=date_filter value=date_filter title="Date" defaultValue="Jan-25" order = 'date_sort desc'>
</Dropdown>
</div>

<div class= "relative mt-5 ml-30">
<p class="text-sm text-grey ml-auto">
        📅 Last Updated: <Value data={max_date} />
    </p>
</div>
</Grid>

<div class="flex items-center justify-between w-full">
    <!-- Button Group on the Left -->
    <ButtonGroup name="matric" display="tabs">
        <ButtonGroupItem valueLabel="Global Green India" value="GGCL" default />
        <ButtonGroupItem valueLabel="Global Green Europe" value="GGE" />
    </ButtonGroup>
</div>
 



<DataTable data={plant} groupType=section rowshadowing={true} headerFontColor=Bold headerColor=#FFD700>
    <Column id="category" totalAgg=sum fmt='0.00' totalFmt='0' colGroup="{inputs.matric == 'GGE' ? 'Duna' : 'OBL'}"/>
    <Column id="CY Actual" totalAgg=sum fmt='0.00' totalFmt='0' colGroup="{inputs.matric == 'GGE' ? 'Duna' : 'OBL'}"/>
    <Column id="CY AOP" totalAgg="weightedMean" fmt='0.00' colGroup="{inputs.matric == 'GGE' ? 'Duna' : 'OBL'}"/>
    <Column id="LY Actual" totalAgg="weightedMean" fmt='0.00' colGroup="{inputs.matric == 'GGE' ? 'Duna' : 'OBL'}"/>
    <Column id="Act vs AOP %" totalAgg="weightedMean" fmt='0.00"%"' contentType=delta colGroup="{inputs.matric == 'GGE' ? 'Duna' : 'OBL'}"/>
    <Column id="Growth vs LY %" totalAgg="weightedMean" fmt='0.00"%"' contentType=delta colGroup="{inputs.matric == 'GGE' ? 'Duna' : 'OBL'}"/>
</DataTable >

<div class="mt-25">
<DataTable data={plant_1} groupType=section rowshadowing={true} headerFontColor=Bold headerColor=#FFD700>
    <Column id="category" totalAgg=sum fmt='0.00' totalFmt='0' colGroup="{inputs.matric == 'GGE' ? 'Puszta' : 'VKP'}"/>
    <Column id="CY Actual" totalAgg=sum fmt='0.00' totalFmt='0' colGroup="{inputs.matric == 'GGE' ? 'Puszta' : 'VKP'}"/>
    <Column id="CY AOP" totalAgg="weightedMean" fmt='0.00' contentType=delta colGroup="{inputs.matric == 'GGE' ? 'Puszta' : 'VKP'}" />
    <Column id="LY Actual" totalAgg="weightedMean" fmt='0.00' contentType=delta colGroup="{inputs.matric == 'GGE' ? 'Puszta' : 'VKP'}" />
    <Column id="Act vs AOP %" totalAgg="weightedMean" fmt='0.00"%"' contentType=delta colGroup="{inputs.matric == 'GGE' ? 'Puszta' : 'VKP'}" />
    <Column id="Growth vs LY %" totalAgg="weightedMean" fmt='0.00"%"' contentType=delta colGroup="{inputs.matric == 'GGE' ? 'Puszta' : 'VKP'}" />
</DataTable >
</div>

```sql date_filter
SELECT DISTINCT period_date AS date_filter,
STRPTIME(period_date, '%b-%y') AS date_sort
FROM plant_utilization
ORDER BY date_sort DESC;
```

```sql plant
WITH base AS (
    SELECT 
        category,
        period_type,
        period_value
    FROM 
        plant_utilization
    WHERE 
        entity = CASE '${inputs.matric}'
            WHEN 'GGCL' THEN 'Global Green India'
            WHEN 'GGE' THEN 'Global Green Europe'
        END
        AND period_date = '${inputs.date_filter.value}'
        AND (
            ('${inputs.matric}' = 'GGE' AND plant_name = 'Puszta') 
            OR ('${inputs.matric}' = 'GGCL' AND plant_name = 'OBL')
        )
)
SELECT 
    a.category,
    a.period_value AS "CY Actual",
    b.period_value AS "CY AOP",
    c.period_value AS "LY Actual",

    -- Act vs AOP %
    ROUND((
        CAST(NULLIF(TRIM(a.period_value), '') AS DOUBLE) /
        NULLIF(CAST(NULLIF(TRIM(b.period_value), '') AS DOUBLE), 0)
    ) * 100, 2) AS "Act vs AOP %",

    -- Growth vs LY %
    ROUND((
        CAST(NULLIF(TRIM(a.period_value), '') AS DOUBLE) -
        CAST(NULLIF(TRIM(c.period_value), '') AS DOUBLE)
    ) /
    NULLIF(CAST(NULLIF(TRIM(c.period_value), '') AS DOUBLE), 0) * 100, 2) AS "Growth vs LY %"

FROM 
    base a
LEFT JOIN base b ON a.category = b.category AND b.period_type = 'CY AOP'
LEFT JOIN base c ON a.category = c.category AND c.period_type = 'LY Actual'
WHERE 
    a.period_type = 'CY Actual'


```

```sql plant_1
WITH base AS (
    SELECT 
        category,
        period_type,
        period_value
    FROM 
        plant_utilization
    WHERE 
        entity = CASE '${inputs.matric}'
            WHEN 'GGCL' THEN 'Global Green India'
            WHEN 'GGE' THEN 'Global Green Europe'
        END
        AND period_date = '${inputs.date_filter.value}'
        AND (
            ('${inputs.matric}' = 'GGE' AND plant_name = 'Duna') 
            OR ('${inputs.matric}' = 'GGCL' AND plant_name = 'VKP')
        )
)
SELECT 
    a.category,
    a.period_value AS "CY Actual",
    b.period_value AS "CY AOP",
    c.period_value AS "LY Actual",

    -- Act vs AOP %
    ROUND((
        CAST(NULLIF(TRIM(a.period_value), '') AS DOUBLE) /
        NULLIF(CAST(NULLIF(TRIM(b.period_value), '') AS DOUBLE), 0)
    ) * 100, 2) AS "Act vs AOP %",

    -- Growth vs LY %
    ROUND((
        CAST(NULLIF(TRIM(a.period_value), '') AS DOUBLE) -
        CAST(NULLIF(TRIM(c.period_value), '') AS DOUBLE)
    ) /
    NULLIF(CAST(NULLIF(TRIM(c.period_value), '') AS DOUBLE), 0) * 100, 2) AS "Growth vs LY %"

FROM 
    base a
LEFT JOIN base b ON a.category = b.category AND b.period_type = 'CY AOP'
LEFT JOIN base c ON a.category = c.category AND c.period_type = 'LY Actual'
WHERE 
    a.period_type = 'CY Actual'
```

```sql max_date
SELECT 
    STRFTIME(MAX(STRPTIME(period_date, '%b-%y')), '%b-%y') AS max_period_date
FROM 
    plant_utilization;

```