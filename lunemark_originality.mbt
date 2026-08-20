///|
/// A project idea encoded as a small feature-space fingerprint.
pub(all) struct IdeaProfile {
  name : String
  thesis : String
  audience : String
  mechanism : String
  axis_namespace : Int
  axis_runtime : Int
  axis_docs : Int
  axis_ci : Int
  axis_release : Int
  axis_originality : Int
  axis_maintenance : Int
  axis_data : Int
  axis_interactive : Int
  axis_security : Int
  axis_portability : Int
  axis_community : Int
} derive(Eq, Debug)

///|
/// One reference project shape used by the originality atlas.
pub(all) struct Archetype {
  id : String
  title : String
  family : String
  mechanism : String
  audience : String
  axis_namespace : Int
  axis_runtime : Int
  axis_docs : Int
  axis_ci : Int
  axis_release : Int
  axis_originality : Int
  axis_maintenance : Int
  axis_data : Int
  axis_interactive : Int
  axis_security : Int
  axis_portability : Int
  axis_community : Int
} derive(Eq, Debug)

///|
/// A nearest-neighbor hit from the internal originality atlas.
pub(all) struct SimilarityHit {
  id : String
  title : String
  family : String
  similarity : Int
  distance : Int
  reason : String
} derive(Eq, Debug)

///|
/// Output of the originality guardrail.
pub(all) struct OriginalityReport {
  idea : IdeaProfile
  novelty_score : Int
  closest : Array[SimilarityHit]
  differentiators : Array[String]
  rewrite_prompt : String
  anti_collision_signature : String
} derive(Eq, Debug)

///|
/// The current Lunemark idea after the anti-duplication pivot.
pub fn lunemark_profile() -> IdeaProfile {
  IdeaProfile::{
    name: "Lunemark Originality Atlas",
    thesis: "turn MoonBit project ideas into feature fingerprints, collision warnings, and maintenance routes",
    audience: "hackathon builders who need a distinct topic before publishing",
    mechanism: "multi-axis idea fingerprint plus built-in archetype atlas",
    axis_namespace: 9,
    axis_runtime: 3,
    axis_docs: 8,
    axis_ci: 5,
    axis_release: 6,
    axis_originality: 10,
    axis_maintenance: 8,
    axis_data: 7,
    axis_interactive: 4,
    axis_security: 3,
    axis_portability: 6,
    axis_community: 7,
  }
}

///|
/// Analyze one idea against the built-in atlas and return an originality report.
pub fn analyze_originality(profile : IdeaProfile) -> OriginalityReport {
  let closest = closest_archetypes(profile, 5)
  let top_similarity = if closest.is_empty() {
    0
  } else {
    closest[0].similarity
  }
  let novelty = clamp_int(100 - top_similarity + novelty_bonus(profile), 0, 100)
  OriginalityReport::{
    idea: profile,
    novelty_score: novelty,
    closest,
    differentiators: differentiators(profile, top_similarity),
    rewrite_prompt: rewrite_prompt(profile, top_similarity),
    anti_collision_signature: originality_signature(profile, novelty),
  }
}

///|
/// Find the closest catalog archetypes.
pub fn closest_archetypes(
  profile : IdeaProfile,
  limit : Int,
) -> Array[SimilarityHit] {
  let hits = []
  for item in archetype_catalog() {
    let distance = idea_distance(profile, item)
    hits.push(SimilarityHit::{
      id: item.id,
      title: item.title,
      family: item.family,
      similarity: similarity_from_distance(distance),
      distance,
      reason: similarity_reason(profile, item),
    })
  }
  hits.sort_by((a, b) => b.similarity - a.similarity)
  take_hits(hits, limit)
}

///|
/// Render the originality report for terminal output.
pub fn format_originality_report(report : OriginalityReport) -> String {
  let out = StringBuilder()
  out.write_string("Lunemark originality atlas for " + report.idea.name + "\n")
  out.write_string("novelty: " + report.novelty_score.to_string() + "/100\n")
  out.write_string("signature: " + report.anti_collision_signature + "\n")
  out.write_string("mechanism: " + report.idea.mechanism + "\n")
  out.write_string("closest archetypes:\n")
  for hit in report.closest {
    out.write_string(
      "- " +
      hit.id +
      " " +
      hit.title +
      " (" +
      hit.similarity.to_string() +
      "%) -> " +
      hit.reason +
      "\n",
    )
  }
  out.write_string("differentiators:\n")
  for item in report.differentiators {
    out.write_string("- " + item + "\n")
  }
  out.write_string("rewrite prompt: " + report.rewrite_prompt + "\n")
  out.to_string()
}

