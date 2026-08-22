# Release Checklist

## 0.2.1 Planned Release

Before publishing to mooncakes.io:

1. Create or choose a public GitHub repository.
2. Confirm `DZX-ai-nb/lunemark` in:
   - `moon.mod`
   - `cmd/main/moon.pkg`
   - `examples/partial/moon.pkg`
   - README snippets
3. Confirm `repository` in `moon.mod` points to the public repository URL.
4. Run local verification:

```sh
moon fmt --check
moon check --deny-warn
moon build
moon test
moon run cmd/main
moon run examples/partial
```

5. Commit all changes.
6. Push to the public repository.
7. Confirm GitHub Actions passes.
8. Log in locally:

```sh
moon login
```

9. Publish:

```sh
moon publish
```

10. Create and push the version tag:

```sh
git tag v0.2.1
git push origin v0.2.1
```

11. Add the mooncakes.io package URL to the README after publication.

## Artifact Links

Keep these links for the final project showcase:

- Public repository URL
- GitHub Actions run URL
- mooncakes.io package URL
- Git tag URL
- Issue or PR links used during development
