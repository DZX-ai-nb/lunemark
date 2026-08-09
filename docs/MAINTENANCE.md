# Maintenance Notes

## Ownership Boundary

Lunemark owns only the acceptance evidence model and deterministic report formatting. Integrations should stay in separate packages so the core remains easy to test.

## Versioning

- Patch version: text fixes, small action wording updates, internal refactors.
- Minor version: new output formats or optional scanner packages.
- Major version: evidence order, scoring weights, or signature format changes.

## Compatibility

The signature depends on evidence order and weights. Any change to either should be called out in `CHANGELOG.md` and should update tests.

## Issue Workflow

Use `.github/ISSUE_TEMPLATE/acceptance_gap.md` for missing evidence work. Keep each issue scoped to one acceptance gap when possible.
