
p_winnipeg_wps_annual_reports__crime <- ggplot(winnipeg_wps_annual_reports) +
  geom_line(aes(x = year_date, y = violent_crimes_total), colour = nominalMuted_shade_0, size = .5) +
  geom_line(aes(x = year_date, y = property_crimes_total), colour = nominalMuted_shade_1, size = .5) +
  geom_line(aes(x = year_date, y = other_crimes_total), colour = nominalMuted_shade_2, size = .5) +
  geom_line(aes(x = year_date, y = traffic_offences), colour = nominalMuted_shade_3, size = .5) +
  geom_line(aes(x = year_date, y = cdsa_total), colour = nominalMuted_shade_4, size = .5) +
  geom_line(aes(x = year_date, y = ycja_total), colour = "393939", size = .5) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == max(year)),
    aes(x = year_date, y = violent_crimes_total, label = paste("Violent \ncrimes", sep = "")),
    vjust = -.5
  ) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == max(year)),
    aes(x = year_date, y = property_crimes_total, label = paste("Property \ncrimes", sep = "")),
    vjust = -.5
  ) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == max(year)),
    aes(x = year_date, y = other_crimes_total, label = paste("Other crimes", sep = "")),
    vjust = -.5
  ) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == max(year)),
    aes(x = year_date, y = traffic_offences, label = paste("Traffic offences", sep = "")),
    vjust = -1
  ) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == max(year)),
    aes(x = year_date, y = cdsa_total, label = paste("CDSA", sep = "")),
    vjust = .5
  ) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == max(year)),
    aes(x = year_date, y = ycja_total, label = paste("YCJA", sep = "")),
    vjust = 1
  ) +


  # geom_text(data=winnipeg_wps_annual_reports %>% filter(year==max(year)),
  #           aes(x = year_date, y = police_initiated_displatched_events, label=paste("Police-initiated\ndisplatched events", sep="")),
  #           vjust=.5
  #           ) +

  scale_y_continuous(
    expand = c(0, 0),
    limits = c(-1000, 75000),
    labels = scales::comma
  ) +
  minimal_theme() +
  labs(
    title = "WPS crime",
    subtitle = "Number of incidents"
  )

wfp_winnipeg_wps_annual_reports__crime <- prepare_plot(p_winnipeg_wps_annual_reports__crime)
ggsave_pngpdf(wfp_winnipeg_wps_annual_reports__crime, "wfp_winnipeg_wps_annual_reports__crime", width_var=8.66, height_var=6, dpi_var=300, scale_var=1, units_var="in")

