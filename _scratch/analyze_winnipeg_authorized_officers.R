
wps_authorized_actual_officers <- winnipeg_wps_annual_reports %>%
  select(year_date, total_authorized_police_members, sworn_total_actual) %>%
  mutate(
    auth_actual_diff = sworn_total_actual - total_authorized_police_members,
    pct_change_authorized = round((total_authorized_police_members/lag(total_authorized_police_members) - 1) * 100, 2),
    pct_change_actual = round((sworn_total_actual/lag(sworn_total_actual) - 1) * 100, 2)
  ) %>%
  select(
    year_date,
    total_authorized_police_members,
    pct_change_authorized,
    sworn_total_actual,
    pct_change_actual,
    auth_actual_diff,
  )

wps_authorized_actual_officers_count_tall <- wps_authorized_actual_officers %>%
  select(
    year_date,
    total_authorized_police_members,
    sworn_total_actual,
  ) %>%
  rename(
    year_date = year_date,
    authorized = total_authorized_police_members,
    actual = sworn_total_actual,
  ) %>%
  pivot_longer(
    -year_date
  ) %>%
  mutate (
    name = factor(name, levels=c(
      "authorized",
      "actual"
    )),
    value = as.numeric(value)
  )




wps_authorized_officers_final_year_date = wps_authorized_actual_officers %>%
  arrange(desc(year_date)) %>%
  head(1) %>%
  select(total_authorized_police_members) %>%
  pull()

wps_authorized_officers_min = min(wps_authorized_actual_officers$total_authorized_police_members)
wps_authorized_officers_max = max(wps_authorized_actual_officers$total_authorized_police_members)
wps_authorized_officers_min_max_diff = wps_authorized_officers_max - wps_authorized_officers_min
wps_authorized_officers_max_final_diff = wps_authorized_officers_final_year_date - wps_authorized_officers_max


wps_actual_officers_final_year_date = wps_authorized_actual_officers %>%
  arrange(desc(year_date)) %>%
  head(1) %>%
  select(sworn_total_actual) %>%
  pull()

wps_actual_officers_min = min(wps_authorized_actual_officers$sworn_total_actual)
wps_actual_officers_max = max(wps_authorized_actual_officers$sworn_total_actual)
wps_actual_officers_min_max_diff = wps_actual_officers_max - wps_actual_officers_min
wps_actual_officers_max_final_diff = wps_actual_officers_final_year_date - wps_actual_officers_max
