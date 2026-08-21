# Originality Notes

Date: 2026-08-21

## Scope

This file records the public topic scan used to keep Lunemark away from nearby MoonBit hackathon projects. The README intentionally leads with Lunemark's own idea-fingerprint model instead of making these comparisons the product story.

Searches covered:

- `Lunemark MoonBit`
- `Lunemark Originality Atlas`
- `MoonBit originality atlas`
- `MoonBit project idea fingerprint`
- `site:mooncakes.io Lunemark`
- `site:mooncakes.io MoonBit originality`
- selected names and themes from the reviewer-feedback screenshots

## Nearby Public Projects

The public scan found several Mooncakes packages in the release-material and final-showcase family:

- [`JJ-ai-nb/moonbit-submit-guard`](https://mooncakes.io/docs/JJ-ai-nb/moonbit-submit-guard): repository readiness and command-list style project.
- [`NBB2006/docproof-harbor`](https://mooncakes.io/docs/NBB2006/docproof-harbor): README example, provenance, license, and release-material toolkit.
- [`SHX-ai-nb/capsuletrace-upload`](https://mooncakes.io/docs/SHX-ai-nb/capsuletrace-upload): capability-boundary and final-showcase trace validator.

The reviewer-feedback screenshots also pointed to the same general cluster: package pre-release inspection, review-feedback verification, README/source proof, robot-policy work, and capsule-style trace records.

## Risk Removed

Old Lunemark risk:

- A launch milestone score was previously the first feature a reviewer saw.
- Public names used evidence, finding, traceable history, and similar wording.
- README examples were easy to mistake for another repository-readiness helper.

Changes applied:

- Main feature is now `IdeaProfile` plus `analyze_originality`.
- `archetype_catalog` provides 281 built-in comparison shapes.
- `closest_archetypes` computes ranked nearest neighbors for idea fingerprints.
- `ORBT-*` signatures identify a stable topic fingerprint.
- Launch milestones remain as secondary project-status output.
- Public launch API now uses `Milestone`, `MilestoneGap`, and `CommitHistory` instead of older evidence/finding/trace naming.

## Current Differentiation

Lunemark is not a repository file scanner and does not parse a README, license file, CI log, or Git history. Its core data is a 12-axis idea profile and an internal archetype atlas.

Concrete boundaries:

- Input: a project idea profile, not a filesystem snapshot.
- Core operation: numeric idea-distance comparison, not a release-material rule list.
- Output: originality score, closest archetypes, differentiators, rewrite prompt, and `ORBT-*` signature.
- Secondary output: launch milestone score for README or issue comments.
- Non-goal: legal license judgment or guaranteed global uniqueness.

## Current Self-Result

`moon run cmd/main` reports:

```text
novelty: 81/100
signature: ORBT-81-5rz
closest archetypes:
- ARCH-262 data-codec archetype 262 (28%)
- ARCH-054 data-codec archetype 054 (24%)
- ARCH-062 config-safety archetype 062 (24%)
- ARCH-073 community-ops archetype 073 (24%)
- ARCH-071 security-lens archetype 071 (20%)
```

No nearest internal archetype is above 30% similarity under the strict near-duplicate threshold.

## Remaining Note

This scan cannot prove that no private, unpublished, or later-created project is similar. Before final publication, repeat the search against mooncakes.io and public GitHub results, then update this file with exact dates and links.
