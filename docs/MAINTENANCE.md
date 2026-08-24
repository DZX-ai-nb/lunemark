# Maintenance Notes

## Ownership Boundary

Lunemark owns deterministic date conversion, coarse Moon phase estimation, lane scoring, rule matching, report formatting, and iCalendar text export. Location-aware tide tables, weather services, and high-precision ephemerides should stay in separate packages.

## Versioning

- Patch version: documentation fixes, small wording updates, and internal refactors.
- Minor version: new output formats, new lanes, additional rule families, or compatible scoring improvements.
- Major version: incompatible changes to phase thresholds, public data structures, or signature format.

## Compatibility

`LNR-*` signatures depend on the date, phase, lane, and final score. Changes to phase thresholds or lane scoring should be called out in `CHANGELOG.md` and covered by tests.

## Issue Workflow

Use the issue templates for phase bugs, rule changes, and feature requests. Keep each issue scoped to one visible behavior.
