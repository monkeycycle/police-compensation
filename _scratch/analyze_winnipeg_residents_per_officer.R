wps_residents_per_police_officer <- winnipeg_wps_annual_reports %>%
  select(year_date, residents_per_police_officer) %>%
  mutate(
    pct_change = (residents_per_police_officer/lag(residents_per_police_officer) - 1) * 100
  )
