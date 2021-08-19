
p_winnipeg_wps_annual_reports__clearance <- ggplot(winnipeg_wps_annual_reports) +
  geom_line(aes(x = year_date, y = violent_crimes_clearance_rate_pct), colour = nominalMuted_shade_0, size = 1) +
  geom_line(aes(x = year_date, y = property_crimes_clearance_rate_pct), colour = nominalMuted_shade_1, size = 1) +
  geom_line(aes(x = year_date, y = other_crimes_clearance_rate_pct), colour = nominalMuted_shade_2, size = 1) +
  geom_line(aes(x = year_date, y = cdsa_clearance_rate_pct), colour = nominalMuted_shade_3, size = 1) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == max(year)),
    aes(x = year_date, y = violent_crimes_clearance_rate_pct, label = paste("Violent \ncrimes", sep = "")),
    vjust = .5
  ) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == max(year)),
    aes(x = year_date, y = property_crimes_clearance_rate_pct, label = paste("Property \ncrimes", sep = "")),
    vjust = .5
  ) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == max(year)),
    aes(x = year_date, y = other_crimes_clearance_rate_pct, label = paste("Other crimes", sep = "")),
    vjust = -2
  ) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == max(year)),
    aes(x = year_date, y = cdsa_clearance_rate_pct, label = paste("CDSA", sep = "")),
    vjust = 2.5
  ) +


  # geom_text(data=winnipeg_wps_annual_reports %>% filter(year==max(year)),
  #           aes(x = year_date, y = police_initiated_displatched_events, label=paste("Police-initiated\ndisplatched events", sep="")),
  #           vjust=.5
  #           ) +

  scale_y_continuous(
    expand = c(0, 0),
    limits = c(0, 120),
    labels = scales::comma
  ) +
  minimal_theme() +
  labs(
    title = "WPS clearance rates",
    subtitle = "Percentage"
  )



wfp_winnipeg_wps_annual_reports__clearance <- prepare_plot(p_winnipeg_wps_annual_reports__clearance)
ggsave_pngpdf(wfp_winnipeg_wps_annual_reports__clearance, "wfp_winnipeg_wps_annual_reports__clearance", width_var=8.66, height_var=6, dpi_var=300, scale_var=1, units_var="in")

