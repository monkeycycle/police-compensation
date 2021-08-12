
wps_officers_diversity <- wps_annual_reports %>%
  select(
    year_date,
    sworn_total_actual,
    sworn_caucasian,
    sworn_indigenous,
    sworn_visible_minorities,
    sworn_not_declared,
    sworn_male,
    sworn_female
  ) %>%
  mutate(
    sworn_total_actual,
    sworn_caucasian_pct = format(sworn_caucasian / sworn_total_actual * 100, digits=2),
    sworn_indigenous_pct = format(sworn_indigenous / sworn_total_actual * 100, digits=2),
    sworn_visible_minorities_pct = format(sworn_visible_minorities / sworn_total_actual * 100, digits=2),
    sworn_not_declared_pct = format(sworn_not_declared / sworn_total_actual * 100, digits=2),
    sworn_male_pct = format(sworn_male / sworn_total_actual * 100, digits=2),
    sworn_female_pct =format(sworn_female / sworn_total_actual * 100, digits=2)
  )


wps_officers_diversity_vismin_tall <- wps_officers_diversity %>%
  select(
    year_date,
    sworn_caucasian_pct,
    sworn_indigenous_pct,
    sworn_visible_minorities_pct,
    sworn_not_declared_pct
  ) %>%
  rename(
    caucasian_pct = sworn_caucasian_pct,
    indigenous_pct = sworn_indigenous_pct,
    visible_minorities_pct = sworn_visible_minorities_pct,
    not_declared_pct = sworn_not_declared_pct,
  ) %>%
  pivot_longer(
    -year_date
  ) %>%
  mutate (
    name = factor(name, levels=c(
      "not_declared_pct",
      "caucasian_pct",
      "indigenous_pct",
      "visible_minorities_pct"
    )),
    value = as.numeric(value)
  )

  wps_officers_diversity_gender_tall <- wps_officers_diversity %>%
    select(
      year_date,
      sworn_male_pct,
      sworn_female_pct,
    ) %>%
    rename(
      male_pct = sworn_male_pct,
      female_pct = sworn_female_pct,
    ) %>%
    pivot_longer(
      -year_date
    ) %>%
    mutate (
      name = as.factor(name),
      value = as.numeric(value)
    )
