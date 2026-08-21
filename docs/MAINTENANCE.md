# Maintenance Notes

## Ownership Boundary

Lunemark owns the originality fingerprint model, built-in archetype atlas, deterministic report formatting, and the secondary launch milestone model. Integrations should stay in separate packages so the core remains easy to test.

## Versioning

- Patch version: text fixes, small action wording updates, internal refactors.
- Minor version: new output formats or optional scanner packages.
- Major version: milestone order, scoring weights, or signature format changes.

## Compatibility

`LMK-*` signatures depend on milestone order and weights. `ORBT-*` signatures depend on profile axes and novelty scoring. Any change to these inputs should be called out in `CHANGELOG.md` and should update tests.

## Issue Workflow

Use `.github/ISSUE_TEMPLATE/launch_milestone.md` for missing launch-milestone work. Keep each issue scoped to one visible project gap when possible.
