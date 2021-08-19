
p_statcan_crime_clearance <- ggplot(statcan_crimeclearance_tall) +
  aes(
    x = reference_period,
    y = value,
    colour = clearance,
    group = clearance
  ) +
  geom_line(size = 1) +
  scale_color_manual(values=wfp_colour_scale_bold) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 100), breaks=seq(0,100,50),
                     labels = function(x) {
                       ifelse(x == 100, paste(x, "%", sep = ""), x)
                     }) +
  scale_x_continuous(expand = c(0, 0), limits = c(2010, 2020)) +
  minimal_theme() +
  labs(
    title="Weighted clearance rates in select Canadian cities",
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


wfp_statcan_crime_clearance <- prepare_plot(p_statcan_crime_clearance)
ggsave_pngpdf(wfp_statcan_crime_clearance, "wfp_statcan_crime_clearance", width_var=8.66, height_var=8.66, dpi_var=300, scale_var=1, units_var="in")


