# Design Notes

## Purpose

Lunemark provides a small deterministic phase-aware planning window scorer for MoonBit projects. It is designed for tools that need a repeatable lunar rhythm signal without a network service, a full Chinese-calendar library, or a recurrence-rule scheduler.

## Data Model

- `CivilDate` stores a Gregorian date.
- `MoonPhase` represents eight coarse lunar phases.
- `RhythmLane` represents practical planning scenarios.
- `RhythmRule` stores a month, phase, lane, weight, and label.
- `DayRhythm` is the final analysis result for one date and one lane.

## Algorithm

The engine converts a Gregorian date to Julian Day Number using integer arithmetic. It then measures the offset from a fixed new-moon anchor and folds the result into a 29.53-day synodic month represented in thousandths of a day. That cycle value yields a phase, lunar day, and approximate illumination percentage.

The lane score starts from a phase-specific base score. `matching_rules` traverses the 576-rule catalog and keeps rules matching the date month, Moon phase, and planning lane. `catalog_score` adds those weights to the base score, and the result is clamped to 0-100.

## Outputs

The public API exposes date validation, lightweight phase helpers, terminal reports, compact badges, best-window sorting, default-threshold iCalendar text, and custom-threshold iCalendar text. The ICS output is intentionally simple so it can be consumed by tests, examples, or downstream adapters.

## Boundaries

The calculation is a software planning approximation. It does not replace professional ephemerides, local tide tables, weather forecasts, agriculture advice, or legal/operational review tools.
