################################################################################
# Winnipeg budgets
################################################################################

winnipeg_budgets <- read_feather(dir_data_processed('winnipeg_budgets.feather'))

# Save a copy of colnames with full text and clean_names version to link back
winnipeg_budgets_colnames_tmp  <- read_csv(dir_data_raw("winnipeg_budgets.csv"))
winnipeg_budgets_colnames <- names(winnipeg_budgets_colnames_tmp)
winnipeg_budgets_cleannames <- winnipeg_budgets_colnames_tmp %>% clean_names() %>%
colnames()

winnipeg_budgets_colnames <- as.data.frame(winnipeg_budgets_colnames)
winnipeg_budgets_cleannames <- as.data.frame(winnipeg_budgets_cleannames)

winnipeg_budgets_dept_names <- merge(winnipeg_budgets_cleannames, winnipeg_budgets_colnames, all=T,by='row.names')
winnipeg_budgets_dept_names <- winnipeg_budgets_dept_names %>%
  select(-Row.names) %>%
  rename(
    cleannames = winnipeg_budgets_cleannames,
    colnames = winnipeg_budgets_colnames
    )

winnipeg_budgets_yoy_pct_chg <- winnipeg_budgets %>%
  arrange(year) %>%
  mutate(
    adopted_budget_millions_pct_chg = (adopted_budget_millions - lag(adopted_budget_millions)) / lag(adopted_budget_millions) * 100,
    street_system_solid_waste_collection_land_drainage_street_lighting_and_insect_control_pct_chg = (street_system_solid_waste_collection_land_drainage_street_lighting_and_insect_control - lag(street_system_solid_waste_collection_land_drainage_street_lighting_and_insect_control)) / lag(street_system_solid_waste_collection_land_drainage_street_lighting_and_insect_control) * 100,
    transit_subsidy_pct_chg = (transit_subsidy - lag(transit_subsidy)) / lag(transit_subsidy) * 100,
    property_development_planning_permits_and_buildings_pct_chg = (property_development_planning_permits_and_buildings - lag(property_development_planning_permits_and_buildings)) / lag(property_development_planning_permits_and_buildings) * 100,
    police_and_fire_paramedic_services_pct_chg = (police_and_fire_paramedic_services - lag(police_and_fire_paramedic_services)) / lag(police_and_fire_paramedic_services) * 100,
    city_clerks_city_council_mayor_s_office_museums_audit_pct_chg = (city_clerks_city_council_mayor_s_office_museums_audit - lag(city_clerks_city_council_mayor_s_office_museums_audit)) / lag(city_clerks_city_council_mayor_s_office_museums_audit) * 100,
    organizational_support_e_g_information_technology_human_resources_finance_assessment_legal_corporate_pct_chg = (organizational_support_e_g_information_technology_human_resources_finance_assessment_legal_corporate - lag(organizational_support_e_g_information_technology_human_resources_finance_assessment_legal_corporate)) / lag(organizational_support_e_g_information_technology_human_resources_finance_assessment_legal_corporate) * 100,
    community_services_e_g_libraries_recreation_services_pct_chg = (community_services_e_g_libraries_recreation_services - lag(community_services_e_g_libraries_recreation_services)) / lag(community_services_e_g_libraries_recreation_services) * 100,
  ) %>%
  select(
    year,
    adopted_budget_millions_pct_chg,
    street_system_solid_waste_collection_land_drainage_street_lighting_and_insect_control_pct_chg,
    transit_subsidy_pct_chg,
    property_development_planning_permits_and_buildings_pct_chg,
    police_and_fire_paramedic_services_pct_chg,
    city_clerks_city_council_mayor_s_office_museums_audit_pct_chg,
    organizational_support_e_g_information_technology_human_resources_finance_assessment_legal_corporate_pct_chg,
    community_services_e_g_libraries_recreation_services_pct_chg
  )

winnipeg_budgets_yoy_pct_chg_tall <- winnipeg_budgets_yoy_pct_chg %>%
  pivot_longer(-year,
               names_to="dept",
               values_to="yoy_pct_chg") %>%
  filter(dept != "adopted_budget_millions_pct_chg") %>%
  mutate(year = as.Date(year))


winnipeg_budgets_pct_chg_10yr_2011 <- winnipeg_budgets %>%
  filter(year %in% c("2011")) %>% mutate( year = as.Date(paste(year, "-01-01", sep=""))) %>%
  pivot_longer(-year,
               names_to="dept",
               values_to="amount_m_2011") %>%
  select(-year)

winnipeg_budgets_pct_chg_10yr_2012 <- winnipeg_budgets %>%
  filter(year %in% c("2012")) %>% mutate( year = as.Date(paste(year, "-01-01", sep=""))) %>%
  pivot_longer(-year,
               names_to="dept",
               values_to="amount_m_2012") %>%
  select(-year)

