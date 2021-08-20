
df_clearance_rates <- winnipeg_wps_annual_reports %>%
  select(
    year_date,
    violent_crimes_clearance_rate_pct,
    property_crimes_clearance_rate_pct,
    other_crimes_clearance_rate_pct,
    cdsa_clearance_rate_pct
  ) %>%
  pivot_longer(-year_date,
      names_to="type",
      values_to="rate"
  ) %>%
  mutate(
    type = case_when(
      type == "violent_crimes_clearance_rate_pct" ~ "Violent crimes",
      type == "property_crimes_clearance_rate_pct" ~ "Property crimes",
      type == "other_crimes_clearance_rate_pct" ~ "Other crimes",
      type == "cdsa_clearance_rate_pct" ~ "Drug crimes"
    )
  )

p_winnipeg_wps_annual_reports__clearance_facet <- ggplot(df_clearance_rates) +
  geom_line(aes(x = year_date, y = rate), colour = wfp_blue, size = 1, alpha=.7) +
  geom_point(data=df_clearance_rates %>% filter(year_date == max(year_date) ), aes(x = year_date, y = rate), colour = wfp_blue, size = 2, alpha=1) +
  geom_text(
    data = df_clearance_rates %>% filter(year_date == max(year_date)),
    aes(x = as.Date("2020-01-01"), y = rate, label = paste(rate, "% in 2020", sep = "")),
    vjust = .5, hjust=-.15
  ) +
  scale_x_date(expand = c(0, 0),
               date_breaks = "2 year", labels = date_format("%Y"),
               limits=as.Date(c("2011-01-01", "2026-01-01"))) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(0, 110),
    labels = function(x) {
      ifelse(x == 100, paste(x, "%", sep = ""), x)
    }
  ) +
  minimal_theme() +
  labs(
    title = wrap_text("Clearance rates for reported crimes in Winnipeg", 65),
    colour="",
    fill="",
    x="",
    y="",
    caption=toupper(paste(
      "WINNIPEG FREE PRESS — SOURCE: Winnipeg Police Service"
    ))
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
  facet_wrap(.~type, nrow=2)

wfp_winnipeg_wps_annual_reports__clearance_facet <- prepare_plot(p_winnipeg_wps_annual_reports__clearance_facet)
ggsave_pngpdf(wfp_winnipeg_wps_annual_reports__clearance_facet, "wfp_winnipeg_wps_annual_reports__clearance_facet", width_var=8.66, height_var=6, dpi_var=300, scale_var=1, units_var="in")


