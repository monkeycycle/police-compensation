
df_winnipeg_wps_staffing <- winnipeg_wps_annual_reports %>%
  mutate(
    authorized_civilian_compliment = authorized_civilian_compliment_incl_cadets - authorized_cadets
  ) %>%
  select(
    year_date, total_authorized_police_members, authorized_civilian_compliment, authorized_cadets
  )

 p_winnipeg_wps_staffing <- ggplot(df_winnipeg_wps_staffing) +
  geom_line(data=df_winnipeg_wps_staffing, aes(x = year_date, y = total_authorized_police_members), colour = nominalBold_shade_0, size = 1, alpha=.7) +
  geom_line(data=df_winnipeg_wps_staffing, aes(x = year_date, y = authorized_civilian_compliment), colour = nominalBold_shade_1, size = 1, alpha=.7) +
  geom_line(data=df_winnipeg_wps_staffing, aes(x = year_date, y = authorized_cadets), colour = nominalBold_shade_2, size = 1, alpha=.7) +

  geom_point(data=df_winnipeg_wps_staffing %>% filter(year_date == max(year_date)), aes(x = year_date, y = total_authorized_police_members), colour = nominalBold_shade_0, size = 2) +
  geom_point(data=df_winnipeg_wps_staffing %>% filter(year_date == max(year_date)), aes(x = year_date, y = authorized_civilian_compliment), colour = nominalBold_shade_1, size = 2) +
  geom_point(data=df_winnipeg_wps_staffing %>% filter(year_date == max(year_date)), aes(x = year_date, y = authorized_cadets), colour = nominalBold_shade_2, size = 2) +

  geom_text(
    data = df_winnipeg_wps_staffing %>% filter(year_date == max(year_date)),
    aes(x = as.Date("2020-01-01"), y = total_authorized_police_members, label = paste("Sworn officers: ", comma(total_authorized_police_members), " in 2020", sep = "")),
    vjust = 0, hjust=-.15
  ) +
  geom_text(
   data = df_winnipeg_wps_staffing %>% filter(year_date == max(year_date)),
   aes(x = as.Date("2020-01-01"), y = authorized_civilian_compliment, label = paste("Civilian staff: ", comma(authorized_civilian_compliment), " in 2020", sep = "")),
   vjust = 0, hjust=-.15
  ) +
  geom_text(
    data = df_winnipeg_wps_staffing %>% filter(year_date == max(year_date)),
    aes(x = as.Date("2020-01-01"), y = authorized_cadets, label = paste("Cadets: ", comma(authorized_cadets), " in 2020", sep = "")),
    vjust = 0, hjust=-.15
  ) +
  scale_x_date(expand = c(0, 0),
               date_breaks = "2 year", labels = date_format("%Y"),
               limits=as.Date(c("2011-01-01", "2025-01-01"))) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(0, 2000),
    labels = scales::comma
  ) +
  minimal_theme() +
  labs(
    title = "Authorized Winnipeg Police Service staffing",
    subtitle="",
    colour="",
    fill="",
    x="",
    y="",
    caption=toupper(paste(
      "WINNIPEG FREE PRESS — SOURCE: Winnipeg Police Service"
    ))
  )

wfp_winnipeg_wps_staffing <- prepare_plot(p_winnipeg_wps_staffing)
ggsave_pngpdf(wfp_winnipeg_wps_staffing, "wfp_winnipeg_wps_staffing", width_var=8.66, height_var=6, dpi_var=300, scale_var=1, units_var="in")

