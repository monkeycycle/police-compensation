
########################################
# Inflation rates for reference
########################################
inflation_rate_raw <- read_csv(dir_data_raw("inflation_canada.csv")) %>%
  clean_names() %>%
  filter(year != '2009')
write_feather(inflation_rate_raw, dir_data_processed('inflation_rate.feather'))

source(dir_src("process_wps_annual_reports.R"))
source(dir_src("process_winnipeg_salary_disclosures.R"))
source(dir_src("process_winnipeg_budgets.R"))


# StatCan crime severity index
statcan_crimeseverity_3510002601 <- read_csv(dir_data_raw("statcan-3510002601-noSymbol.csv")) %>%
  clean_names() %>%
  filter(crime_severity_index != "Index") %>%
  fill(
    geography
  )

write_feather(statcan_crimeseverity_3510002601, dir_data_processed('statcan_crimeseverity_3510002601.feather'))

