
plot_wps_budget_annual <- ggplot(wps_tax_supported_expenses, aes(x = year_date, y = tax_supported_expenses, label=tax_supported_expenses)) +
  geom_bar(colour = 'white', fill=wfp_blue, stat = 'identity') +
  geom_text(aes(label=paste("$", round(tax_supported_expenses/1000000, 1), " M", sep='')),
                stat="identity",
                position = "identity",
                size=4, hjust = .5, vjust = -1,
                color="#222222"
            ) +
  scale_x_date(date_breaks = "1 year", labels = date_format("%Y")) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 400000000), labels = unit_format(unit = "M", scale = 1e-6)) +
  labs(
    title = "Annual tax-supported budget for Winnipeg Police Service",
    subtitle = "Dollars (unadjusted for inflation)",
    caption = toupper(paste("WINNIPEG FREE PRESS — SOURCE: Winnipeg Police Service ", sep="")),
    x = "",
    y = ""
  ) +
  minimal_theme()


plot_wps_budget_pct_change <- ggplot(wps_tax_supported_expenses, aes(x = year_date, y = pct_change)) +
  geom_line( colour=nominalMuted_shade_0, fill=nominalMuted_shade_0, stat = 'identity', size=1) +
  geom_point( colour=wfp_blue, fill=wfp_blue, stat = 'identity', size=2) +
  geom_text(data=wps_tax_supported_expenses,
                aes(label=ifelse(is.na(pct_change), "", paste(round(pct_change, digits = 2), "%", sep=""))),
                size=4, hjust = .5, vjust = -1,
                position = "identity",
                color="#222222"
            ) +
  scale_y_continuous(expand = c(0, 0), limits = c(-15, 15)) +
  labs(
    title = "Percentage change in annual tax-supported budget for Winnipeg Police Service",
    subtitle = "",
    caption = toupper(paste("WINNIPEG FREE PRESS — SOURCE: Winnipeg Police Service ", sep="")),
    x = "",
    y = ""
  ) +
  minimal_theme()



plot_wps_budget_pct_change_v_inflation <- ggplot(wps_tax_supported_expenses_v_inflation_tall, aes(x = year_date, y = value, colour=factor(name))) +
  geom_line( aes(color=name), stat = 'identity', size=1) +
  geom_point( aes(color=name, fill=name), stat = 'identity', size=2) +
  geom_text(data=wps_tax_supported_expenses_v_inflation_tall %>%  filter(year_date == as.Date("2019-01-01")),
                aes(label=ifelse(is.na(value), "", paste(round(value, digits = 2), "%", sep=""))),
                size=3.5, hjust = -.05, vjust = -.5,
                position = "identity",
                color="#222222"
            ) +
  scale_colour_manual(
    values = c(
      "pct_change" =  nominalMuted_shade_0,
      "inflation_rate" =  nominalMuted_shade_1
    ),
    labels = c("WPS budget increase (YoY % change)", "Inflation rate")
  ) +
  scale_x_date(date_breaks = "1 year", labels = date_format("%Y")) +
  scale_y_continuous(expand = c(0, 0), limits = c(-5, 15),
    labels = function(x) {
      ifelse(x == 15, paste(x, "%", sep = ""), x)
    }
  ) +
  labs(
    title = wrap_text("Percentage change and inflation rate in annual tax-supported budget for Winnipeg Police Service", 80),
    subtitle = "",
    caption = toupper(paste("WINNIPEG FREE PRESS — SOURCE: Winnipeg Police Service Annual Reports", sep="")),
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



wfp_wps_budget_annual <- prepare_plot(plot_wps_budget_annual)
write_plot(wfp_wps_budget_annual, filename = "wfp_wps_budget_annual",
           format = "png", width=10, height=7, units="in", dpi=320, limitsize = TRUE)

wfp_wps_budget_pct_change <- prepare_plot(plot_wps_budget_pct_change)
write_plot(wfp_wps_budget_pct_change, filename = "wfp_wps_budget_pct_change",
           format = "png", width=10, height=7, units="in", dpi=320, limitsize = TRUE)


wfp_wps_budget_pct_change_v_inflation <- prepare_plot(plot_wps_budget_pct_change_v_inflation)
write_plot(wfp_wps_budget_pct_change_v_inflation, filename = "wfp_wps_budget_pct_change_v_inflation",
           format = "png", width=10, height=7, units="in", dpi=320, limitsize = TRUE)

write_plot(wfp_wps_budget_pct_change_v_inflation, filename = "wfp_wps_budget_pct_change_v_inflation",
         format = "pdf", width=10, height=7, units="in", dpi=320, limitsize = FALSE)

write_plot(wfp_wps_budget_pct_change_v_inflation, filename = "wfp_wps_budget_pct_change_v_inflation",
        format = "pdf", width=10, height=7, units="in", dpi=320, limitsize = FALSE)
