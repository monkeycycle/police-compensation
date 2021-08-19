
df_labels <- winnipeg_budgets_yoy_pct_chg_tall %>%
  filter(dept!="adopted_yoy_pct_chgillions") %>%
  filter(dept %in% c("community_services_e_g_libraries_recreation_services_pct_chg", "police_and_fire_paramedic_services_pct_chg", "transit_subsidy_pct_chg")) %>%
  filter(year==max(year)) %>%
  mutate(
    label = ifelse(dept == "community_services_e_g_libraries_recreation_services_pct_chg", "Community services",
            ifelse(dept == "police_and_fire_paramedic_services_pct_chg", "Police, Fire and Paramedic",
            ifelse(dept == "transit_subsidy_pct_chg", "Transit subsidy",
                   dept
    )))
  )

p_winnipeg_budget_depts_pctchg  <- ggplot(winnipeg_budgets_yoy_pct_chg_tall %>% filter(dept!="adopted_yoy_pct_chgillions")) +
  aes(x = year, y = yoy_pct_chg, group=dept) +
  geom_line(size = .5, colour="#999999") +
  geom_line(data=winnipeg_budgets_yoy_pct_chg_tall %>% filter(dept!="adopted_yoy_pct_chgillions") %>% filter(dept == "police_and_fire_paramedic_services_pct_chg"),
            size = 1, alpha=1, colour=wfp_blue) +
  geom_line(data=winnipeg_budgets_yoy_pct_chg_tall %>% filter(dept!="adopted_yoy_pct_chgillions") %>% filter(dept == "community_services_e_g_libraries_recreation_services_pct_chg"),
            size = 1, alpha=1, colour=nominalBold_shade_1) +
  geom_line(data=winnipeg_budgets_yoy_pct_chg_tall %>% filter(dept!="adopted_yoy_pct_chgillions") %>% filter(dept == "transit_subsidy_pct_chg"),
            size = 1, alpha=1, colour=nominalBold_shade_2) +

  scale_x_date(date_breaks = "2 year", labels = date_format("%Y"),
               limits=as.Date(c("2011-01-01", "2030-01-01"))) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 20)) +
  minimal_theme() +
  labs(
    title="Year-over-year change in Winnipeg's annual operating budget by department",
    subtitle="Percentage",
    y="",
    x="",
    caption=toupper(paste(
      "WINNIPEG FREE PRESS — SOURCE: City of winnipeg annual budgets"
    ))
  )

wfp_winnipeg_budget_depts_pctchg <- prepare_plot(p_winnipeg_budget_depts_pctchg)
ggsave_pngpdf(wfp_winnipeg_budget_depts_pctchg, "wfp_winnipeg_budget_depts_pctchg", width_var=8.66, height_var=6, dpi_var=300, scale_var=1, units_var="in")
