

df_winnipeg_budgets_pct_chg_10yr <- winnipeg_budgets_pct_chg_10yr %>%
  filter(dept != "adopted_budget_millions") %>%
  mutate(
    dollar_diff = amount_m_2020 - amount_m_2011
  )

p_winnipeg_budgets_pct_chg_10yr <- ggplot(df_winnipeg_budgets_pct_chg_10yr) +
  aes(x=reorder(dept, pct_change), weight=pct_change) +
  geom_bar(fill=wfp_blue) +
  geom_text(
    aes(x=reorder(dept, pct_change), y=pct_change, label=paste(format(pct_change, digits=2), "%\n", "$", dollar_diff, " million ", sep="")),
    hjust=-.05, size=3.5
  ) +
  coord_flip() +
  scale_y_continuous(expand = c(0, 0), limits = c(-10, 100)) +
  labs(
    title="Percentage change in Winnipeg's budget by department",
    subtitle="2011 to 2020",
    y="",
    x=""
  )
  minimal_theme() +
  theme(
    axis.line=element_blank(),
    axis.text.x=element_blank(),
    axis.ticks=element_blank(),
    axis.title.x=element_blank(),
    panel.grid.major.y=ggplot2::element_blank(),
    panel.grid.minor.y=ggplot2::element_blank(),
    panel.grid.major.x=ggplot2::element_blank(),
    panel.grid.minor.x=ggplot2::element_blank(),
    legend.position="none"
  )


wfp_winnipeg_budgets_pct_chg_10yr <- prepare_plot(p_winnipeg_budgets_pct_chg_10yr)
ggsave_pngpdf(wfp_winnipeg_budgets_pct_chg_10yr, "wfp_winnipeg_budgets_pct_chg_10yr", width_var=8.66, height_var=6, dpi_var=300, scale_var=1, units_var="in")

