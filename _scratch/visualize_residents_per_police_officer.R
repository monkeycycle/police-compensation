
plot_wps_residents_per_police_officer <- ggplot(wps_residents_per_police_officer, aes(x = year_date, y = residents_per_police_officer, label=residents_per_police_officer)) +
  geom_bar(colour = 'white', fill=wfp_blue, stat = 'identity') +
  geom_text(aes(label=paste(round(residents_per_police_officer, 2), sep='')),
                stat="identity",
                position = "identity",
                size=4, hjust = .5, vjust = -1,
                color="#222222"
            ) +
  scale_x_date(date_breaks = "1 year", labels = date_format("%Y")) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 1000)) +
  labs(
    title = "Residents per police officer in the city of Winnipeg",
    subtitle = "Dollars",
    caption = toupper(paste("WINNIPEG FREE PRESS — SOURCE: Winnipeg Police Service ", sep="")),
    x = "",
    y = ""
  ) +
  minimal_theme()


plot_wps_residents_per_police_officer_pct_change <- ggplot(wps_residents_per_police_officer, aes(x = year_date, y = pct_change)) +
  geom_line( colour=nominalMuted_shade_0, fill=nominalMuted_shade_0, stat = 'identity', size=1) +
  geom_point( colour=wfp_blue, fill=wfp_blue, stat = 'identity', size=2) +
  geom_text(data=wps_residents_per_police_officer,
                aes(label=ifelse(is.na(pct_change), "", paste(round(pct_change, digits = 2), "%", sep=""))),
                size=4, hjust = .5, vjust = -1,
                position = "identity",
                color="#222222"
            ) +
  scale_y_continuous(expand = c(0, 0), limits = c(-15, 15)) +
  labs(
    title = "Percentage change in per police officer in the city of Winnipeg",
    subtitle = "",
    caption = toupper(paste("WINNIPEG FREE PRESS — SOURCE: Winnipeg Police Service ", sep="")),
    x = "",
    y = ""
  ) +
  minimal_theme()

wfp_wps_residents_per_police_officer <- prepare_plot(plot_wps_residents_per_police_officer)
write_plot(wfp_wps_residents_per_police_officer, filename = "wfp_wps_residents_per_police_officer",
           format = "png", width=10, height=7, units="in", dpi=320, limitsize = TRUE)

wfp_wps_residents_per_police_officer_pct_change <- prepare_plot(plot_wps_residents_per_police_officer_pct_change)
write_plot(wfp_wps_residents_per_police_officer_pct_change, filename = "wfp_wps_residents_per_police_officer_pct_change",
           format = "png", width=10, height=7, units="in", dpi=320, limitsize = TRUE)
