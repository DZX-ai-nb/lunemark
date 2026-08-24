# Resubmission Form Notes

## Project Name

Lunemark Phase Window Scorer

## Repository

<https://github.com/DZX-ai-nb/lunemark>

## mooncakes.io

<https://mooncakes.io/docs/DZX-ai-nb/lunemark>

## One-Line Description

A deterministic MoonBit phase-aware planning window scorer for lunar rhythm signals, rule scoring, best-window selection, and iCalendar export.

## Existing Foundation

The project provides a MoonBit library, command-line example, embeddable example, 576-rule scoring catalog, tests, README, CI workflow, proposal, design notes, release notes, self-check notes, Apache-2.0 license, and mooncakes.io package configuration.

## Planned Work / Completed Work

The resubmission replaces the rejected topic-review direction with a lunar rhythm planning-window scorer. Implemented functionality includes Gregorian date validation, Moon phase estimation, lunar day and illumination helpers, lane scoring, rule matching, span analysis, best-window ranking, badges, and default/custom-threshold iCalendar export.

## Technical Route

The library converts dates to Julian Day Number using integer arithmetic, folds dates into an approximate synodic lunar cycle, derives phase and illumination, applies lane-specific base scores, adds matching catalog-rule weights, and formats the result for CLI, badges, and ICS output.

## Tests And CI

Local verification uses `moonc v0.10.10`, satisfying the `>= v0.10.9` requirement. CI enforces that version floor and runs `moon fmt --check`, `moon check --deny-warn`, `moon build`, `moon test --deny-warn`, `moon info`, and both runnable examples.

## Difference From Nearby Projects

This project does not implement feedback review or topic-collision workflows like `constraint-lens`, traditional Chinese-calendar features like `tyme4mb`, or Cron/RRULE recurrence scheduling like `moon-schedule`. Its boundary is phase-aware scoring for planning windows.
