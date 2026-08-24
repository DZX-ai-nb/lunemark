///|
test "known new moon anchor stays stable" {
  let report = analyze_day(date(2000, 1, 6), NightSky)
  assert_true(report.phase == NewMoon)
  assert_true(report.illumination <= 3)
  assert_true(report.signature.contains("LNR-"))
}

///|
test "span analysis preserves requested length" {
  let items = analyze_span(date(2026, 8, 24), 12, TideWatch)
  assert_true(items.length() == 12)
  assert_true(items[0].date == date(2026, 8, 24))
}

///|
test "best windows are sorted by score" {
  let items = best_windows(date(2026, 8, 24), 30, NightSky, 5)
  assert_true(items.length() == 5)
  assert_true(items[0].score >= items[1].score)
  assert_true(items[1].score >= items[2].score)
}

///|
test "rule catalog is real project data" {
  let rules = rhythm_rule_catalog()
  assert_true(rules.length() >= 500)
  assert_true(rules[0].id == "LR-000")
  assert_true(rules[0].label.contains("night sky"))
}

///|
test "matching rules are used by day analysis" {
  let report = analyze_day(date(2000, 1, 6), NightSky)
  let rules = matching_rules(report.date, report.phase, report.lane)
  assert_true(report.rules.length() == rules.length())
}

///|
test "compact badge carries phase score and signature" {
  let report = analyze_day(date(2026, 9, 7), DeepWork)
  let badge = rhythm_badge(report)
  assert_true(badge.contains("Lunemark"))
  assert_true(badge.contains("LNR-"))
}

///|
test "custom ics threshold filters events" {
  let low = export_ics_with_threshold(
    "low threshold",
    date(2026, 8, 24),
    3,
    EventTiming,
    0,
  )
  let high = export_ics_with_threshold(
    "high threshold",
    date(2026, 8, 24),
    3,
    EventTiming,
    100,
  )
  assert_true(low.contains("BEGIN:VEVENT"))
  assert_true(high.contains("BEGIN:VEVENT") == false)
}

///|
test "high window predicate follows default threshold" {
  let report = analyze_day(date(2026, 9, 7), DeepWork)
  assert_true(is_high_window(report) == (report.score >= 70))
}
