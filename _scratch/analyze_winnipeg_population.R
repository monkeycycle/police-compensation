
wps_winnipeg_population_budget <- winnipeg_wps_annual_reports %>%
  select(
    year_date,
    tax_supported_expenses,
    per_capita_cost,
    total_authorized_police_members,
    sworn_total_actual,
    population
  ) %>%
  mutate(
    population_pct_change = (population/lag(population) - 1) * 100,
  )

