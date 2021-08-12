
plot_wps_authorized_officers <- ggplot(wps_authorized_actual_officers, aes(x = year_date, y = total_authorized_police_members, label=total_authorized_police_members)) +
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
    title = "Number of authorized officers in the Winnipeg Police Service",
    subtitle = "",
    caption = toupper(paste("WINNIPEG FREE PRESS — SOURCE: Winnipeg Police Service ", sep="")),
    x = "",
    y = ""
  ) +
  minimal_theme()


plot_wps_authorized_officers_pct_chg <- ggplot(wps_authorized_actual_officers, aes(x = year_date, y = pct_change_authorized, label=pct_change_authorized)) +
  geom_line( colour=nominalMuted_shade_0, fill=nominalMuted_shade_0, stat = 'identity', size=1) +
  geom_point( colour=wfp_blue, fill=wfp_blue, stat = 'identity', size=2) +
  geom_text(data=wps_authorized_actual_officers,
                # aes(label=ifelse(is.na(pct_change_authorized), "", paste(round(pct_change_authorized, digits = 2), "%", sep=""))),
                stat="identity",
                position="identity",
                size=4, hjust = .5, vjust = -1,
                color="#222222"
            ) +
  scale_y_continuous(expand = c(0, 0), limits = c(-10, 10)) +
  labs(
    title = "Year-over-year percentage change in the number of Winnipeg Police Service authorized officers",
    subtitle = "",
    caption = toupper(paste("WINNIPEG FREE PRESS — SOURCE: Winnipeg Police Service ", sep="")),
    x = "",
    y = ""
  ) +
  minimal_theme()

wfp_wps_authorized_officers <- prepare_plot(plot_wps_authorized_officers)
write_plot(wfp_wps_authorized_officers, filename = "wfp_wps_authorized_officers",
           format = "png", width=10, height=7, units="in", dpi=320, limitsize = TRUE)

wps_wps_authorized_officers_pct_chg <- prepare_plot(plot_wps_authorized_officers_pct_chg)
write_plot(wps_wps_authorized_officers_pct_chg, filename = "wps_wps_authorized_officers_pct_chg",
           format = "png", width=10, height=7, units="in", dpi=320, limitsize = TRUE)
