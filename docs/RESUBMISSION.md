# Resubmission Notes

Date: 2026-08-24

## Why The Topic Changed

The previous public framing, `Lunemark Originality Atlas`, was rejected because it overlapped with `constraint-lens` around novelty and topic-review workflows. The new `0.3.0` scope removes that workflow entirely.

## New Scope

Lunemark is now a deterministic MoonBit phase-aware planning window scorer. Its public API centers on:

- Gregorian date modeling
- coarse Moon phase estimation
- lunar-day and illumination scoring
- planning lanes for observation, tide watch, garden planning, deep work, rest, and event timing
- a 576-rule rhythm catalog used by the scorer
- best-window selection
- text and iCalendar output

It is intentionally not a Chinese-calendar package like `tyme4mb`, and not a Cron/RRULE scheduler like `moon-schedule`.

## Explicit Non-Goals

The project does not review submissions, compare project topics, audit GitHub repositories, judge README quality, or claim uniqueness against other packages.

## Acceptance Evidence

The required acceptance surface remains intact:

- MoonBit is the primary implementation language.
- README explains purpose, features, usage, examples, tests, CI, and license.
- `moon test` covers the core lunar calendar paths.
- `moon run cmd/main` and `moon run examples/partial` are runnable examples.
- `.github/workflows/ci.yml` runs format, check, build, test, and examples.
- `moon.mod` keeps the publishable package name `DZX-ai-nb/lunemark`.
