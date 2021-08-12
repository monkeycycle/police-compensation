
# Winnipeg WPS annual reports
wps_annual_reports_raw <- read_xlsx(
  dir_data_raw('winnipeg_WPS_budget.xlsx'),
  sheet="annual-reports"
) %>%
  clean_names() %>%
  filter(year != '2009') %>%
  mutate(
    year_end =paste(year, '-01-01', sep=''),
    year_date=as.Date(year_end),
    year=as.factor(year),
  )


inflation_rate_raw <- read_xlsx(
  dir_data_raw('winnipeg_WPS_budget.xlsx'),
  sheet="inflation-canada"
) %>%
  clean_names() %>%
  filter(year != '2009')


write_feather(wps_annual_reports_raw, dir_data_processed('wps_annual_reports.feather'))
write_feather(inflation_rate_raw, dir_data_processed('inflation_rate.feather'))



