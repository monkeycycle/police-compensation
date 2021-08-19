
p_winnipeg_wps_annual_reports__change <- ggplot(winnipeg_wps_annual_reports) +
  aes(x = year_date, y = tax_supported_expenses_pct_chg) +
  geom_line(
    aes(x = year_date, y = tax_supported_expenses_pct_chg),
    size = 1,
    colour = wfp_blue
  ) +
  geom_line(
    aes(x = year_date, y = per_capita_cost_pct_chg),
    size = 1,
    colour = nominalBold_shade_1
  ) +
  geom_line(
    aes(x = year_date, y = inflation_rate),
    size = .5,
    colour = "#999999",
    linetype = "dashed"
  ) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == min(year)),
    aes(x = as.Date("2012-09-01"), y = inflation_rate - 1, label = paste("Inflation rate", sep = "")),
    vjust = -.05
  ) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == max(year)),
    aes(x = year_date, y = tax_supported_expenses_pct_chg, label = paste("Tax-supported expenses", "\n", format(tax_supported_expenses_pct_chg, digits = 2), "%", sep = "")),
    vjust = -1, hjust=1
  ) +
  geom_text(
    data = winnipeg_wps_annual_reports %>% filter(year == max(year)),
    aes(x = year_date, y = per_capita_cost_pct_chg, label = paste("Per capita cost", "\n", format(per_capita_cost_pct_chg, digits = 2), "%", sep = "")),
    vjust = 1.5, hjust=1
  ) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(-5, 20),
    labels = function(x) {
      ifelse(x == 20, paste(x, "%", sep = ""), x)
    }
  ) +
  scale_x_date(
    expand=c(0, 0),
    limits=as.Date(c("2012-01-01", "2020-01-01")),
    date_breaks="2 year",
    labels=date_format("%Y")
  ) +
  minimal_theme() +
  labs(
    title = "Percentage change in tax-supported costs for the WPS",
    subtitle = "",
    x="",
    y="",
    colour="",
    caption=toupper(paste("Winnipeg Free Press", " — SOURCE: Statistics Canada", sep=""))
  )


wfp_winnipeg_wps_annual_reports__change <- prepare_plot(p_winnipeg_wps_annual_reports__change)
ggsave_pngpdf(wfp_winnipeg_wps_annual_reports__change, "wfp_winnipeg_wps_annual_reports__change", width_var=8.66, height_var=6, dpi_var=300, scale_var=1, units_var="in")

