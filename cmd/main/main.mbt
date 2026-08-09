///|
/// Runnable acceptance capsule example.
fn main {
  let draft = @lunemark.audit("lunemark-draft", @lunemark.draft_evidence())
  println(@lunemark.format_report(draft))
  let release_report = @lunemark.audit(
    "lunemark-release",
    @lunemark.complete_evidence(),
  )
  println(@lunemark.badge(release_report))
}
