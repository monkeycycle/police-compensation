

winnipeg_budgets  <- read_csv(dir_data_raw("winnipeg_budgets.csv")) %>%
  clean_names()

write_feather(winnipeg_budgets, dir_data_processed('winnipeg_budgets.feather'))


