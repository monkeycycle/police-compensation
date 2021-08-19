
p_winnipeg_wps_annual_reports__crime <- ggplot(winnipeg_wps_annual_reports) +
  geom_line(aes(x = year_date, y = violent_crimes_total), colour = nominalBold_shade_0, size = 1) +
  geom_line(aes(x = year_date, y = property_crimes_total), colour = nominalBold_shade_1, size = 1) +
  geom_line(aes(x = year_date, y = other_crimes_total), colour = nominalBold_shade_2, size = 1) +
  geom_line(aes(x = year_date, y = traffic_offences), colour = nominalBold_shade_4, size = 1) +
  geom_line(aes(x = year_date, y = cdsa_total), colour = nominalBold_shade_3, size = 1) +
  geom_line(aes(x = year_date, y = ycja_total), colour = "393939", size = 1) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == max(year)),
    aes(x = as.Date("2020-01-01"), y = violent_crimes_total, label = paste("Violent crimes: ", comma(violent_crimes_total), " incidents in 2020", sep = "")),
     vjust = 0, hjust=-.05
  ) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == max(year)),
    aes(x = as.Date("2020-01-01"), y = property_crimes_total, label = paste("Property crimes: ", comma(property_crimes_total), " incidents in 2020", sep = "")),
    vjust = 0, hjust=-.05
  ) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == max(year)),
    aes(x = as.Date("2020-01-01"), y = other_crimes_total, label = paste("Other crimes: ", comma(other_crimes_total), " incidents in 2020", sep = "")),
    vjust = 0, hjust=-.05
  ) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == max(year)),
    aes(x = as.Date("2020-01-01"), y = traffic_offences, label = paste("Traffic, drug and youth offences", sep = "")),
    vjust = 0, hjust=-.05
  ) +
  scale_x_date(expand = c(0, 0),
               date_breaks = "2 year", labels = date_format("%Y"),
               limits=as.Date(c("2011-01-01", "2028-01-01"))) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(-1000, 75000),
    labels = scales::comma
  ) +
  minimal_theme() +
  labs(
    title = "Number of crimes reported in Winnipeg",
    colour="",
    fill="",
    x="",
    y="",
    caption=toupper(paste(
      "WINNIPEG FREE PRESS — SOURCE: Winnipeg Police Service"
    ))
  )

wfp_winnipeg_wps_annual_reports__crime <- prepare_plot(p_winnipeg_wps_annual_reports__crime)
ggsave_pngpdf(wfp_winnipeg_wps_annual_reports__crime, "wfp_winnipeg_wps_annual_reports__crime", width_var=8.66, height_var=6, dpi_var=300, scale_var=1, units_var="in")

