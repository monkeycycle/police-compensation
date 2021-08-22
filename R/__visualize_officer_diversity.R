
p_wps_officers_diversity_vismin <- ggplot(wps_officers_diversity_vismin_tall) +
  aes(x = year_date, y=value, fill = name, group = name, weight = value) +
  geom_col() +
  scale_x_date(date_breaks = "1 year", labels = date_format("%Y")) +
  scale_y_continuous(expand = c(0, 0),
                     labels = function(x) {
                       ifelse(x == 100, paste(x, "%", sep = ""), x)
                     }
  ) +
  scale_fill_manual(
    values = c(
      "not_declared_pct" =  "#c9c9c9",
      "caucasian_pct" =  nominalMuted_shade_0,
      "indigenous_pct" =  nominalMuted_shade_1,
      "visible_minorities_pct" =  nominalMuted_shade_2
    ),
    labels = c("Not declared", "Caucasian", "Indigenous", "Visible minorities")

  ) +
  labs(
    title = "Diversity of sworn officers as a percentage",
    subtitle = " ",
    caption = toupper(paste("WINNIPEG FREE PRESS — SOURCE: Winnipeg Police Service ", sep="")),
    x = "",
    y = "",
    fill = "Diversity/visibile minority"
  ) +
  minimal_theme() +
  theme(legend.position = "right")

wfp_wps_officers_diversity_vismin <- prepare_plot(p_wps_officers_diversity_vismin)
ggsave_pngpdf(wfp_wps_officers_diversity_vismin, "wfp_wps_officers_diversity_vismin", width_var=8.66, height_var=6, dpi_var=300, scale_var=1, units_var="in")
