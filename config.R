# =================================================================
# This file configures the project by specifying filenames, loading
# packages and setting up some project-specific variables.
# =================================================================

initialize_startr(
  title = 'Police compensation',
  author = 'Michael Pereira <michael.pereira@freepress.mb.ca>',
  timezone = 'America/Winnipeg',
  should_render_notebook = FALSE,
  should_process_data = TRUE,
  should_timestamp_output_files = FALSE,
  should_beep = FALSE,
  packages = c(
    "tidyverse", "glue", "magrittr", "lubridate", "hms",
    "readxl", "feather", "RcppRoll",
    "scales", "janitor", "httr", "Cairo",
    "ggrepel", "prettydoc",
    "aws.s3", "dotenv", "rlang",
    "googledrive", "googlesheets4", "cowplot",
    "zip", "gmailr", "knitr", "DT", "zoo", "ggtext",
    "ggpubr", "ggtext", "showtext", "kableExtra",
    "gmailr", "patchwork",
    "pracma", "ISOweek",
    "slackr", "ggbeeswarm"

    # 'rvest',
    # 'sf',
    # 'tidymodels',
    # 'gganimate',
    # 'tgamtheme',
    # 'cansim',
    # 'cancensus'
  )
)

# Refer to your source data here. These can be either references to files in
# your `data/raw` folder, or paths to files hosted on the web. For example:
# For example:
# sample.raw.file <- dir_data_raw('your-filename-here.csv')
# sample.raw.path <- 'https://github.com/tidyverse/dplyr/raw/master/data-raw/starwars.csv'
