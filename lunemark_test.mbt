///|
test "public API formats a lunar rhythm report" {
  let report = @lunemark.analyze_day(
    @lunemark.date(2026, 8, 24),
    @lunemark.NightSky,
  )
  let rendered = @lunemark.format_day_report(report)
  assert_true(rendered.contains("Lunemark lunar rhythm"))
  assert_true(rendered.contains("phase:"))
  assert_true(rendered.contains("signature: LNR-"))
}

///|
test "public API exports calendar text" {
  let ics = @lunemark.export_ics(
    "Field window",
    @lunemark.date(2026, 8, 24),
    20,
    @lunemark.EventTiming,
  )
  assert_true(ics.contains("BEGIN:VCALENDAR"))
  assert_true(ics.contains("PRODID:-//Lunemark//MoonBit//EN"))
  assert_true(ics.contains("END:VCALENDAR"))
}

///|
test "public API validates dates and leap years" {
  assert_true(@lunemark.is_leap_year(2028))
  assert_true(@lunemark.is_leap_year(2100) == false)
  assert_true(@lunemark.is_valid_date(@lunemark.date(2028, 2, 29)))
  assert_true(@lunemark.is_valid_date(@lunemark.date(2027, 2, 29)) == false)
  assert_true(@lunemark.is_valid_date(@lunemark.date(2026, 13, 1)) == false)
}

///|
test "public phase helpers match day analysis" {
  let day = @lunemark.date(2026, 9, 7)
  let report = @lunemark.analyze_day(day, @lunemark.DeepWork)
  assert_true(report.phase == @lunemark.phase_on(day))
  assert_true(report.lunar_day == @lunemark.lunar_day_on(day))
  assert_true(report.illumination == @lunemark.illumination_on(day))
}
