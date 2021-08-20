
df_crime <- winnipeg_wps_annual_reports %>%
  select(
    year_date,
    violent_crimes_total,
    property_crimes_total,
    other_crimes_total,
    traffic_offences,
    cdsa_total,
    ycja_total
  ) %>%
  pivot_longer(-year_date,
               names_to="type",
               values_to="count"
  ) %>%
  mutate(
    # count = format(count, digits=0),
    type = case_when(
      type == "violent_crimes_total" ~ "Violent crime",
      type == "property_crimes_total" ~ "Property crime",
      type == "other_crimes_total" ~ "Other crime",
      type == "traffic_offences" ~ "Traffic crime",
      type == "cdsa_total" ~ "Drug crime",
      type == "ycja_total" ~ "Youth crime"
    )
  )

p_winnipeg_wps_annual_reports__crime_facet <- ggplot(df_crime) +
  geom_line(aes(x = year_date, y = count), colour = wfp_blue, size = 1, alpha=.7) +
  geom_point(data=df_crime %>% filter(year_date == max(year_date) ), aes(x = year_date, y = count), colour = wfp_blue, size = 2, alpha=1) +
  geom_text(
    data = df_crime %>% filter(year_date == max(year_date)),
    aes(x = as.Date("2011-10-01"), y = 55000, label = paste("2020: ", format(count, digits=0, big.mark=","), sep = "")),
    vjust = .5, hjust=.01
  ) +
  scale_x_date(expand = c(0, 0),
               date_breaks = "4 years", labels = date_format("%Y"),
               limits=as.Date(c("2011-01-01", "2026-01-01"))) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(-100, 60000),
    labels = scales::comma
  ) +
  minimal_theme() +
  labs(
    title = wrap_text("Reported crimes in Winnipeg", 65),
    colour="",
    fill="",
    x="",
    y="",
    caption=toupper(paste(
      "WINNIPEG FREE PRESS — SOURCE: Winnipeg Police Service"
    ))
  ) +
  theme(
    strip.background=ggplot2::element_blank(),
    strip.text=ggplot2::element_text(size=12, hjust=0, face="bold"),
    panel.border=ggplot2::element_blank(),
    # legend.position=c(.8, 1.05),
    legend.justification=c("right", "top")
    # legend.box.just="right",
    # legend.margin=margin(10, 10, 10, 10)
  ) +
  facet_wrap(.~type, nrow=2)


wfp_winnipeg_wps_annual_reports__crime_facet <- prepare_plot(p_winnipeg_wps_annual_reports__crime_facet)
ggsave_pngpdf(wfp_winnipeg_wps_annual_reports__crime_facet, "wfp_winnipeg_wps_annual_reports__crime_facet", width_var=8.66, height_var=6, dpi_var=300, scale_var=1, units_var="in")

