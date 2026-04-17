# anshul-garg27/homebrew-tap

Homebrew tap for Anshul Garg's open-source tools.

## Install a formula

```bash
brew install anshul-garg27/tap/<formula>
```

Or tap first, then install:

```bash
brew tap anshul-garg27/tap
brew install <formula>
```

## Available formulas

- **claude-picker** — Terminal session manager for Claude Code. File-pivot, time-travel replay, cost audit. Rust + Ratatui.
  - `brew install anshul-garg27/tap/claude-picker`
  - Source: <https://github.com/anshul-garg27/claude-picker>

## How this tap is maintained

Formulas are generated and pushed automatically by
[`cargo-dist`](https://github.com/axodotdev/cargo-dist) from the upstream
repository's release workflow. See each source repo's `release.yml` for
details. Do not edit `Formula/*.rb` by hand — they will be overwritten on the
next release.
