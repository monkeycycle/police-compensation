wps_tax_supported_expenses <- winnipeg_wps_annual_reports %>%
  select(year_date, tax_supported_expenses) %>%
  mutate(
    pct_change = (tax_supported_expenses/lag(tax_supported_expenses) - 1) * 100
  )


wps_tax_supported_expenses_v_inflation <- winnipeg_wps_annual_reports %>%
  select(year_date, tax_supported_expenses) %>%
  mutate(
    year = as.numeric(format(as.Date(year_date, format="%Y-%M-%D"),"%Y")),
    pct_change = (tax_supported_expenses/lag(tax_supported_expenses) - 1) * 100
  ) %>%
  left_join(
    inflation_rate, by = c("year" = "year")
  ) %>%
  select(
    -tax_supported_expenses,
    -year,
    -annual_change
  )

wps_tax_supported_expenses_v_inflation_tall <- wps_tax_supported_expenses_v_inflation %>%
  pivot_longer(
    -year_date
  ) %>%
  mutate (
    name = factor(name, levels=c(
      "pct_change",
      "inflation_rate"
    )
    ),
    value = as.numeric(value)
  )







wps_per_capita_cost <- winnipeg_wps_annual_reports %>%
  select(year_date, per_capita_cost) %>%
  mutate(
    pct_change = (per_capita_cost/lag(per_capita_cost) - 1) * 100
  )




