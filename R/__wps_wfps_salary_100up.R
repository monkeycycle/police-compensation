

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
  filter(compensation >= 150000 & compensation <=200000 ) %>%
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
  wps_wfps_salary_disclosure_all,
  wps_wfps_salary_disclosure_all_100_150,
  by=c("department"="department", "year"="year")
)

wps_wfps_sixfigure <- left_join(
  wps_wfps_sixfigure,
  wps_wfps_salary_disclosure_all_150_200,
  by=c("department"="department", "year"="year")
)

wps_wfps_sixfigure <- left_join(
  wps_wfps_sixfigure,
  wps_wfps_salary_disclosure_all_200plus,
  by=c("department"="department", "year"="year")
)


p_wps_wfps_6figure_salary <- ggplot(wps_wfps_sixfigure) +
  geom_bar(data=wps_wfps_salary_disclosure_all, stat="identity",aes(x=year, y=all_disclosed), fill="#999999") +
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
  minimal_theme() +
  theme(
    strip.background=ggplot2::element_blank(),
    strip.text=ggplot2::element_text(size=12, hjust=0, face="bold"),
    panel.border=ggplot2::element_blank(),
    # legend.position=c(.8, 1.05),
    legend.justification=c("right", "top")
    # legend.box.just="right",
    # legend.margin=margin(10, 10, 10, 10)
  ) +
  facet_wrap(.~department, ncol=2)

plot(p_wps_wfps_6figure_salary)

