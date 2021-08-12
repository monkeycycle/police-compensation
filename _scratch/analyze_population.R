
wps_winnipeg_population_budget <- wps_annual_reports %>%
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



  # wps_officers_diversity_gender_tall <- wps_officers_diversity %>%
  #   select(
  #     year_date,
  #     sworn_male_pct,
  #     sworn_female_pct,
  #   ) %>%
  #   rename(
  #     male_pct = sworn_male_pct,
  #     female_pct = sworn_female_pct,
  #   ) %>%
  #   pivot_longer(
  #     -year_date
  #   ) %>%
  #   mutate (
  #     name = as.factor(name),
  #     value = as.numeric(value)
  #   )
