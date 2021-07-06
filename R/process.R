
winnipeg_all_salary_disclosure_2016 <- read_csv(dir_data_raw("winnipeg-2016-Compensation-Disclosure.csv")) %>%
  clean_names() %>%
  rename(
    employee_first_name = x2,
    employee_last_name = employee
  ) %>%
  mutate(
    compensation = gsub(",", "", compensation, fixed=TRUE),
    compensation = as.numeric(as.character(compensation)),
    year = 2016
  )

winnipeg_all_salary_disclosure_2017 <- read_csv(dir_data_raw("winnipeg-2017-Compensation-Disclosure.csv")) %>%
  clean_names() %>%
  rename(
    employee_first_name = x2,
    employee_last_name = employee
  ) %>%
  mutate(
    compensation = gsub(",", "", compensation, fixed=TRUE),
    compensation = as.numeric(as.character(compensation)),
    year = 2017
  )

winnipeg_all_salary_disclosure_2018 <- read_csv(dir_data_raw("winnipeg-2018-Compensation-Disclosure.csv")) %>%
  clean_names() %>%
  rename(
    employee_first_name = x2,
    employee_last_name = employee
  ) %>%
  mutate(
    compensation = gsub(",", "", compensation, fixed=TRUE),
    compensation = as.numeric(as.character(compensation)),
    year = 2018
  )

winnipeg_all_salary_disclosure_2019 <- read_csv(dir_data_raw("winnipeg-2019-Compensation-Disclosure.csv")) %>%
  clean_names() %>%
  rename(
    employee_first_name = x2,
    employee_last_name = employee
  ) %>%
  mutate(
    compensation = gsub(",", "", compensation, fixed=TRUE),
    compensation = as.numeric(as.character(compensation)),
    year = 2019
  )

winnipeg_all_salary_disclosure_2020 <- read_csv(dir_data_raw("winnipeg-2020-Compensation-Disclosure.csv")) %>%
  clean_names() %>%
  rename(
    employee_first_name = x2,
    employee_last_name = employee
  ) %>%
  mutate(
    compensation = gsub(",", "", compensation, fixed=TRUE),
    compensation = as.numeric(as.character(compensation)),
    year = 2020
  )

winnipeg_all_salary_disclosure_2016_2020 <- rbind(
  winnipeg_all_salary_disclosure_2016,
  winnipeg_all_salary_disclosure_2017,
  winnipeg_all_salary_disclosure_2018,
  winnipeg_all_salary_disclosure_2019,
  winnipeg_all_salary_disclosure_2020
) %>%
  mutate(
    compensation = as.numeric(as.character(compensation))
  )

winnipeg_police_salary_disclosure_2016_2020 <- winnipeg_all_salary_disclosure_2016_2020 %>%
  filter(department %in% c('Police Service', 'Police Services'))

write_feather(winnipeg_all_salary_disclosure_2016_2020, dir_data_processed('winnipeg_all_salary_disclosure_2016_2020.feather'))
write_feather(winnipeg_police_salary_disclosure_2016_2020, dir_data_processed('winnipeg_police_salary_disclosure_2016_2020.feather'))

