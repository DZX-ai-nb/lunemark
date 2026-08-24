# Contributing

## Workflow

1. Open an issue for a phase-calculation bug, rule-catalog change, output-format change, or documentation fix.
2. Make focused commits with testable messages.
3. Run local checks before opening a pull request:

```sh
moon fmt --check
moon check --deny-warn
moon build
moon test
moon run cmd/main
moon run examples/partial
```

4. Update `CHANGELOG.md` for user-visible behavior changes.
5. Update `docs/DESIGN.md` when date math, phase thresholds, lane scoring, or ICS output changes.

## Commit Style

Use short imperative messages, for example:

- `Add lunar rhythm scoring`
- `Cover iCalendar export`
- `Document phase approximation bounds`
