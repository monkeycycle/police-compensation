
p_winnipeg_wps_annual_reports__change <- ggplot(winnipeg_wps_annual_reports) +
  aes(x = year_date, y = tax_supported_expenses_pct_chg) +
  geom_line(
    aes(x = year_date, y = tax_supported_expenses_pct_chg),
    size = .5,
    colour = wfp_blue
  ) +
  geom_line(
    aes(x = year_date, y = per_capita_cost_pct_chg),
    size = .5,
    colour = nominalMuted_shade_0
  ) +
  geom_line(
    aes(x = year_date, y = inflation_rate),
    size = .5,
    colour = "#999999",
    linetype = "dashed"
  ) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == min(year)),
    aes(x = year_date, y = inflation_rate, label = paste("Inflation rate", sep = "")),
    vjust = -1
  ) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == max(year)),
    aes(x = year_date, y = tax_supported_expenses_pct_chg, label = paste("Tax-supported expenses", "\n", format(tax_supported_expenses_pct_chg, digits = 2), "%", sep = "")),
    vjust = -1
  ) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == max(year)),
    aes(x = year_date, y = per_capita_cost_pct_chg, label = paste("per capita cost", "\n", format(per_capita_cost_pct_chg, digits = 2), "%", sep = "")),
    vjust = 1
  ) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(-10, 20)
  ) +
  minimal_theme() +
  labs(
    title = "Percentage change in WPS tax-supported costing",
    subtitle = "Percentage"
  )


wfp_winnipeg_wps_annual_reports__change <- prepare_plot(p_winnipeg_wps_annual_reports__change)
ggsave_pngpdf(wfp_winnipeg_wps_annual_reports__change, "wfp_winnipeg_wps_annual_reports__change", width_var=8.66, height_var=6, dpi_var=300, scale_var=1, units_var="in")

