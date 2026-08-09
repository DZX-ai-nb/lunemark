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
}
