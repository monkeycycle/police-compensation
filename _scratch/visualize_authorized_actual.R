# wps_authorized_actual_officers_count_tall

plot_wps_authorized_actual_officers <- ggplot(wps_authorized_actual_officers_count_tall, aes(x = year_date, y = value, fill=name)) +
  geom_bar(position='dodge', stat = 'identity') +
  scale_x_date(date_breaks = "1 year", labels = date_format("%Y")) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 2000), label=comma) +
  scale_fill_manual(
    values = c(
      authorized =  nominalMuted_shade_1,
      actual =  nominalMuted_shade_0,
      labels = c("Authorized", "Actual")
    ),
  ) +
  labs(
    title = "Authorized and actual officers in the Winnipeg Police Service",
    subtitle = "",
    caption = toupper(paste("WINNIPEG FREE PRESS — SOURCE: Winnipeg Police Service ", sep="")),
    x = "",
    y = "",
    fill = "Authorized and actual"

  ) +
  minimal_theme() +
  theme(legend.position = "right")




wfp_wps_authorized_actual_officers <- prepare_plot(plot_wps_authorized_actual_officers)
write_plot(plot_wps_authorized_actual_officers, filename = "wfp_wps_authorized_actual_officers",
           format = "png", width=10, height=7, units="in", dpi=320, limitsize = TRUE)
