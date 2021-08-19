
inflation_rate <- read_feather(dir_data_processed('inflation_rate.feather'))
winnipeg_wps_annual_reports <- read_feather(dir_data_processed('wps_annual_reports.feather'))
winnipeg_wps_wfps_annual_budgets <- read_feather(dir_data_processed('wfps_wps_annual_budgets.feather'))

################################################################################
# Forecast the WPS and WFPS budgets.
################################################################################

winnipeg_wps_wfps_annual_budgets_wps <- winnipeg_wps_wfps_annual_budgets %>%
  select(wps_millions)

winnipeg_wps_wfps_annual_budgets_wfps <- winnipeg_wps_wfps_annual_budgets %>%
  select(wfps_millions)

wps_2020_value  <- winnipeg_wps_wfps_annual_budgets %>% filter(year == 2020) %>%
  select(wps_millions) %>% pull()

wfps_2020_value  <- winnipeg_wps_wfps_annual_budgets %>% filter(year == 2020) %>%
  select(wfps_millions) %>% pull()

ts_winnipeg_wps_wfps_annual_budgets_wps <- ts(winnipeg_wps_wfps_annual_budgets_wps, start=2011)
model_tbats_wps <- tbats(ts_winnipeg_wps_wfps_annual_budgets_wps)
summary(model_tbats_wps)
for_tbats_wps <- forecast::forecast(model_tbats_wps, h = 12)
df_tbats_wps = as.data.frame(for_tbats_wps)
df_tbats_wps <- tibble::rownames_to_column(df_tbats_wps, "year")
df_tbats_wps <- df_tbats_wps %>%
  mutate(year_date = as.Date(paste(year, "-01-01", sep=""))) %>%
  clean_names() %>%
  add_row(year="2020", point_forecast=wps_2020_value, lo_80=wps_2020_value, hi_80=wps_2020_value, lo_95=wps_2020_value, hi_95=wps_2020_value, year_date=as.Date("2020-01-01"))

ts_winnipeg_wps_wfps_annual_budgets_wfps <- ts(winnipeg_wps_wfps_annual_budgets_wfps, start=2011)
model_tbats_wfps <- tbats(ts_winnipeg_wps_wfps_annual_budgets_wfps)
summary(model_tbats_wfps)
for_tbats_wfps <- forecast::forecast(model_tbats_wfps, h = 12)
df_tbats_wfps = as.data.frame(for_tbats_wfps)
df_tbats_wfps <- tibble::rownames_to_column(df_tbats_wfps, "year")
df_tbats_wfps <- df_tbats_wfps %>%
  mutate(year_date = as.Date(paste(year, "-01-01", sep=""))) %>%
  clean_names() %>%
  add_row(year="2020", point_forecast=wfps_2020_value, lo_80=wfps_2020_value, hi_80=wfps_2020_value, lo_95=wfps_2020_value, hi_95=wfps_2020_value, year_date=as.Date("2020-01-01"))


source(dir_src("analyze_wps_calls_crime.R"))
source(dir_src("analyze_winnipeg_salary_disclosure.R"))
source(dir_src("analyze_winnipeg_budgets.R"))



# StatCan crime severity index and clearanc rates
statcan_crimeseverity_3510002601 <- read_feather(dir_data_processed('statcan_crimeseverity_3510002601.feather')) %>%
  filter(geography %in% c(
    "Halifax, Nova Scotia",
    "Montréal, Quebec",
    "Ottawa-Gatineau, Ontario/Quebec",
    "Toronto, Ontario",
    "Hamilton, Ontario",
    "Regina, Saskatchewan",
    "Winnipeg, Manitoba",
    "Saskatoon, Saskatchewan",
    "Calgary, Alberta",
    "Edmonton, Alberta",
    "Kelowna, British Columbia",
    "Vancouver, British Columbia"
  )) %>%
  mutate(
    geography = case_when(
         geography == "Halifax, Nova Scotia" ~ "Halifax",
         geography == "Montréal, Quebec" ~ "Montréal",
         geography == "Ottawa-Gatineau, Ontario/Quebec" ~ "Ottawa",
         geography == "Toronto, Ontario" ~ "Toronto",
         geography == "Hamilton, Ontario" ~ "Hamilton",
         geography == "Regina, Saskatchewan" ~ "Regina",
         geography == "Winnipeg, Manitoba" ~ "Winnipeg",
         geography == "Saskatoon, Saskatchewan" ~ "Saskatoon",
         geography == "Calgary, Alberta" ~ "Calgary",
         geography == "Edmonton, Alberta" ~ "Edmonton",
         geography == "Kelowna, British Columbia" ~ "Kelowna",
         geography == "Vancouver, British Columbia" ~ "Vancouver"
    )
  )


statcan_crimeseverityindex <- statcan_crimeseverity_3510002601 %>%
  select(
    geography,
    reference_period,
    crime_severity_index,
    violent_crime_severity_index,
    non_violent_crime_severity_index,
    youth_crime_severity_index,
    youth_violent_crime_severity_index,
    youth_non_violent_crime_severity_index
  )

statcan_crimeseverityindex_tall <- statcan_crimeseverityindex %>%
  select(
    geography,
    reference_period,
    crime_severity_index,
    violent_crime_severity_index,
    non_violent_crime_severity_index
  ) %>%
  mutate(
    crime_severity_index = as.numeric(as.character(crime_severity_index)),
    violent_crime_severity_index = as.numeric(as.character(violent_crime_severity_index)),
    non_violent_crime_severity_index = as.numeric(as.character(non_violent_crime_severity_index))
  ) %>%
  pivot_longer(c(-geography, -reference_period),
               names_to="csi",
               values_to="value") %>%
                mutate(
                  csi = gsub("non_violent_crime_severity_index", "Non-violent CSI", csi, fixed=TRUE),
                  csi = gsub("violent_crime_severity_index", "Violent CSI", csi, fixed=TRUE),
                  csi = gsub("crime_severity_index", "Crime Severity Index", csi, fixed=TRUE)
                )


statcan_crimeclearance <- statcan_crimeseverity_3510002601 %>%
  select(
    geography,
    reference_period,
    weighted_clearance_rate,
    violent_weighted_clearance_rate,
    non_violent_weighted_clearance_rate
  )

statcan_crimeclearance <- as.data.frame(statcan_crimeclearance)

statcan_crimeclearance <- statcan_crimeclearance %>%
  mutate(
        weighted_clearance_rate = as.numeric(as.character(weighted_clearance_rate)),
        violent_weighted_clearance_rate = as.numeric(as.character(violent_weighted_clearance_rate)),
        non_violent_weighted_clearance_rate = as.numeric(as.character(non_violent_weighted_clearance_rate))
  )

statcan_crimeclearance_tall <- statcan_crimeclearance %>%
  pivot_longer(c(-geography, -reference_period),
               names_to="clearance",
               values_to="value") %>%
              mutate(
                clearance = gsub("weighted_", "", clearance, fixed=TRUE),
                clearance = gsub("_", " ", clearance, fixed=TRUE),
                clearance = gsub("non violent clearance rate", "Non-violent", clearance, fixed=TRUE),
                clearance = gsub("violent clearance rate", "Violent", clearance, fixed=TRUE),
                clearance = gsub("clearance rate", "Clearance rate", clearance, fixed=TRUE)
              )