///|
/// Compact originality badge.
pub fn originality_badge(report : OriginalityReport) -> String {
  "Originality " +
  report.novelty_score.to_string() +
  "% " +
  report.anti_collision_signature
}

///|
fn take_hits(hits : Array[SimilarityHit], limit : Int) -> Array[SimilarityHit] {
  let result = []
  let mut i = 0
  while i < hits.length() && i < limit {
    result.push(hits[i])
    i = i + 1
  }
  result
}

///|
fn idea_distance(profile : IdeaProfile, item : Archetype) -> Int {
  abs_int(profile.axis_namespace - item.axis_namespace) +
  abs_int(profile.axis_runtime - item.axis_runtime) +
  abs_int(profile.axis_docs - item.axis_docs) +
  abs_int(profile.axis_ci - item.axis_ci) +
  abs_int(profile.axis_release - item.axis_release) +
  abs_int(profile.axis_originality - item.axis_originality) +
  abs_int(profile.axis_maintenance - item.axis_maintenance) +
  abs_int(profile.axis_data - item.axis_data) +
  abs_int(profile.axis_interactive - item.axis_interactive) +
  abs_int(profile.axis_security - item.axis_security) +
  abs_int(profile.axis_portability - item.axis_portability) +
  abs_int(profile.axis_community - item.axis_community)
}

///|
fn similarity_from_distance(distance : Int) -> Int {
  // Treat only very close vectors as collision risks; broad ecosystem neighbors
  // should inform differentiation without being called duplicates.
  clamp_int(100 - distance * 100 / 25, 0, 100)
}

///|
fn novelty_bonus(profile : IdeaProfile) -> Int {
  let mut bonus = 0
  if profile.axis_originality >= 8 {
    bonus = bonus + 4
  }
  if profile.axis_maintenance >= 7 {
    bonus = bonus + 3
  }
  if profile.axis_data >= 6 && profile.axis_docs >= 6 {
    bonus = bonus + 2
  }
  bonus
}

///|
fn differentiators(
  profile : IdeaProfile,
  top_similarity : Int,
) -> Array[String] {
  let items = []
  if top_similarity >= 70 {
    items.push(
      "rename the public promise away from generic submission readiness",
    )
    items.push(
      "show the multi-axis idea fingerprint before any acceptance checklist",
    )
  } else {
    items.push(
      "lead with originality analysis rather than repository file auditing",
    )
    items.push(
      "use the built-in archetype atlas as a reusable MoonBit data engine",
    )
  }
  if profile.axis_originality >= 8 {
    items.push("keep anti-collision scoring as the core value proposition")
  }
  if profile.axis_maintenance >= 7 {
    items.push("ship maintenance routes and future lanes with every report")
  }
  if profile.axis_data >= 6 {
    items.push(
      "treat the catalog as versioned project intelligence, not decoration",
    )
  }
  items
}

///|
fn rewrite_prompt(profile : IdeaProfile, top_similarity : Int) -> String {
  if top_similarity >= 70 {
    "pivot " +
    profile.name +
    " toward originality fingerprints, atlas comparison, and topic reshaping"
  } else {
    "preserve " +
    profile.name +
    " as an originality-first MoonBit planning kernel with acceptance as a secondary output"
  }
}

///|
fn similarity_reason(profile : IdeaProfile, item : Archetype) -> String {
  if profile.mechanism == item.mechanism {
    "same mechanism"
  } else if profile.audience == item.audience {
    "same audience"
  } else if abs_int(profile.axis_originality - item.axis_originality) <= 1 &&
    abs_int(profile.axis_data - item.axis_data) <= 1 {
    "close originality and data axes"
  } else {
    "nearest numeric fingerprint"
  }
}

///|
fn originality_signature(profile : IdeaProfile, novelty : Int) -> String {
  let seed = profile.axis_namespace * 13 +
    profile.axis_runtime * 17 +
    profile.axis_docs * 19 +
    profile.axis_ci * 23 +
    profile.axis_release * 29 +
    profile.axis_originality * 31 +
    profile.axis_maintenance * 37 +
    profile.axis_data * 41 +
    profile.axis_interactive * 43 +
    profile.axis_security * 47 +
    profile.axis_portability * 53 +
    profile.axis_community * 59 +
    novelty * 61
  "ORBT-" +
  novelty.to_string() +
  "-" +
  pad3(positive_mod(seed, 46656).to_string(radix=36))
}

///|
fn abs_int(value : Int) -> Int {
  if value < 0 {
    -value
  } else {
    value
  }
}

///|
fn clamp_int(value : Int, lower : Int, upper : Int) -> Int {
  if value < lower {
    lower
  } else if value > upper {
    upper
  } else {
    value
  }
}
