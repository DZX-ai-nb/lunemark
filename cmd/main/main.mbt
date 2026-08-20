///|
/// Runnable acceptance capsule example.
fn main {
  let originality = @lunemark.analyze_originality(@lunemark.lunemark_profile())
  println(@lunemark.format_originality_report(originality))
  let draft = @lunemark.audit("lunemark-draft", @lunemark.draft_evidence())
  println(@lunemark.format_report(draft))
  let release_report = @lunemark.audit(
    "lunemark-release",
    @lunemark.complete_evidence(),
  )
  println(@lunemark.badge(release_report))
}
