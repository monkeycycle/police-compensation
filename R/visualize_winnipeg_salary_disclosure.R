
df_winnipeg_salary_disclosure <- winnipeg_all_salary_disclosure_2016_2020 %>%
  mutate(
    dept_type=ifelse(department == "Police Services", "WPS",
                     ifelse(department == "Fire Paramedic Service", "WFPS",
                     ifelse(department == "NA", "Other department",
                            "Other departments"
                     ))),
    dept_type = factor(dept_type, levels=c("WPS", "WFPS", "Other departments"))
  ) %>%
  filter(!is.na(department))

p_winnipeg_salary_disclosure <- ggplot(df_winnipeg_salary_disclosure) +
  aes(x = year, y = compensation, colour=dept_type, fill=dept_type) +
  geom_quasirandom(dodge.width = .6, alpha = .5, varwidth = TRUE ) +
  annotate("text", x=2016, y=370000, label="Chief of Police: $368,883", hjust=.1, size=3.5 ) +
  scale_color_manual(values=wfp_colour_scale_bold) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(0, 400000),
    labels = function(x) {
      ifelse(x == 400000, paste("$", comma(x), sep = ""), comma(x))
    }
  ) +
  labs(
    title = wrap_text("Departmental distribution of employees on the City of Winnipeg salary disclosure list", 65),
    subtitle = "Salary above $75,000",
    colour="",
    fill="",
    x="",
    y="",
    caption=toupper(paste(
      "WINNIPEG FREE PRESS — SOURCE: City of winnipeg"
    ))
  ) +
  minimal_theme()
# +
#   theme(
#     legend.position=c(.8, 1.05),
#     legend.justification=c("right", "top"),
#     legend.box.just="right",
#     legend.margin=margin(10, 10, 10, 10)
#   )



wfp_winnipeg_salary_disclosure <- prepare_plot(p_winnipeg_salary_disclosure)
ggsave_pngpdf(wfp_winnipeg_salary_disclosure, "wfp_winnipeg_salary_disclosure", width_var=8.66, height_var=6, dpi_var=300, scale_var=1, units_var="in")


