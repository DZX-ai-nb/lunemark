# Maintenance Notes

## Ownership Boundary

Lunemark owns the originality fingerprint model, built-in archetype atlas, deterministic report formatting, and the secondary acceptance evidence model. Integrations should stay in separate packages so the core remains easy to test.

## Versioning

- Patch version: text fixes, small action wording updates, internal refactors.
- Minor version: new output formats or optional scanner packages.
- Major version: evidence order, scoring weights, or signature format changes.

## Compatibility

`LMK-*` signatures depend on evidence order and weights. `ORBT-*` signatures depend on profile axes and novelty scoring. Any change to these inputs should be called out in `CHANGELOG.md` and should update tests.

## Issue Workflow

Use `.github/ISSUE_TEMPLATE/acceptance_gap.md` for missing evidence work. Keep each issue scoped to one acceptance gap when possible.
