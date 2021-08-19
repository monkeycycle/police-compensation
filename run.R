if (!require('upstartr')) install.packages('upstartr'); library('upstartr')
run_config()
source(dir_src("theme.R"))
source(dir_src("palette.R"))

source(dir_src("get.R"))
run_process()
run_analyze()
run_visualize()


run_notebook(filename="notebook-emergency-service-budgets.Rmd")
