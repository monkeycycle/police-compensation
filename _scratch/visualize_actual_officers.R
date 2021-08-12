
plot_wps_actual_officers <- ggplot(wps_authorized_actual_officers, aes(x = year_date, y = sworn_total_actual, label=sworn_total_actual)) +
  geom_bar(colour = 'white', fill=wfp_blue, stat = 'identity') +
  geom_text(data=wps_authorized_actual_officers,
                stat="identity",
                position = "identity",
                size=4, hjust = .5, vjust = -1,
                color="#222222"
            ) +
  scale_x_date(date_breaks = "1 year", labels = date_format("%Y")) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 2000), label=comma) +
  labs(
    title = "Number of actual officers in the Winnipeg Police Service",
    subtitle = "",
    caption = toupper(paste("WINNIPEG FREE PRESS — SOURCE: Winnipeg Police Service ", sep="")),
    x = "",
    y = ""
  ) +
  minimal_theme()


plot_wps_actual_officers_pct_chg <- ggplot(wps_authorized_actual_officers, aes(x = year_date, y = pct_change_actual, label=pct_change_actual)) +
  geom_line( colour=nominalMuted_shade_0, fill=nominalMuted_shade_0, stat = 'identity', size=1) +
  geom_point( colour=wfp_blue, fill=wfp_blue, stat = 'identity', size=2) +
  geom_text(data=wps_authorized_actual_officers,
                stat="identity",
                position="identity",
                size=4, hjust = .5, vjust = -1,
                color="#222222"
            ) +
  scale_y_continuous(expand = c(0, 0), limits = c(-10, 10)) +
  labs(
    title = "Year-over-year percentage change in the number of Winnipeg Police Service actual officers",
    subtitle = "",
    caption = toupper(paste("WINNIPEG FREE PRESS — SOURCE: Winnipeg Police Service ", sep="")),
    x = "",
    y = ""
  ) +
  minimal_theme()

wfp_wps_actual_officers <- prepare_plot(plot_wps_actual_officers)
write_plot(wfp_wps_actual_officers, filename = "wfp_wps_actual_officers",
           format = "png", width=10, height=7, units="in", dpi=320, limitsize = TRUE)

wps_wps_actual_officers_pct_chg <- prepare_plot(plot_wps_actual_officers_pct_chg)
write_plot(wps_wps_actual_officers_pct_chg, filename = "wps_wps_actual_officers_pct_chg",
           format = "png", width=10, height=7, units="in", dpi=320, limitsize = TRUE)
