///|
/// Runnable Lunemark lunar rhythm example.
fn main {
  let today = @lunemark.date(2026, 8, 24)
  let report = @lunemark.analyze_day(today, @lunemark.NightSky)
  println(@lunemark.format_day_report(report))
  let best = @lunemark.best_windows(today, 14, @lunemark.NightSky, 3)
  for item in best {
    println(@lunemark.rhythm_badge(item))
  }
  println(
    @lunemark.export_ics(
      "Event timing window",
      today,
      20,
      @lunemark.EventTiming,
    ),
  )
}
