

p_winnipeg_wps_annual_reports__clearance <- ggplot(winnipeg_wps_annual_reports) +
  geom_line(aes(x = year_date, y = violent_crimes_clearance_rate_pct), colour = nominalBold_shade_0, size = 1) +
  geom_line(aes(x = year_date, y = property_crimes_clearance_rate_pct), colour = nominalBold_shade_1, size = 1) +
  geom_line(aes(x = year_date, y = other_crimes_clearance_rate_pct), colour = nominalBold_shade_2, size = 1) +
  geom_line(aes(x = year_date, y = cdsa_clearance_rate_pct), colour = nominalBold_shade_3, size = 1) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == max(year)),
    aes(x = as.Date("2020-01-01"), y = violent_crimes_clearance_rate_pct, label = paste("Violent crimes: ", violent_crimes_clearance_rate_pct, "% in 2020", sep = "")),
    vjust = 0, hjust=-.05
  ) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == max(year)),
    aes(x = as.Date("2020-01-01"), y = property_crimes_clearance_rate_pct, label = paste("Property crimes: ", property_crimes_clearance_rate_pct, "% in 2020", sep = "")),
    vjust = 0, hjust=-.05
  ) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == max(year)),
    aes(x = as.Date("2020-01-01"), y = other_crimes_clearance_rate_pct, label = paste("Other crimes: ", other_crimes_clearance_rate_pct, "% in 2020", sep = "")),
    vjust = 0, hjust=-.05
  ) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == max(year)),
    aes(x = as.Date("2020-01-01"), y = cdsa_clearance_rate_pct, label = paste("Drug crimes: ", cdsa_clearance_rate_pct, "% in 2020", sep = "")),
    vjust = 0, hjust=-.05
  ) +
  scale_x_date(expand = c(0, 0),
               date_breaks = "2 year", labels = date_format("%Y"),
               limits=as.Date(c("2011-01-01", "2026-01-01"))) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(0, 100),
    labels = function(x) {
      ifelse(x == 100, paste(x, "%", sep = ""), x)
    }
  ) +
  minimal_theme() +
  labs(
    title = wrap_text("Winnipeg Police Service clearance rates for reported crime incidents  in Winnipeg", 65),
    subtitle="",
    colour="",
    fill="",
    x="",
    y="",
    caption=toupper(paste(
      "WINNIPEG FREE PRESS — SOURCE: Winnipeg Police Service"
    ))
  )

wfp_winnipeg_wps_annual_reports__clearance <- prepare_plot(p_winnipeg_wps_annual_reports__clearance)
ggsave_pngpdf(wfp_winnipeg_wps_annual_reports__clearance, "wfp_winnipeg_wps_annual_reports__clearance", width_var=8.66, height_var=6, dpi_var=300, scale_var=1, units_var="in")


