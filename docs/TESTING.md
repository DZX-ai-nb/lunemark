# Testing Record

## Environment

- Date: 2026-08-21
- OS: Windows
- Toolchain: `moon 0.1.20260803`
- Compiler: `moonc v0.10.6+80dc50f24`

## Commands

```sh
moon fmt
moon fmt --check
moon check --deny-warn
moon build
moon test
moon run cmd/main
moon run examples/partial
```

## Results

- `moon test`: 8 tests, 8 passed, 0 failed.
- `moon run cmd/main`: printed originality atlas report, draft launch milestone report, and sealed release badge.
- `moon run examples/partial`: printed compact launch milestone badge and originality badge.
- Effective MoonBit source scale: 5980 non-empty, non-comment lines after the originality atlas expansion.

## Covered Cases

- Originality atlas returns five ranked nearest hits.
- Known release planner shape is detected as a 100% close match.
- Public originality API exposes an `ORBT-*` anti-collision badge.
- Complete milestones reach 100 and `Sealed`.
- Draft milestones report 48 and missing release work.
- Duplicate milestones do not inflate the score.
- Badge format contains level, score, and signature.
- Public API is usable from blackbox tests through `@lunemark`.

## Manual Notes

The project has no third-party runtime dependencies. CI repeats the same verification steps on Ubuntu after a public repository is pushed.
