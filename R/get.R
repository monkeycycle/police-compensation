
################################################################################
# Download data from shared Google Sheet
# https://docs.google.com/spreadsheets/d/1Fp7OqoNA3FohsvaF81YPHVUHHlmsSONO6qnCqJGrCb4/edit#gid=1834239744
################################################################################

# WFP - WPS budget and details
GET("https://docs.google.com/spreadsheets/d/e/2PACX-1vS8iqlqYvFhH-l3lM_FnVb2cqYz3Bw6emNJf45SJHKMxX6ZOmTlPWOuf3bfv3vhUUkaujR2yNYilu3c/pub?gid=0&single=true&output=csv",
    write_disk(dir_data_raw("winnipeg_wps_budgets.csv"), overwrite=TRUE))

# Winnipeg budget breakdown
GET("https://docs.google.com/spreadsheets/d/e/2PACX-1vS8iqlqYvFhH-l3lM_FnVb2cqYz3Bw6emNJf45SJHKMxX6ZOmTlPWOuf3bfv3vhUUkaujR2yNYilu3c/pub?gid=479523204&single=true&output=csv",
    write_disk(dir_data_raw("winnipeg_budgets.csv"), overwrite=TRUE))

# WFPS and WPS Budgets
GET("https://docs.google.com/spreadsheets/d/e/2PACX-1vS8iqlqYvFhH-l3lM_FnVb2cqYz3Bw6emNJf45SJHKMxX6ZOmTlPWOuf3bfv3vhUUkaujR2yNYilu3c/pub?gid=292434862&single=true&output=csv",
    write_disk(dir_data_raw("winnipeg_wps_wfps_budgets.csv"), overwrite=TRUE))

# Inflation Canada
GET("https://docs.google.com/spreadsheets/d/e/2PACX-1vS8iqlqYvFhH-l3lM_FnVb2cqYz3Bw6emNJf45SJHKMxX6ZOmTlPWOuf3bfv3vhUUkaujR2yNYilu3c/pub?gid=1834239744&single=true&output=csv",
    write_disk(dir_data_raw("inflation_canada.csv"), overwrite=TRUE))

