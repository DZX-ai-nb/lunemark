# Testing Record

## Environment

- Date: 2026-08-10
- OS: Windows
- Toolchain: `moon 0.1.20260803`
- Compiler: `moonc v0.10.6+80dc50f24`

## Commands

```sh
moon fmt
moon test
moon run cmd/main
moon run examples/partial
```

## Results

- `moon test`: 5 tests, 5 passed, 0 failed.
- `moon run cmd/main`: printed draft report and sealed release badge.
- `moon run examples/partial`: printed compact blocked badge.

## Covered Cases

- Complete evidence reaches 100 and `Sealed`.
- Draft evidence reports 48 and missing release work.
- Duplicate evidence does not inflate the score.
- Badge format contains level, score, and signature.
- Public API is usable from blackbox tests through `@lunemark`.

## Manual Notes

The project has no third-party runtime dependencies. CI repeats the same verification steps on Ubuntu after a public repository is pushed.
