///|
/// Minimal example for embedding Lunemark in another MoonBit executable.
fn main {
  let milestones = [
    @lunemark.MoonBitPrimary,
    @lunemark.PublicRepository,
    @lunemark.CompleteReadme,
    @lunemark.RunnableExample,
    @lunemark.RunnableTests,
  ]
  let report = @lunemark.mark_launch("tiny-orbit", milestones)
  println(@lunemark.launch_badge(report))
  let idea = @lunemark.lunemark_profile()
  let originality = @lunemark.analyze_originality(idea)
  println(@lunemark.originality_badge(originality))
}
