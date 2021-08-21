

wps_wfps_salary_disclosure_all <- df_winnipeg_salary_disclosure %>%
  filter(
    department %in% c("Police Services", "Fire Paramedic Service")
  ) %>%
  group_by(department, year) %>%
  tally() %>%
  ungroup() %>%
  rename(
    all_disclosed = n
  )


wps_wfps_salary_disclosure_all_less100 <- df_winnipeg_salary_disclosure %>%
  filter(compensation < 100000) %>%
  filter(
    department %in% c("Police Services", "Fire Paramedic Service")
  ) %>%
  group_by(department, year) %>%
  tally() %>%
  ungroup() %>%
  rename(
    subset_less100 = n
  )

wps_wfps_salary_disclosure_all_100_150 <- df_winnipeg_salary_disclosure %>%
  filter(compensation >= 100000 & compensation <= 150000 ) %>%
  filter(
    department %in% c("Police Services", "Fire Paramedic Service")
  ) %>%
  group_by(department, year) %>%
  tally() %>%
  ungroup() %>%
  rename(
    subset_100_150K = n
  )


wps_wfps_salary_disclosure_all_150_200 <- df_winnipeg_salary_disclosure %>%
  filter(compensation >= 150000) %>%
  filter(
    department %in% c("Police Services", "Fire Paramedic Service")
  ) %>%
  group_by(department, year) %>%
  tally() %>%
  ungroup() %>%
  rename(
    subset_150_200K = n
  )


wps_wfps_salary_disclosure_all_200plus <- df_winnipeg_salary_disclosure %>%
  filter(compensation > 200000) %>%
  filter(
    department %in% c("Police Services", "Fire Paramedic Service")
  ) %>%
  group_by(department, year) %>%
  tally() %>%
  ungroup() %>%
  rename(
    subset_200plus = n
  ) %>%
  add_row(
    department = "Fire Paramedic Service",
    year = 2016,
    subset_200plus = 0
  ) %>%
  add_row(
    department = "Fire Paramedic Service",
    year = 2017,
    subset_200plus = 0
  )  %>%
  add_row(
    department = "Fire Paramedic Service",
    year = 2018,
    subset_200plus = 0
  )



wps_wfps_sixfigure <- left_join(
  wps_wfps_salary_disclosure_all_100_150,
  wps_wfps_salary_disclosure_all_150_200,
  by=c("department"="department", "year"="year")
) %>%
# left_join(
#   wps_wfps_salary_disclosure_all_200plus,
#   by=c("department"="department", "year"="year")
# ) %>%
left_join(
  wps_wfps_salary_disclosure_all_less100,
  by=c("department"="department", "year"="year")
) %>%
  pivot_longer(
    c(-year, -department),
    names_to="salary_group",
    values_to="count"
  ) %>%
  mutate(
    salary_group = gsub("subset_", "$", salary_group, fixed=TRUE),
    salary_group = gsub("_", "-", salary_group, fixed=TRUE),
    # salary_group = gsub("200plus", "200K or more", salary_group, fixed=TRUE),
    salary_group = gsub("$less100", "Less than $100K", salary_group, fixed=TRUE)
  ) %>%
  mutate(
    salary_group = factor(salary_group,
                          levels=c("$200K or more", "$150-200K", "$100-150K", "Less than $100K")
    )
  )


df_annotations <- data.frame(
  year = c(2020, 2020),
  label_str = c("Seven employees above $200,000", "Three employees above $200,000"),
  department   = c("Police Services", "Fire Paramedic Service"),
  count = c(1750, 1750)
)


p_wps_wfps_6figure_salary <- ggplot(wps_wfps_sixfigure) +
  geom_bar(data=wps_wfps_sixfigure, stat="identity",aes(x=year, y=count, fill=salary_group), colour="#ffffff", position="stack") +
  geom_text(
    data = df_annotations,
    aes(x = year, y = count, label = wrap_text(label_str, 13)), size=3.5
  ) +
  labs(
    title = wrap_text("Number of WPS and WFPS staff with salaries above $100,000", 65),
    colour="",
    fill="",
    x="",
    y="",
    caption=toupper(paste(
      "WINNIPEG FREE PRESS — SOURCE: City of Winnipeg"
    ))
  ) +
  # scale_x_date(expand = c(0, 0),
  #              date_breaks = "1 year", labels = date_format("%Y"),
  #              limits=as.Date(c("2016-01-01", "2020-01-01"))) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(0, 2000),
    labels = scales::comma
  ) +
  scale_fill_manual(values=wfp_colour_scale_bold) +
  minimal_theme() +
  theme(
    strip.background=ggplot2::element_blank(),
    strip.text=ggplot2::element_text(size=12, hjust=0, face="bold", margin=ggplot2::margin(0,0,20,0)),
    panel.border=ggplot2::element_blank(),
    # legend.position=c(.8, 1.05),
    legend.justification=c("left", "top")
    # legend.box.just="right",
    # legend.margin=margin(10, 10, 10, 10)
  ) +
  facet_wrap(.~department, ncol=2)


wfp_wps_wfps_6figure_salary <- prepare_plot(p_wps_wfps_6figure_salary)
ggsave_pngpdf(wfp_wps_wfps_6figure_salary, "wfp_wps_wfps_6figure_salary", width_var=8.66, height_var=6, dpi_var=300, scale_var=1, units_var="in")

