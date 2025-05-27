SELECT entity,
       metric,
       metric_type,
       period_date,
       source_section,
       period_value,
       ytd,
       (date_my::date || 'T00:00:00Z')::timestamptz AS date_my
FROM mmr.financial_metrics_monthly;