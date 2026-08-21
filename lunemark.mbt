///|
/// Launch milestones that Lunemark can summarize after the idea fingerprint.
pub(all) enum Milestone {
  MoonBitPrimary
  PublicRepository
  CompleteReadme
  PurposeAndUsage
  RunnableExample
  ContinuousIntegration
  RunnableTests
  BuildPasses
  MooncakesRelease
  CommitHistory
  BoundedScope
  LicenseClean
} derive(Eq, Debug)

///|
/// Coarse launch level derived from the score and remaining required items.
pub(all) enum LaunchState {
  Blocked
  Warming
  Ready
  Sealed
} derive(Eq, Debug)

///|
/// A missing launch milestone with a short repair action.
pub(all) struct MilestoneGap {
  milestone : Milestone
  weight : Int
  label : String
  action : String
} derive(Eq, Debug)

///|
/// Launch milestone result for one project.
pub(all) struct LaunchReport {
  name : String
  total_weight : Int
  earned_weight : Int
  score : Int
  level : LaunchState
  missing : Array[MilestoneGap]
  signature : String
} derive(Eq, Debug)

///|
/// Return every milestone in the stable order used by scoring and signing.
pub fn all_milestones() -> Array[Milestone] {
  [
    MoonBitPrimary,
    PublicRepository,
    CompleteReadme,
    PurposeAndUsage,
    RunnableExample,
    ContinuousIntegration,
    RunnableTests,
    BuildPasses,
    MooncakesRelease,
    CommitHistory,
    BoundedScope,
    LicenseClean,
  ]
}

///|
/// Human-facing label for a launch milestone.
pub fn Milestone::label(self : Milestone) -> String {
  match self {
    MoonBitPrimary => "MoonBit is the primary implementation language"
    PublicRepository => "public repository is reachable"
    CompleteReadme => "README is clear and complete"
    PurposeAndUsage => "purpose, features, and usage are documented"
    RunnableExample => "runnable example is provided"
    ContinuousIntegration => "CI workflow is configured"
    RunnableTests => "tests can be executed"
    BuildPasses => "project builds successfully"
    MooncakesRelease => "package is published to mooncakes.io"
    CommitHistory => "development commits and release notes are visible"
    BoundedScope => "feature boundary and maintenance value are clear"
    LicenseClean => "third-party code and assets are license-clean"
  }
}

///|
/// Repair action for a missing launch milestone.
pub fn Milestone::action(self : Milestone) -> String {
  match self {
    MoonBitPrimary =>
      "move core logic into .mbt files and keep non-MoonBit glue minimal"
    PublicRepository =>
      "push the repository to a public Git host and verify anonymous access"
    CompleteReadme =>
      "expand README.mbt.md and README.md with build, test, and publish notes"
    PurposeAndUsage =>
      "add a compact problem statement, feature list, and command examples"
    RunnableExample =>
      "add `moon run cmd/main` or an examples package with expected output"
    ContinuousIntegration =>
      "add a GitHub Actions workflow that runs check, build, test, and example"
    RunnableTests => "cover scoring edge cases with `moon test`"
    BuildPasses => "make `moon build` pass on a clean checkout"
    MooncakesRelease =>
      "run `moon login`, update the module namespace, then `moon publish`"
    CommitHistory =>
      "keep small Git commits, issues, changelog entries, and release tags"
    BoundedScope => "document non-goals and future maintenance lanes"
    LicenseClean => "record dependency and asset licenses before release"
  }
}

///|
/// Weight assigned to each launch milestone. The catalog totals 100.
pub fn Milestone::weight(self : Milestone) -> Int {
  match self {
    MoonBitPrimary => 12
    PublicRepository => 8
    CompleteReadme => 10
    PurposeAndUsage => 3
    RunnableExample => 8
    ContinuousIntegration => 10
    RunnableTests => 10
    BuildPasses => 12
    MooncakesRelease => 8
    CommitHistory => 8
    BoundedScope => 5
    LicenseClean => 6
  }
}

///|
/// Stable display label for a launch level.
pub fn LaunchState::label(self : LaunchState) -> String {
  match self {
    Blocked => "Blocked"
    Warming => "Warming"
    Ready => "Ready"
    Sealed => "Sealed"
  }
}

