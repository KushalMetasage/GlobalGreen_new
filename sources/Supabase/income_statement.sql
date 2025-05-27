SELECT entity,
       metric,
       metric_type,
       period_date,
       period_value,
       (date_my::date || 'T00:00:00Z')::timestamptz AS date_my
FROM mmr.financial_metrics_monthly;