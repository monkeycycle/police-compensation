

p_winnipeg_wps_wfps_annual_budgets <- ggplot(winnipeg_wps_wfps_annual_budgets) +
  aes(x = year_date, y = wps_millions) +
  geom_line(
    aes(x = year_date, y = wps_millions),
    size = 1,
    colour = wfp_blue
  ) +
  geom_line(
    aes(x = year_date, y = wfps_millions),
    size = 1,
    colour = nominalBold_shade_1
  ) +
  geom_text(
    data = winnipeg_wps_wfps_annual_budgets %>% filter(year == max(year)),
    aes(x = as.Date("2019-10-01"), y = wps_millions, label = paste("WPS", "\n", "$", wps_millions, "M", sep = "")),
    vjust = -.3, hjust=1
  ) +
  geom_text(
    data = winnipeg_wps_wfps_annual_budgets %>% filter(year == max(year)),
    aes(x = as.Date("2019-10-01"), y = wfps_millions, label = paste("WFPS", "\n", "$", wfps_millions, "M", sep = "")),
    vjust = 1.45, hjust=1
  ) +
  scale_x_date(
    expand=c(0, 0),
    limits=as.Date(c("2011-01-01", "2031-01-01")),
    date_breaks="2 year",
    labels=date_format("%Y")
  ) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(0, 500),
    labels = function(x) {
      ifelse(x == 500, paste("$", x, "M", sep = ""), x)
    }
  ) +
  labs(
    title = "Annual budget for WPS and WFPS",
    subtitle = "Millions of dollars",
    x="",
    y="",
    caption=toupper(paste(
      "WINNIPEG FREE PRESS — SOURCE: City of Winnipeg annual budgets"
    ))

  ) +
  minimal_theme()


############################################################
# Forecast
############################################################
p_winnipeg_wps_wfps_annual_budgets_forecast <- p_winnipeg_wps_wfps_annual_budgets +
  annotate("text", x=as.Date("2020-01-01"), y=485, label="Forecast", hjust=-.1 ) +
  geom_segment(aes(x = as.Date("2020-01-01"), xend = as.Date("2020-01-01"), y=0, yend = 500), size = .5, lineend = "butt", colour="#c9c9c9") +
  annotate("rect", xmin = as.Date("2020-01-01"), xmax = as.Date("2031-01-01"), ymin = 0, ymax = 500,
               alpha = .3, fill="#c9c9c9") +

  geom_line(
    data=df_tbats_wps,
    aes(x = year_date, y = point_forecast),
    size = .5,
    alpha=.6,
    colour = wfp_blue,
    linetype="solid"
  ) +
    geom_line(
      data=df_tbats_wfps,
      aes(x = year_date, y = point_forecast),
      size = .5,
      alpha=.6,
      colour = nominalMuted_shade_1,
      linetype="solid"
    ) +
    geom_line(
      data=df_tbats_wps,
      aes(x = year_date, y = lo_80),
      size = .5,
      alpha=.6,
      colour = wfp_blue,
      linetype="solid"
    ) +
    geom_line(
      data=df_tbats_wps,
      aes(x = year_date, y = hi_80),
      size = .5,
      alpha=.6,
      colour = wfp_blue,
      linetype="solid"
    ) +

    geom_line(
      data=df_tbats_wfps,
      aes(x = year_date, y = lo_80),
      size = .5,
      alpha=.6,
      colour = nominalMuted_shade_1,
      linetype="solid"
    ) +
    geom_line(
      data=df_tbats_wfps,
      aes(x = year_date, y = hi_80),
      size = .5,
      alpha=.6,
      colour = nominalMuted_shade_1,
      linetype="solid"
    ) +
    geom_line(
      data=df_tbats_wps,
      aes(x = year_date, y = lo_95),
      size = .5,
      alpha=.6,
      colour = wfp_blue,
      linetype="solid"
    ) +
    geom_line(
      data=df_tbats_wps,
      aes(x = year_date, y = hi_95),
      size = .5,
      alpha=.6,
      colour = wfp_blue,
      linetype="solid"
    ) +

    geom_line(
      data=df_tbats_wfps,
      aes(x = year_date, y = lo_95),
      size = .5,
      alpha=.6,
      colour = nominalMuted_shade_1,
      linetype="solid"
    ) +
    geom_line(
      data=df_tbats_wfps,
      aes(x = year_date, y = hi_95),
      size = .5,
      alpha=.6,
      colour = nominalMuted_shade_1,
      linetype="solid"
    )


wfp_winnipeg_wps_wfps_annual_budgets <- prepare_plot(p_winnipeg_wps_wfps_annual_budgets)
ggsave_pngpdf(wfp_winnipeg_wps_wfps_annual_budgets, "wfp_winnipeg_wps_wfps_annual_budgets", width_var=8.66, height_var=6, dpi_var=300, scale_var=1, units_var="in")

wfp_winnipeg_wps_wfps_annual_budgets_forecast <- prepare_plot(p_winnipeg_wps_wfps_annual_budgets_forecast)
ggsave_pngpdf(wfp_winnipeg_wps_wfps_annual_budgets_forecast, "wfp_winnipeg_wps_wfps_annual_budgets_forecast", width_var=8.66, height_var=6, dpi_var=300, scale_var=1, units_var="in")
