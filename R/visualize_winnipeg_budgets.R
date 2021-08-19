
df_labels <- winnipeg_budgets_tall %>%
  filter(dept!="adopted_budget_millions") %>%
  filter(dept %in% c("community_services_e_g_libraries_recreation_services", "police_and_fire_paramedic_services", "transit_subsidy")) %>%
  filter(year==max(year)) %>%
  mutate(
    label = ifelse(dept == "community_services_e_g_libraries_recreation_services", "Community services",
            ifelse(dept == "police_and_fire_paramedic_services", "Police, Fire and Paramedic",
            ifelse(dept == "transit_subsidy", "Transit subsidy",
                   dept
    )))
  )

p_winnipeg_budget_depts  <- ggplot(winnipeg_budgets_tall %>% filter(dept!="adopted_budget_millions")) +
  aes(x = year, y = budget_m, group=dept) +
  geom_line(size = .5, colour="#999999") +
  geom_line(data=winnipeg_budgets_tall %>% filter(dept!="adopted_budget_millions") %>% filter(dept == "police_and_fire_paramedic_services"),
            size = 1, alpha=1, colour=wfp_blue) +
  geom_line(data=winnipeg_budgets_tall %>% filter(dept!="adopted_budget_millions") %>% filter(dept == "community_services_e_g_libraries_recreation_services"),
            size = 1, alpha=1, colour=nominalBold_shade_1) +
  geom_line(data=winnipeg_budgets_tall %>% filter(dept!="adopted_budget_millions") %>% filter(dept == "transit_subsidy"),
            size = 1, alpha=1, colour=nominalBold_shade_2) +
  geom_point(data=winnipeg_budgets_tall %>% filter(year==max(year)) %>% filter(dept!="adopted_budget_millions") %>% filter(dept == "police_and_fire_paramedic_services"),
            size = 2, colour=wfp_blue) +
  geom_point(data=winnipeg_budgets_tall %>% filter(year==max(year)) %>% filter(dept!="adopted_budget_millions") %>% filter(dept == "community_services_e_g_libraries_recreation_services"),
            size = 2, colour=nominalBold_shade_1) +
  geom_point(data=winnipeg_budgets_tall %>% filter(year==max(year)) %>% filter(dept!="adopted_budget_millions") %>% filter(dept == "transit_subsidy"),
            size = 2, colour=nominalBold_shade_2) +
  geom_text(data=df_labels,
            aes(x = as.Date("2020-01-01"), y = budget_m, label=paste(label, " 2020: $", budget_m, " million", sep="")),
            size = 3.5, hjust=-.05) +
  # geom_text(data=winnipeg_budgets_tall %>% filter(year == as.Date("2020-01-01")) %>% filter(dept %notin% c("police_and_fire_paramedic_services", "adopted_budget_millions")) ,
  #           aes(x = as.Date("2020-01-01"), y = budget_m, label=dept),
  #           size = 3, hjust=-.05) +
  scale_x_date(date_breaks = "2 year", labels = date_format("%Y"),
               limits=as.Date(c("2011-01-01", "2030-01-01"))) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 750)) +
  minimal_theme() +
  labs(
    title="Winnipeg's annual operating budget by department",
    subtitle="Millions of dollars",
    y="",
    x="",
    caption=toupper(paste(
      "WINNIPEG FREE PRESS — SOURCE: City of winnipeg annual budgets"
    ))
  )

wfp_winnipeg_budget_depts <- prepare_plot(p_winnipeg_budget_depts)
ggsave_pngpdf(wfp_winnipeg_budget_depts, "wfp_winnipeg_budget_depts", width_var=8.66, height_var=6, dpi_var=300, scale_var=1, units_var="in")
