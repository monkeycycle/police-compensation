winnipeg_all_salary_disclosure_2016_2020__dept_cnt <- winnipeg_all_salary_disclosure_2016_2020 %>%
  group_by(year, department) %>%
  count(department) %>%
  rename(
    count = n
  )

winnipeg_all_salary_disclosure_2016_2020__dept_sum <- winnipeg_all_salary_disclosure_2016_2020 %>%
  group_by(year, department) %>%
  summarise(
    sum_compensation = sum(compensation, na.rm = TRUE),
    mean_compensation = mean(compensation, na.rm = TRUE),
    median_compensation = median(compensation, na.rm = TRUE),
    max_compensation = max(compensation, na.rm = TRUE)
  )

winnipeg_all_salary_disclosure_2016_2020_grouped <- left_join(
  winnipeg_all_salary_disclosure_2016_2020__dept_cnt,
  winnipeg_all_salary_disclosure_2016_2020__dept_sum,
) %>%
  ungroup()

winnipeg_all_salary_disclosure_2016_2020_grouped_ranked <- winnipeg_all_salary_disclosure_2016_2020_grouped %>%
  group_by(year) %>%
  mutate(
    rank_count = order(order(count, decreasing = TRUE)),
    rank_sum_compensation = order(order(sum_compensation, decreasing = TRUE)),
    rank_mean_compensation = order(order(mean_compensation, decreasing = TRUE)),
    rank_median_compensation = order(order(median_compensation, decreasing = TRUE)),
    rank_max_compensation = order(order(max_compensation, decreasing = TRUE))
  ) %>%
  select(
    -count,
    -sum_compensation,
    -mean_compensation,
    -median_compensation,
    -max_compensation
  )


# How many WPS staff on the list are above 100K?
winnipeg_police_salary_disclosure_2016_2020_100Kplus <- winnipeg_police_salary_disclosure_2016_2020 %>%
  filter(compensation > 100000) %>%
  group_by(year) %>%
  summarise()


