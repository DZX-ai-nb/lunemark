# Testing Record

## Local Commands

```sh
moon fmt --check
moon check --deny-warn
moon build
moon test
moon run cmd/main
moon run examples/partial
```

## Covered Cases

- Public API formats a lunar rhythm report.
- Public API exports iCalendar text.
- Public API validates leap years and invalid dates.
- Public phase helpers match day analysis.
- Known new-moon anchor remains stable.
- Span analysis preserves requested length.
- Best windows are sorted by score.
- Rule catalog contains 500+ real data entries.
- Matching rules are reflected in day analysis.
- Compact badge includes phase, score, and `LNR-*` signature.
- Custom ICS threshold filters events.
- High-window predicate follows the default export threshold.

## Manual Review Notes

The project has no third-party runtime dependencies. The generated rule catalog is project-owned deterministic data and is used by the scoring pipeline. The latest local verification used `moonc v0.10.10`, satisfying the announcement requirement of `>= v0.10.9`.
