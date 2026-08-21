///|
test "complete milestones seal the report" {
  let report = mark_launch("complete", complete_milestones())
  assert_true(report.score == 100)
  assert_true(report.earned_weight == 100)
  assert_true(report.level == Sealed)
  assert_true(report.missing.length() == 0)
  assert_true(report.signature.contains("LMK-100-"))
}

///|
test "draft milestones list missing release work" {
  let report = mark_launch("draft", draft_milestones())
  assert_true(report.score == 48)
  assert_true(report.level == Blocked)
  assert_true(report.missing.length() == 6)
  assert_true(
    format_launch_report(report).contains("CI workflow is configured"),
  )
  assert_true(
    format_launch_report(report).contains(
      "package is published to mooncakes.io",
    ),
  )
}

///|
test "duplicate milestones do not inflate score" {
  let report = mark_launch("duplicate", [MoonBitPrimary, MoonBitPrimary])
  assert_true(report.earned_weight == milestone_weight(MoonBitPrimary))
  assert_true(report.score == 12)
}

///|
test "badge is compact and deterministic" {
  let report = mark_launch("complete", complete_milestones())
  assert_true(launch_badge(report).contains("Lunemark Sealed 100% LMK-100-"))
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
test "known release planner shape is detected as close" {
  let profile = IdeaProfile::{
    name: "release planner",
    thesis: "summarize MoonBit project launch routes",
    audience: "release-curators",
    mechanism: "milestone-route-modeling",
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
