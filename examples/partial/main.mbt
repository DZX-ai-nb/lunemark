///|
/// Minimal example for embedding Lunemark in another MoonBit executable.
fn main {
  let evidence = [
    @lunemark.MoonBitPrimary,
    @lunemark.PublicRepository,
    @lunemark.CompleteReadme,
    @lunemark.RunnableExample,
    @lunemark.RunnableTests,
  ]
  let report = @lunemark.audit("tiny-orbit", evidence)
  println(@lunemark.badge(report))
  let idea = @lunemark.lunemark_profile()
  let originality = @lunemark.analyze_originality(idea)
  println(@lunemark.originality_badge(originality))
}
