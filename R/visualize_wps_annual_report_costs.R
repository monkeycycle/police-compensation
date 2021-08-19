
p_winnipeg_wps_annual_reports__costs <- ggplot(winnipeg_wps_annual_reports) +
  aes(x = year_date, y = per_capita_cost) +
  geom_line(
    aes(x = year_date, y = per_capita_cost),
    size = 1,
    colour = wfp_blue,
    alpha=.6
  ) +
  geom_point(data=winnipeg_wps_annual_reports %>% filter(year_date == max(year_date)),
    aes(x = year_date, y = per_capita_cost),
    size = 2,
    colour = wfp_blue,
    alpha=1
  ) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == min(year)),
    aes(x = year_date, y = per_capita_cost, label = paste(year, "\n", "$", per_capita_cost, sep = "")),
    vjust = 1.4
  ) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == max(year)),
    aes(x = year_date, y = per_capita_cost, label = paste(year, "\n", "$", per_capita_cost, sep = "")),
    vjust = -.5
  ) +
  scale_x_date(date_breaks = "1 year", labels = date_format("%Y")) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(0, 500),
    labels = function(x) {
      ifelse(x == 500, paste("$", x, sep = ""), x)
    }
  ) +
  minimal_theme() +
  labs(
    title = "Per capita costs for the Winnipeg Police Service",
    subtitle = "Dollars",
    y="",
    x="",
    caption=toupper(paste("Winnipeg Free Press", " — SOURCE: Winnipeg Police Service", ""))
  )


wfp_winnipeg_wps_annual_reports__costs <- prepare_plot(p_winnipeg_wps_annual_reports__costs)
ggsave_pngpdf(wfp_winnipeg_wps_annual_reports__costs, "wfp_winnipeg_wps_annual_reports__costs", width_var=8.66, height_var=6, dpi_var=300, scale_var=1, units_var="in")
