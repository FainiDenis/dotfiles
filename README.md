# My dotfiles

## What pushed me to build this

I got tired of my machine eventually getting cluttered, running out of storage, or just becoming messy enough that I would reformat it. Before every reset, I back up important data to an external hard drive through my NAS.

I did not want to rely on Time Machine restores, so a clean reinstall became my default path. That made repeatable setup a requirement, not a nice-to-have.

## Why I created this

These dotfiles are my repeatable workstation blueprint. I wanted one place to store shell behavior, git defaults, editor preferences, and install steps so a fresh laptop or VM can feel familiar in minutes instead of hours.

This repository started as a fork from [holman/dotfiles](https://github.com/holman/dotfiles), but it is maintained here as my own day-to-day configuration.

## Introduction

Personal workstation setup for macOS, managed as a topic-based dotfiles repo.

## What this repo does

- Keeps shell, git, editor, and system preferences versioned.
- Installs packages from `Brewfile`.
- Runs per-topic install scripts (for example, Homebrew/macOS setup).
- Symlinks `*.symlink` files into `$HOME`.

## Layout

- `bin/`: helper scripts added to your `PATH`.
- `*/path.zsh`: path setup loaded early.
- `*.zsh`: shell config loaded by topic.
- `*/completion.zsh`: completion setup loaded late.
- `*/install.sh`: installer entry points run by `script/install`.
- `*.symlink`: files linked into `$HOME` by bootstrap.

## Install

```sh
git clone https://github.com/fainidenis/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

`script/bootstrap` handles symlinks and triggers the install flow.

## Update flow

Use these commands after pulling changes:

```sh
cd ~/.dotfiles
script/install
```

`script/install` runs:

1. `brew bundle`
2. Each `install.sh` found in the repo

## Customize

- Start with `zsh/zshrc.symlink` for machine-specific shell settings.
- Add a new topic directory when you want to isolate config by tool/domain.
- Keep local-only secrets out of git.

## Notes

- This setup is optimized for macOS.
- Some install steps are intentionally unchanged, so rerunning scripts is expected.

## License

[MIT](LICENSE.md)
