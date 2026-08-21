# Contributing

## Workflow

1. Open an issue for each launch-milestone gap or behavior change.
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
5. Update `docs/DESIGN.md` when weights, milestone order, or signing logic changes.

## Commit Style

Use short imperative messages, for example:

- `Add release milestone scoring`
- `Document mooncakes publish checklist`
- `Cover duplicate milestones in tests`
