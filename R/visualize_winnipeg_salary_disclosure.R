
p_winnipeg_salary_disclosure <- winnipeg_all_salary_disclosure_2016_2020 %>%
  mutate(
    dept_type=ifelse(department == "Police Services", "WPS",
                     ifelse(department == "Fire Paramedic Service", "WFPS",
                            "Other dept"
                     ))
  ) %>%
  ggplot() +
  aes(x = year, y = compensation, colour=dept_type, fill=dept_type) +
  geom_quasirandom(dodge.width = .6, alpha = .5, varwidth = TRUE ) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(0, 400000),
    labels = function(x) {
      ifelse(x == 400000, paste("$", comma(x), sep = ""), comma(x))
    }
  ) +
  minimal_theme() +
  labs(
    title = wrap_text("Distribution of City of Winnipeg employees with a salary above $75,000", 65),
    subtitle = "",
    colour="",
    fill="",
    x="",
    y="",
    caption=toupper(paste(
      "WINNIPEG FREE PRESS — SOURCE: City of winnipeg"
    ))
  )



wfp_winnipeg_salary_disclosure <- prepare_plot(p_winnipeg_salary_disclosure)
ggsave_pngpdf(wfp_winnipeg_salary_disclosure, "wfp_winnipeg_salary_disclosure", width_var=8.66, height_var=6, dpi_var=300, scale_var=1, units_var="in")


