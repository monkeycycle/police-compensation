

########################################
# Winnipeg WPS annual reports
########################################
wps_annual_reports_raw <- read_csv(dir_data_raw("winnipeg_wps_budgets.csv")) %>%
  clean_names() %>%
  filter(year != '2009') %>%
  filter(year != '2010') %>%
  mutate(
    year_end =paste(year, '-12-31', sep=''),
    year_date=as.Date(paste(year, '-01-01', sep='')),
    # year=as.factor(year),
    year = as.numeric(format(as.Date(year_date, format="%Y-%M-%D"),"%Y")),
    tax_supported_expenses_pct_chg = (tax_supported_expenses/lag(tax_supported_expenses) - 1) * 100,
    per_capita_cost_pct_chg = (per_capita_cost/lag(per_capita_cost) - 1) * 100,
    residents_per_police_officer_pct_chg = (residents_per_police_officer/lag(residents_per_police_officer) - 1) * 100
  ) %>%
  left_join(
    inflation_rate_raw, by = c("year" = "year")
  ) %>%
  rename(
    inflation_rate_annual_chg = annual_change
  )


########################################
# Winnipeg WFPS annual reports
########################################
wfps_wps_annual_budgets_raw <- read_csv(dir_data_raw("winnipeg_wps_wfps_budgets.csv")) %>%
  clean_names() %>%
  filter(year != '2009') %>%
  mutate(
    year_date=as.Date(paste(year, '-01-01', sep='')),
    year = as.numeric(format(as.Date(year_date, format="%Y-%M-%D"),"%Y")),

  )


write_feather(wps_annual_reports_raw, dir_data_processed('wps_annual_reports.feather'))
write_feather(wfps_wps_annual_budgets_raw, dir_data_processed('wfps_wps_annual_budgets.feather'))



