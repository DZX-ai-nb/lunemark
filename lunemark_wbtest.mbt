///|
test "complete evidence seals the report" {
  let report = audit("complete", complete_evidence())
  assert_true(report.score == 100)
  assert_true(report.earned_weight == 100)
  assert_true(report.level == Sealed)
  assert_true(report.missing.length() == 0)
  assert_true(report.signature.contains("LMK-100-"))
}

///|
test "draft evidence lists missing release work" {
  let report = audit("draft", draft_evidence())
  assert_true(report.score == 48)
  assert_true(report.level == Blocked)
  assert_true(report.missing.length() == 6)
  assert_true(format_report(report).contains("CI workflow is configured"))
  assert_true(
    format_report(report).contains("package is published to mooncakes.io"),
  )
}

///|
test "duplicate evidence does not inflate score" {
  let report = audit("duplicate", [MoonBitPrimary, MoonBitPrimary])
  assert_true(report.earned_weight == evidence_weight(MoonBitPrimary))
  assert_true(report.score == 12)
}

///|
test "badge is compact and deterministic" {
  let report = audit("complete", complete_evidence())
  assert_true(badge(report).contains("Lunemark Sealed 100% LMK-100-"))
}