///|
/// Convenience wrapper for users who prefer a function over method syntax.
pub fn milestone_weight(milestone : Milestone) -> Int {
  milestone.weight()
}

///|
/// Build a detailed launch milestone report from a project name and observed milestones.
pub fn mark_launch(name : String, provided : Array[Milestone]) -> LaunchReport {
  let catalog = all_milestones()
  let mut total = 0
  let mut earned = 0
  let missing = []
  for milestone in catalog {
    let weight = milestone.weight()
    total = total + weight
    if provided.contains(milestone) {
      earned = earned + weight
    } else {
      missing.push(MilestoneGap::{
        milestone,
        weight,
        label: milestone.label(),
        action: milestone.action(),
      })
    }
  }
  let score = if total == 0 { 0 } else { earned * 100 / total }
  let level = launch_state(score, missing.length())
  LaunchReport::{
    name,
    total_weight: total,
    earned_weight: earned,
    score,
    level,
    missing,
    signature: sign(provided, earned, total),
  }
}

///|
/// A complete milestone set for README examples and smoke tests.
pub fn complete_milestones() -> Array[Milestone] {
  all_milestones()
}

///|
/// A realistic draft project that is not ready for release yet.
pub fn draft_milestones() -> Array[Milestone] {
  [
    MoonBitPrimary,
    CompleteReadme,
    PurposeAndUsage,
    RunnableExample,
    RunnableTests,
    BoundedScope,
  ]
}

///|
/// Format a launch milestone report for terminal output.
pub fn format_launch_report(report : LaunchReport) -> String {
  let out = StringBuilder()
  out.write_string("Lunemark report for " + report.name + "\n")
  out.write_string(
    "score: " +
    report.earned_weight.to_string() +
    "/" +
    report.total_weight.to_string() +
    " (" +
    report.score.to_string() +
    "%)\n",
  )
  out.write_string("level: " + report.level.label() + "\n")
  out.write_string("signature: " + report.signature + "\n")
  if report.missing.is_empty() {
    out.write_string("missing: none\n")
  } else {
    out.write_string("missing:\n")
    for gap in report.missing {
      out.write_string(
        "- [" +
        gap.weight.to_string() +
        "] " +
        gap.label +
        " -> " +
        gap.action +
        "\n",
      )
    }
  }
  out.to_string()
}

///|
/// Compact one-line status for release notes or issue comments.
pub fn launch_badge(report : LaunchReport) -> String {
  "Lunemark " +
  report.level.label() +
  " " +
  report.score.to_string() +
  "% " +
  report.signature
}

///|
fn launch_state(score : Int, missing_count : Int) -> LaunchState {
  if missing_count == 0 {
    Sealed
  } else if score >= 85 {
    Ready
  } else if score >= 60 {
    Warming
  } else {
    Blocked
  }
}

///|
fn sign(provided : Array[Milestone], earned : Int, total : Int) -> String {
  let mut mask = 0
  for milestone in all_milestones() {
    if provided.contains(milestone) {
      mask = mask + pow2(milestone_index(milestone))
    }
  }
  let token = positive_mod(mask * 97 + earned * 31 + total * 13, 46656)
  "LMK-" + earned.to_string() + "-" + pad3(token.to_string(radix=36))
}

///|
fn milestone_index(milestone : Milestone) -> Int {
  match milestone {
    MoonBitPrimary => 0
    PublicRepository => 1
    CompleteReadme => 2
    PurposeAndUsage => 3
    RunnableExample => 4
    ContinuousIntegration => 5
    RunnableTests => 6
    BuildPasses => 7
    MooncakesRelease => 8
    CommitHistory => 9
    BoundedScope => 10
    LicenseClean => 11
  }
}

///|
fn pow2(n : Int) -> Int {
  let mut result = 1
  let mut i = 0
  while i < n {
    result = result * 2
    i = i + 1
  }
  result
}

///|
fn positive_mod(value : Int, divisor : Int) -> Int {
  let result = value % divisor
  if result < 0 {
    result + divisor
  } else {
    result
  }
}

///|
fn pad3(value : String) -> String {
  if value.length() == 1 {
    "00" + value
  } else if value.length() == 2 {
    "0" + value
  } else {
    value
  }
}
