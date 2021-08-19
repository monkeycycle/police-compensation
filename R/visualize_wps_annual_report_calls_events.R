
p_winnipeg_wps_annual_reports__calls_events <- ggplot(winnipeg_wps_annual_reports) +
  aes(x = year_date, y = calls_to_communication_centre) +
  geom_line(
    aes(x = year_date, y = calls_to_communication_centre),
    size = .5,
    colour = "#999999",
    linetype = "dashed"
  ) +
  geom_line(
    aes(x = year_date, y = police_initiated_displatched_events),
    size = 1,
    colour = nominalMuted_shade_0
  ) +
  geom_line(
    aes(x = year_date, y = citizen_generated_dispatched_events),
    size = 1,
    colour = wfp_blue
  ) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == max(year)),
    aes(x = year_date, y = calls_to_communication_centre, label = paste("Calls to \ncommunication \ncentre", sep = "")),
    vjust = .25
  ) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == max(year)),
    aes(x = year_date, y = citizen_generated_dispatched_events, label = paste("Citizen-generated\ndispatched events", sep = "")),
    vjust = -.5
  ) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == max(year)),
    aes(x = year_date, y = police_initiated_displatched_events, label = paste("Police-initiated\ndisplatched events", sep = "")),
    vjust = .5
  ) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(-10, 1000000),
    labels = scales::comma
  ) +
  minimal_theme() +
  labs(
    title = "WPS calls and events",
    subtitle = ""
  )



wfp_winnipeg_wps_annual_reports__calls_events <- prepare_plot(p_winnipeg_wps_annual_reports__calls_events)
ggsave_pngpdf(wfp_winnipeg_wps_annual_reports__calls_events, "wfp_winnipeg_wps_annual_reports__calls_events", width_var=8.66, height_var=6, dpi_var=300, scale_var=1, units_var="in")


