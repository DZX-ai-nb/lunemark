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

///|
test "originality atlas returns ranked hits and signature" {
  let report = analyze_originality(lunemark_profile())
  assert_true(report.closest.length() == 5)
  assert_true(report.novelty_score > 0)
  assert_true(report.anti_collision_signature.contains("ORBT-"))
  assert_true(format_originality_report(report).contains("closest archetypes"))
}

///|
test "known readiness guard shape is detected as close" {
  let profile = IdeaProfile::{
    name: "readiness guard",
    thesis: "audit MoonBit project readiness",
    audience: "hackathon-submitters",
    mechanism: "file-snapshot-auditing",
    axis_namespace: 4,
    axis_runtime: 2,
    axis_docs: 7,
    axis_ci: 8,
    axis_release: 7,
    axis_originality: 3,
    axis_maintenance: 5,
    axis_data: 2,
    axis_interactive: 1,
    axis_security: 4,
    axis_portability: 4,
    axis_community: 3,
  }
  let closest = closest_archetypes(profile, 1)
  assert_true(closest.length() == 1)
  assert_true(closest[0].id == "ARCH-000")
  assert_true(closest[0].similarity == 100)
}
