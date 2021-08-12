
plot_wps_officers_diversity_vismin <- ggplot(wps_officers_diversity_vismin_tall) +
  aes(x = year_date, y=value, fill = name, group = name, weight = value) +
  geom_col(alpha=1) +

  geom_text(data=data=wps_officers_diversity_vismin_tall %>% filter(year_date == as.Date("2019-01-01")),
  aes(
    x = year_date, y = value,
    label = value
  ),
  fontface="bold",
  hjust = 1, vjust = 0,
  size = 4, color = "#222222"
) +

  # geom_text(data=wps_officers_diversity_vismin_tall %>% filter(year_date == as.Date("2019-01-01")),
  #               aes(x = year_date, y=value, label=x = year_date, y=value),
  #               fontface="bold",
  #               hjust = 1, vjust = 0,
  #               size = 4, color = "#222222"
  #
  #           ) +
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


plot_wps_officers_diversity_gender <- ggplot(wps_officers_diversity_gender_tall) +
  aes(x = year_date, y=value, fill = name, group = name, weight = value) +
  geom_col(alpha=1) +
  scale_x_date(date_breaks = "1 year", labels = date_format("%Y")) +
  scale_y_continuous(expand = c(0, 0),
    labels = function(x) {
      ifelse(x == 100, paste(x, "%", sep = ""), x)
    }
  ) +
  scale_fill_manual(
    values = c(
      female_pct =  nominalMuted_shade_1,
      male_pct =  nominalMuted_shade_0,
      labels = c("Female", "Male")
    ),
  ) +
  labs(
    title = "Gender diversity of sworn officers as a percentage",
    subtitle = " ",
    caption = toupper(paste("WINNIPEG FREE PRESS — SOURCE: Winnipeg Police Service ", sep="")),
    x = "",
    y = "",
    fill = "Gender"
  ) +
  minimal_theme() +
  theme(legend.position = "right")


wfp_wps_officers_diversity_vismin <- prepare_plot(plot_wps_officers_diversity_vismin)
write_plot(wfp_wps_officers_diversity_vismin, filename = "wfp_wps_officers_diversity_vismin",
           format = "png", width=10, height=7, units="in", dpi=320, limitsize = TRUE)

wfp_wps_officers_diversity_gender <- prepare_plot(plot_wps_officers_diversity_gender)
write_plot(wfp_wps_officers_diversity_gender, filename = "wfp_wps_officers_diversity_gender",
          format = "png", width=10, height=7, units="in", dpi=320, limitsize = TRUE)
