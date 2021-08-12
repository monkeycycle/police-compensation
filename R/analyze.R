
inflation_rate <- read_feather(dir_data_processed('inflation_rate.feather'))
winnipeg_wps_annual_reports <- read_feather(dir_data_processed('wps_annual_reports.feather'))
winnipeg_wfps_annual_reports <- read_feather(dir_data_processed('wfps_annual_reports.feather'))

source(dir_src("analyze_wps_calls_crime.R"))
source(dir_src("analyze_winnipeg_salary_disclosure.R"))
