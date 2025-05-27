SELECT
  entity,
  sub_category,
  particulars,
  period_date,
  period_value,
  (date_my::date || 'T00:00:00Z')::timestamptz AS date_my
FROM
  mmr.balance_sheet_items;

