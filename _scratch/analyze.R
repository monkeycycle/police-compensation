
winnipeg_all_salary_disclosure_2016_2020 <- read_feather(dir_data_processed('winnipeg_all_salary_disclosure_2016_2020.feather'))
winnipeg_police_salary_disclosure_2016_2020 <- read_feather(dir_data_processed('winnipeg_police_salary_disclosure_2016_2020.feather'))

winnipeg_wps_annual_reports <- read_feather(dir_data_processed('wps_annual_reports.feather'))
inflation_rate <- read_feather(dir_data_processed('inflation_rate.feather'))

source(dir_src("analyze_winnipeg_salary_disclosure.R"))


source(dir_src("analyze_winnipeg_population.R"))
source(dir_src("analyze_winnipeg_authorized_officers.R"))
source(dir_src("analyze_winnipeg_budget.R"))
source(dir_src("analyze_winnipeg_residents_per_officer.R"))


########################################
# Crime
########################################

wps_violent_crimes <- winnipeg_wps_annual_reports %>%
  select(year_date, violent_crimes_total, violent_crimes_clearance_rate_pct) %>%
  mutate(
    pct_change = (violent_crimes_total/lag(violent_crimes_total) - 1) * 100,
    clearance_pct_change = (violent_crimes_clearance_rate_pct/lag(violent_crimes_clearance_rate_pct) - 1) * 100
  )

wps_property_crimes <- winnipeg_wps_annual_reports %>%
  select(year_date, property_crimes_total, property_crimes_clearance_rate_pct) %>%
  mutate(
    pct_change = (property_crimes_total/lag(property_crimes_total) - 1) * 100,
    clearance_pct_change = (property_crimes_clearance_rate_pct/lag(property_crimes_clearance_rate_pct) - 1) * 100
  )

wps_cdsa_crimes <- winnipeg_wps_annual_reports %>%
  select(year_date, cdsa_total, cdsa_clearance_rate_pct) %>%
  mutate(
    pct_change = (cdsa_total/lag(cdsa_total) - 1) * 100,
    clearance_pct_change = (cdsa_clearance_rate_pct/lag(cdsa_clearance_rate_pct) - 1) * 100
  )

wps_all_crimes_clearance_rates_tall <- winnipeg_wps_annual_reports %>%
  select(year_date,
         violent_crimes_clearance_rate_pct,
         other_crimes_clearance_rate_pct,
         property_crimes_clearance_rate_pct,
         cdsa_clearance_rate_pct
  ) %>%
  pivot_longer(
    -year_date
  ) %>%
  mutate (
    name = factor(name, levels=c(
      "violent_crimes_clearance_rate_pct",
      "property_crimes_clearance_rate_pct",
      "other_crimes_clearance_rate_pct",
      "cdsa_clearance_rate_pct"
    )
    ),
    value = as.numeric(value)
  )


########################################
# Calls and events
########################################
wps_calls_events <- winnipeg_wps_annual_reports %>%
  select(year_date,
         calls_to_communication_centre,
         police_initiated_displatched_events,
         citizen_generated_dispatched_events
  ) %>%
  mutate(
    calls_pct_change = (calls_to_communication_centre/lag(calls_to_communication_centre) - 1) * 100,
    police_initiated_pct_change = (police_initiated_displatched_events/lag(police_initiated_displatched_events) - 1) * 100,
    citizen_generated_pct_change = (citizen_generated_dispatched_events/lag(citizen_generated_dispatched_events) - 1) * 100,
  )

wps_calls_events_counts_tall <- wps_calls_events %>%
  select(year_date,
         police_initiated_displatched_events,
         citizen_generated_dispatched_events
  ) %>%
  pivot_longer(
    -year_date
  ) %>%
  mutate (
    name = factor(name, levels=c(
      "police_initiated_displatched_events",
      "citizen_generated_dispatched_events"
    )),
    value = as.numeric(value)
  )


wps_calls_events_pct_chg_tall <- wps_calls_events %>%
  select(year_date,
         police_initiated_pct_change,
         citizen_generated_pct_change
  ) %>%
  pivot_longer(
    -year_date
  ) %>%
  mutate (
    name = factor(name, levels=c(
      "police_initiated_pct_change",
      "citizen_generated_pct_change"
    )),
    value = as.numeric(value)
  )



