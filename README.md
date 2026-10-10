# rikshot/homebrew-tap

Homebrew formulae for [rsdirstat](https://github.com/rikshot/rsdirstat), a fast,
cross-platform disk usage analyzer with an interactive treemap GUI.

## Install

```sh
brew install rikshot/tap/rsdirstat
```

Or tap once and install by name:

```sh
brew tap rikshot/tap
brew install rsdirstat
```

This installs both binaries: `rsdirstat` (the treemap GUI) and `rsdirstat-cli` (the
terminal top-N reporter). Works on macOS and Linux (Intel and Apple Silicon / ARM).

## Maintenance

The formulae in `Formula/` are generated and pushed by rsdirstat's release workflow on
every release, so don't edit them by hand — changes belong in the
[rsdirstat](https://github.com/rikshot/rsdirstat) repository.
