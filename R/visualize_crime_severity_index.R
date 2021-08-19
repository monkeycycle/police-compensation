
p_statcan_crime_severity_index <- ggplot(statcan_crimeseverityindex_tall) +
  aes(
    x = reference_period,
    y = value,
    colour = csi,
    group = csi
  ) +
  geom_line(size = .5) +
  scale_color_manual(values=wfp_colour_scale_bold) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 200), breaks=seq(0,200,100)) +
  scale_x_continuous(expand = c(0, 0), limits = c(2010, 2020)) +
  minimal_theme() +
  labs(
    title="Crime Severity Index in select Canadian cities",
    x="",
    y="",
    colour="",
    caption=toupper(paste("Winnipeg Free Press", " — SOURCE: Statistics Canada", sep=""))
  ) +
  theme(
    strip.background=ggplot2::element_blank(),
    strip.text=ggplot2::element_text(size=12, hjust=0, face="bold"),
    panel.border=ggplot2::element_blank(),
    # legend.position=c(.8, 1.05),
    legend.justification=c("right", "top")
    # legend.box.just="right",
    # legend.margin=margin(10, 10, 10, 10)
  ) +
  facet_wrap(vars(geography), ncol=3)




wfp_statcan_crime_severity_index <- prepare_plot(p_statcan_crime_severity_index)
ggsave_pngpdf(wfp_statcan_crime_severity_index, "wfp_statcan_crime_severity_index", width_var=8.66, height_var=6, dpi_var=300, scale_var=1, units_var="in")