winnipeg_budgets_pct_chg_10yr_2013 <- winnipeg_budgets %>%
  filter(year %in% c("2013")) %>% mutate( year = as.Date(paste(year, "-01-01", sep=""))) %>%
  pivot_longer(-year,
               names_to="dept",
               values_to="amount_m_2013") %>%
  select(-year)

winnipeg_budgets_pct_chg_10yr_2014 <- winnipeg_budgets %>%
  filter(year %in% c("2014")) %>% mutate( year = as.Date(paste(year, "-01-01", sep=""))) %>%
  pivot_longer(-year,
               names_to="dept",
               values_to="amount_m_2014") %>%
  select(-year)

winnipeg_budgets_pct_chg_10yr_2015 <- winnipeg_budgets %>%
  filter(year %in% c("2015")) %>% mutate( year = as.Date(paste(year, "-01-01", sep=""))) %>%
  pivot_longer(-year,
               names_to="dept",
               values_to="amount_m_2015") %>%
  select(-year)

winnipeg_budgets_pct_chg_10yr_2016 <- winnipeg_budgets %>%
  filter(year %in% c("2016")) %>% mutate( year = as.Date(paste(year, "-01-01", sep=""))) %>%
  pivot_longer(-year,
               names_to="dept",
               values_to="amount_m_2016") %>%
  select(-year)

winnipeg_budgets_pct_chg_10yr_2017 <- winnipeg_budgets %>%
  filter(year %in% c("2017")) %>% mutate( year = as.Date(paste(year, "-01-01", sep=""))) %>%
  pivot_longer(-year,
               names_to="dept",
               values_to="amount_m_2017") %>%
  select(-year)

winnipeg_budgets_pct_chg_10yr_2018 <- winnipeg_budgets %>%
  filter(year %in% c("2018")) %>% mutate( year = as.Date(paste(year, "-01-01", sep=""))) %>%
  pivot_longer(-year,
               names_to="dept",
               values_to="amount_m_2018") %>%
  select(-year)

winnipeg_budgets_pct_chg_10yr_2019 <- winnipeg_budgets %>%
  filter(year %in% c("2019")) %>% mutate( year = as.Date(paste(year, "-01-01", sep=""))) %>%
  pivot_longer(-year,
               names_to="dept",
               values_to="amount_m_2019") %>%
  select(-year)

winnipeg_budgets_pct_chg_10yr_2020 <- winnipeg_budgets %>%
  filter(year %in% c("2020")) %>%
  mutate(
    year = as.Date(paste(year, "-01-01", sep=""))
  ) %>%
  arrange(year) %>%
  pivot_longer(-year,
               names_to="dept",
               values_to="amount_m_2020") %>%
  select(-year)

winnipeg_budgets_pct_chg_10yr_2011 <-  as.data.frame(winnipeg_budgets_pct_chg_10yr_2011)
winnipeg_budgets_pct_chg_10yr_2012 <-  as.data.frame(winnipeg_budgets_pct_chg_10yr_2012)
winnipeg_budgets_pct_chg_10yr_2013 <-  as.data.frame(winnipeg_budgets_pct_chg_10yr_2013)
winnipeg_budgets_pct_chg_10yr_2014 <-  as.data.frame(winnipeg_budgets_pct_chg_10yr_2014)
winnipeg_budgets_pct_chg_10yr_2015 <-  as.data.frame(winnipeg_budgets_pct_chg_10yr_2015)
winnipeg_budgets_pct_chg_10yr_2016 <-  as.data.frame(winnipeg_budgets_pct_chg_10yr_2016)
winnipeg_budgets_pct_chg_10yr_2017 <-  as.data.frame(winnipeg_budgets_pct_chg_10yr_2017)
winnipeg_budgets_pct_chg_10yr_2018 <-  as.data.frame(winnipeg_budgets_pct_chg_10yr_2018)
winnipeg_budgets_pct_chg_10yr_2019 <-  as.data.frame(winnipeg_budgets_pct_chg_10yr_2019)
winnipeg_budgets_pct_chg_10yr_2020 <-  as.data.frame(winnipeg_budgets_pct_chg_10yr_2020)



winnipeg_budgets_pct_chg_10yr <- left_join(
  winnipeg_budgets_pct_chg_10yr_2011,
  winnipeg_budgets_pct_chg_10yr_2020,
  by=c("dept"="dept")
)

winnipeg_budgets_pct_chg_10yr <- as.data.frame(winnipeg_budgets_pct_chg_10yr)

winnipeg_budgets_pct_chg_10yr <- winnipeg_budgets_pct_chg_10yr %>%
  mutate(pct_change = (amount_m_2020/amount_m_2011 - 1) * 100)



winnipeg_budgets_tall <- winnipeg_budgets %>%
  pivot_longer(-year,
               names_to="dept",
               values_to="budget_m") %>%
  mutate(
    year = as.Date(paste(year, "-01-01", sep=""))
  )
