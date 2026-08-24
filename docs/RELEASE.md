# Release Checklist

## 0.3.0 Resubmission Release

Before resubmitting the form:

1. Push this 0.3.0 code to the public GitHub repository.
2. Confirm the default branch shows the new README title `Lunemark`.
3. Run local verification:

```sh
moon fmt --check
moon check --deny-warn
moon build
moon test --deny-warn
moon run cmd/main
moon run examples/partial
```

4. Confirm `moon version --all` reports `moonc >= v0.10.9`.
5. Confirm GitHub Actions passes.
6. Publish the new package version:

```sh
moon login
moon publish
```

7. Confirm mooncakes.io shows version `0.3.0` and the phase-aware planning window scorer description.
8. Use `PROPOSAL.md` as the one-page Markdown project proposal in the resubmission form.

## Links

- GitHub: <https://github.com/DZX-ai-nb/lunemark>
- mooncakes.io: <https://mooncakes.io/docs/DZX-ai-nb/lunemark>
