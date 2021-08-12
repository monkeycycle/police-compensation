
plot_wps_per_capita_annual <- ggplot(wps_per_capita_cost, aes(x = year_date, y = per_capita_cost, label=per_capita_cost)) +
  geom_bar(colour = 'white', fill=wfp_blue, stat = 'identity') +
  geom_text(aes(label=paste("$", round(per_capita_cost, 2), sep='')),
                stat="identity",
                position = "identity",
                size=4, hjust = .5, vjust = -1,
                color="#222222"
            ) +
  scale_x_date(date_breaks = "1 year", labels = date_format("%Y")) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 1000)) +
  labs(
    title = "Annual per capita costs for Winnipeg Police Service",
    subtitle = "Dollars",
    caption = toupper(paste("WINNIPEG FREE PRESS — SOURCE: Winnipeg Police Service ", sep="")),
    x = "",
    y = ""
  ) +
  minimal_theme()


plot_wps_per_capita_pct_change <- ggplot(wps_per_capita_cost, aes(x = year_date, y = pct_change)) +
  geom_line( colour=nominalMuted_shade_0, fill=nominalMuted_shade_0, stat = 'identity', size=1) +
  geom_point( colour=wfp_blue, fill=wfp_blue, stat = 'identity', size=2) +
  geom_text(data=wps_per_capita_cost,
                aes(label=ifelse(is.na(pct_change), "", paste(round(pct_change, digits = 2), "%", sep=""))),
                size=4, hjust = .5, vjust = -1,
                position = "identity",
                color="#222222"
            ) +
  scale_y_continuous(expand = c(0, 0), limits = c(-15, 15)) +
  labs(
    title = "Percentage change in per capita costs for Winnipeg Police Service",
    subtitle = "",
    caption = toupper(paste("WINNIPEG FREE PRESS — SOURCE: Winnipeg Police Service ", sep="")),
    x = "",
    y = ""
  ) +
  minimal_theme()



wfp_wps_per_capita_annual <- prepare_plot(plot_wps_per_capita_annual)
write_plot(wfp_wps_per_capita_annual, filename = "wfp_wps_per_capita_annual",
           format = "png", width=10, height=7, units="in", dpi=320, limitsize = TRUE)

wfp_wps_per_capita_pct_change <- prepare_plot(plot_wps_per_capita_pct_change)
write_plot(wfp_wps_per_capita_pct_change, filename = "wfp_wps_per_capita_pct_change",
           format = "png", width=10, height=7, units="in", dpi=320, limitsize = TRUE)
