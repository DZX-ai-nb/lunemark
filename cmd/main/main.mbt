///|
/// Runnable Lunemark CLI example.
fn main {
  let originality = @lunemark.analyze_originality(@lunemark.lunemark_profile())
  println(@lunemark.format_originality_report(originality))
  let draft = @lunemark.mark_launch(
    "lunemark-draft",
    @lunemark.draft_milestones(),
  )
  println(@lunemark.format_launch_report(draft))
  let release_report = @lunemark.mark_launch(
    "lunemark-release",
    @lunemark.complete_milestones(),
  )
  println(@lunemark.launch_badge(release_report))
}
