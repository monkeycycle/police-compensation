
p_statcan_crime_severity_index <- ggplot(statcan_crimeseverityindex_tall) +
  aes(
    x = reference_period,
    y = value,
    colour = csi,
    group = csi
  ) +
  geom_line(size = 0.5) +
  scale_color_hue(direction = 1) +
  minimal_theme() +
  labs(
    title="Crime Severity Index in select Canadian cities",
    caption=toupper(paste("Winnipeg Free Press", " — SOURCE: Statistics Canada", sep=""))
  ) +
  theme(
    strip.background=ggplot2::element_blank(),
    strip.text=ggplot2::element_text(size=12, hjust=0, face="bold"),
    panel.border=ggplot2::element_blank()
  ) +
  facet_wrap(vars(geography))




wfp_statcan_crime_severity_index <- prepare_plot(p_statcan_crime_severity_index)
ggsave_pngpdf(wfp_statcan_crime_severity_index, "wfp_statcan_crime_severity_index", width_var=8.66, height_var=6, dpi_var=300, scale_var=1, units_var="in")


