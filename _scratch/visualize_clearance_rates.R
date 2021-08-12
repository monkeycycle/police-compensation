
plot_wps_clearance_rates <- ggplot(wps_all_crimes_clearance_rates_tall) +
  aes(x = year_date, y = value, color=factor(name), fill=factor(name), label=value) +
  geom_line( aes(colour=name), stat = 'identity', size=1) +
  geom_point( aes(colour=name, fill=name), stat = 'identity', size=2 ) +

  # geom_text_repel(
  #   data = wps_all_crimes_clearance_rates_tall %>% filter(year_date == as.Date("2019-01-01")),
  #   aes(
  #     label = paste(value)
  #   ),
  #   color = "#222222",
  #   size = 4,
  #   hjust = 1,
  #   vjust = 0,
  #   force = 10,
  #   direction = "y",
  #   segment.color = "#cccccc",
  #   segment.size = .2,
  #   show.legend = FALSE
  # ) +

  geom_text(    data = wps_all_crimes_clearance_rates_tall %>% filter(year_date == as.Date("2019-01-01")),
                aes(label=ifelse(is.na(value), "", paste(round(value, digits = 2), "%", sep=""))),
                size=3.5, hjust = -.05, vjust = -.5,
                position = "identity",
                color="#222222"
            ) +
  scale_colour_manual(
    values = c(
      "violent_crimes_clearance_rate_pct" =  nominalMuted_shade_0,
      "property_crimes_clearance_rate_pct" =  nominalMuted_shade_1,
      "cdsa_clearance_rate_pct" =  nominalMuted_shade_2,
      "other_crimes_clearance_rate_pct" =  nominalMuted_shade_3
    ),
    labels = c(
      "Violent crime",
      "Property crime",
      "CDSA crime",
      "Other crime"
    )
  ) +
  scale_x_date(date_breaks = "1 year", labels = date_format("%Y")) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 100),
    labels = function(x) {
      ifelse(x == 100, paste(x, "%", sep = ""), x)
    }
  ) +
  labs(
    title = "Clearance rates by type of crime for the Winnipeg Police Service",
    subtitle = "",
    caption = toupper(paste("WINNIPEG FREE PRESS — SOURCE: Winnipeg Police Service Annual Report (2010 data is unavailable)", sep="")),
    x = "",
    y = "",
    colour = ""
  ) +
  guides(
    fill=FALSE
  ) +
  minimal_theme() +
  theme(
    legend.key = element_rect(fill = "#ffffff", color = NA),
    legend.key.size = unit(1, "cm"),
    legend.key.width = unit(1,"cm"),
    legend.position = c(0, 1),
    legend.justification = c(0, 0),
    legend.direction = "horizontal"
  )


wfp_wps_clearance_rates <- prepare_plot(plot_wps_clearance_rates)
write_plot(wfp_wps_clearance_rates, filename = "wfp_wps_clearance_rates",
           format = "png", width=10, height=7, units="in", dpi=320, limitsize = TRUE)


write_plot(wfp_wps_clearance_rates, filename = "wfp_wps_clearance_rates",
          format = "pdf", width=10, height=7, units="in", dpi=320, limitsize = FALSE)
