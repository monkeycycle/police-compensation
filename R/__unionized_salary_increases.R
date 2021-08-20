library(readr)
WFP_WPS_and_WFPS_budgets_contract_increases <- read_csv("data/raw/WFP -WPS and WFPS budgets - contract increases.csv") %>%
  pivot_longer(-date,
               names_to = "union",
               values_to = "increase") %>%
  filter(union %notin% c("WFPSOA", "WPSOA")) %>%
  mutate(year = year(date)) %>%
  mutate(
    union = ifelse(union == "UFFW", "United Fire Fighters of Winnipeg", "
Winnipeg Police Association")
  ) %>%
  mutate(date = as.Date(paste(year, "-01-01", sep=""))) %>%
  group_by(union, date) %>%
  summarise(total_increase = sum(increase, na.rm=TRUE) )

inflation_rate_salary_increases <- inflation_rate %>%
  mutate(date = as.Date(paste(year, "-01-01", sep="")))


p_wps_wfps_contract_increases <- ggplot(WFP_WPS_and_WFPS_budgets_contract_increases) +
  aes(x = date, y = total_increase) +
  geom_bar(data=WFP_WPS_and_WFPS_budgets_contract_increases,
    aes(x = date, y = total_increase),
    stat="identity", position = position_dodge(width=0.2),
    fill=nominalMuted_shade_0
    ) +
  geom_line(data=inflation_rate_salary_increases,
            aes(x = date, y = inflation_rate),
            size=1.5, colour="#ffffff") +
  geom_line(data=inflation_rate_salary_increases,
            aes(x = date, y = inflation_rate),
            size=1, colour=nominalBold_shade_1) +
  annotate("text", x=as.Date("2018-01-01"), y=2.5, label="Annual inflation rate", hjust=.3, size=3.5 ) +

  scale_fill_manual(values=wfp_colour_scale_bold) +
  scale_x_date(expand = c(0, 0),
               date_breaks = "2 years", labels = date_format("%Y"),
               limits=as.Date(c("2012-01-01", "2022-01-01"))) +
  scale_y_continuous(
    expand = c(0, 0),
    limits = c(0, 5),
    labels = function(x) {
        ifelse(x == 5, paste(x, "%", sep = ""), x)
      }
    ) +
  guides(colour=FALSE) +
  minimal_theme() +
  labs(
    title = wrap_text("General wage increases for police, fire and paramedic service employees in Winnipeg", 65),
    subtitle="Includes years with multiple pay increases",
    colour="",
    fill="",
    x="",
    y="",
    caption=paste(
      toupper(paste(
        "WINNIPEG FREE PRESS — SOURCE: Union contracts"
      ))
    )
  ) +
  facet_wrap(vars(union)) +
  theme(
    strip.background=ggplot2::element_blank(),
    strip.text=ggplot2::element_text(size=12, hjust=0, face="bold"),
    panel.border=ggplot2::element_blank(),
    # legend.position=c(.8, 1.05),
    legend.justification=c("right", "top")
    # legend.box.just="right",
    # legend.margin=margin(10, 10, 10, 10)
  )

# plot(p_wps_wfps_contract_increases)


# View(WFP_WPS_and_WFPS_budgets_contract_increases)



wfp_wps_wfps_contract_increases <- prepare_plot(p_wps_wfps_contract_increases)
ggsave_pngpdf(wfp_wps_wfps_contract_increases, "wfp_wps_wfps_contract_increases", width_var=8.66, height_var=6, dpi_var=300, scale_var=1, units_var="in")

