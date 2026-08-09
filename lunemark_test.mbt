///|
test "public report formatter exposes score and missing items" {
  let report = @lunemark.audit("external", [
    @lunemark.MoonBitPrimary,
    @lunemark.PublicRepository,
  ])
  let rendered = @lunemark.format_report(report)
  assert_true(report.score == 20)
  assert_true(rendered.contains("score: 20/100"))
  assert_true(rendered.contains("README is clear and complete"))
}
