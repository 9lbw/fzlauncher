![fzlauncher logo](logo.png)

# fzlauncher

Fast, cached, fzf-powered application launcher for Hyprland. It scans system and user .desktop files, builds a cache, and lets you fuzzy-search and launch apps via `hyprctl`.

## Features

- Parses .desktop files in parallel for speed
- Caches results and refreshes automatically when files change
- Respects `NoDisplay=true` entries
- Uses your pywal fzf theme if `~/.cache/wal/colors-fzf.sh` exists
- Launches apps through `hyprctl dispatch exec`

## Requirements

- Linux with .desktop files under `/usr/share/applications` and/or `~/.local/share/applications`
- Python 3.9+
- `fzf`
- Hyprland (`hyprctl` on PATH)

## Install

```bash
# Put the script on your PATH
mkdir -p ~/.local/bin
cp fzlauncher ~/.local/bin/
chmod +x ~/.local/bin/fzlauncher
# Ensure ~/.local/bin is on PATH (typical for most distros)
```

## Usage

```bash
fzlauncher
```

- Type to filter, Enter to launch, Esc to cancel.
- First run builds a cache; subsequent runs are instant.

Optional Hyprland example:

```ini
# hyprland.conf
$menu = foot --app-id fzf-launcher -e fzlauncher

windowrulev2 = float, class:(fzf-launcher)
windowrulev2 = center, class:(fzf-launcher)
windowrulev2 = pin, class:(fzf-launcher)
windowrulev2 = noborder, class:(fzf-launcher)
windowrulev2 = animation fadeIn, class:(fzf-launcher)
windowrulev2 = stayfocused, class:(fzf-launcher)
```

## License

Licensed under the BSD 2-Clause License. See [LICENSE](LICENSE) for details.