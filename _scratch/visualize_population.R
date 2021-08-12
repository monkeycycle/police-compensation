

plot_wps_population <- ggplot(wps_winnipeg_population_budget, aes(x = year_date, y = population, label=population)) +
  geom_bar(colour = 'white', fill=wfp_blue, stat = 'identity') +
  geom_text(
                aes(label=comma(population)),
                # stat="identity",
                position = "identity",
                size=4, hjust = .5, vjust = -1,
                color="#222222"
            ) +
  scale_x_date(date_breaks = "1 year", labels = date_format("%Y")) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 1000000), label=comma) +
  labs(
    title = "Population for the City of Winnipeg",
    subtitle = "",
    caption = toupper(paste("WINNIPEG FREE PRESS — SOURCE: Winnipeg Police Service ", sep="")),
    x = "",
    y = ""
  ) +
  minimal_theme()


plot_wps_population_pct_change <- ggplot(wps_winnipeg_population_budget, aes(x = year_date, y = population_pct_change)) +
  geom_line( color=wfp_blue, stat = 'identity', size=1) +
  geom_point( color=wfp_blue, fill=wfp_blue, stat = 'identity', size=2) +
  geom_text(data=wps_winnipeg_population_budget,
                aes(label=ifelse(is.na(population_pct_change), "", paste(round(population_pct_change, digits = 2), "%", sep=""))),
                size=4, hjust = .5, vjust = -1,
                position = "identity",
                color="#222222"
            ) +
  scale_x_date(date_breaks = "1 year", labels = date_format("%Y")) +
  scale_y_continuous(expand = c(0, 0), limits = c(-15, 20)) +
  labs(
    title = "Year over year percentage change of Winnipeg's population",
    subtitle = "",
    caption = toupper(paste("WINNIPEG FREE PRESS — SOURCE: Winnipeg Police Service ", sep="")),
    x = "",
    y = ""
  ) +
  minimal_theme() +
  theme(legend.position = "right")


wfp_wps_population <- prepare_plot(plot_wps_population)
write_plot(wfp_wps_population, filename = "wfp_wps_population",
           format = "png", width=10, height=7, units="in", dpi=320, limitsize = TRUE)

wfp_wps_population_pct_change <- prepare_plot(plot_wps_population_pct_change)
write_plot(wfp_wps_population_pct_change, filename = "wfp_wps_population_pct_change",
          format = "png", width=10, height=7, units="in", dpi=320, limitsize = TRUE)
