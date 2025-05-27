SELECT sno,
       company_name,
       particular,
       period_date,
       period_value,
       (date_my::date || 'T00:00:00Z')::timestamptz AS date_my
FROM mmr.cashflow_items