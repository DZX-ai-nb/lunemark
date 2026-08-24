///|
/// Minimal example for embedding Lunemark in another MoonBit executable.
fn main {
  let day = @lunemark.date(2026, 9, 7)
  let deep_work = @lunemark.analyze_day(day, @lunemark.DeepWork)
  println(@lunemark.rhythm_badge(deep_work))
  let windows = @lunemark.best_windows(day, 7, @lunemark.EventTiming, 2)
  for item in windows {
    println(@lunemark.format_date(item.date) + " " + item.phase.label())
  }
}
