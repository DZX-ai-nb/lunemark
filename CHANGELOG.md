# Changelog

## 0.3.0 - 2026-08-24

- Reworked Lunemark into a deterministic phase-aware planning window scorer.
- Added Gregorian date modeling, Moon phase estimation, lunar-day and illumination scoring.
- Added six planning lanes: night-sky observation, tide watch, garden planning, deep work, wellness rest, and event timing.
- Added a 576-rule `RhythmRule` catalog used by the scoring pipeline.
- Added span analysis, best-window selection, compact rhythm badges, and iCalendar export.
- Added date validation helpers, lightweight phase helpers, custom ICS threshold export, and high-window predicates.
- Hardened CI with an explicit `moonc >= 0.10.9` version gate and `moon test --deny-warn`.
- Added final self-check and resubmission form notes for the August Hackathon.
- Replaced earlier topic-review wording, examples, tests, README, and proposal materials.

## 0.2.1 - 2026-08-22

- Published the previous package version to mooncakes.io.
- This version is superseded by 0.3.0 for resubmission.
