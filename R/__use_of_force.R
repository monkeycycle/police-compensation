

wps_use_of_force_reports_cnt <- wps_use_of_force %>%
  select(
    year,
    use_of_force_reports,
    officer_involved_shooting,
    oc_spray,
    asp_baton,
    canine_presented_coerce,
    conducted_energy_weapon_presented_coerce,
    conducted_energy_weapon_probes_deployed,
    conducted_energy_weapon_push_stun
  )
