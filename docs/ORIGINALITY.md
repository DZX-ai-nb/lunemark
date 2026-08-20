# Originality Check

Date: 2026-08-20

## Search Scope

Manual online search covered:

- `Lunemark MoonBit`
- `site:mooncakes.io Lunemark`
- `site:mooncakes.io moonbit-submit-guard`
- `Audit MoonBit project readiness for hackathon submission review`
- `MoonBit novelty fingerprint project idea`
- `MoonBit project differentiation`

## Similar Project Found

The search found `JJ-ai-nb/moonbit-submit-guard` on mooncakes.io:

- <https://mooncakes.io/docs/JJ-ai-nb/moonbit-submit-guard>

Its public description is a MoonBit hackathon submission readiness auditor, with APIs such as file snapshots, findings, status, project profile, and `audit_project`.

Similarity risk:

- Previous Lunemark scope: acceptance readiness scoring and missing checklist items.
- Similar package scope: submission readiness auditing for hackathon review.
- Result: the previous scope was too close and should not remain the lead feature.

## Pivot Applied

Lunemark 0.2.0 now leads with an originality engine:

- `IdeaProfile`: multi-axis project idea fingerprint.
- `Archetype`: built-in comparison shape.
- `archetype_catalog`: 281 internal reference archetypes.
- `closest_archetypes`: nearest-neighbor similarity search.
- `analyze_originality`: novelty score, closest hits, differentiators, rewrite prompt, and `ORBT-*` anti-collision signature.

The acceptance scoring API remains as a secondary release-readiness helper, but it is no longer the main project topic.

## Current Differentiation

Lunemark now differs from a submission guard in four concrete ways:

- It analyzes project ideas before implementation rather than auditing repository files after implementation.
- It compares against a built-in archetype atlas instead of checking a fixed submission checklist.
- It outputs anti-collision rewrite prompts and differentiators.
- It treats future maintenance lanes as part of the originality report.

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

## Remaining Submission Note

This local check cannot prove that no private, unpublished, or later-created project is similar. Before final submission, repeat the same search against mooncakes.io and the public GitHub repository index, then update this file.
