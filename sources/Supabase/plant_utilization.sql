SELECT entity,
       plant_name,
       period_date,
       category,
       period_type,
       period_value,
       (date_my::date || 'T00:00:00Z')::timestamptz AS date_my
FROM mmr.plant_utilization;