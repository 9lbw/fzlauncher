![fzlauncher logo](logo.png)

# fzlauncher

A fast, cached, Rofi-esque `fzf`-powered application launcher for Linux desktops. It scans `.desktop` files, builds a cache, and lets you fuzzy-search and launch applications universally.

## Requirements

-   Linux with `.desktop` files in standard directories (`/usr/share/applications` and `~/.local/share/applications`).
-   Python 3.9+
-   `fzf`

For terminal applications (`.desktop` files with `Terminal=true`) the launcher uses the command specified in the `$TERMINAL` environment variable.
If `$TERMINAL` is unset it falls back to `xterm -e`. Example:  
```bash
export TERMINAL="foot"
```

## Install

```bash
# Put the script in your PATH
mkdir -p ~/.local/bin
cp fzlauncher ~/.local/bin/
chmod +x ~/.local/bin/fzlauncher

# Ensure ~/.local/bin is in your PATH
```

## Usage

Simply run the script from your terminal or bind it to a key in your window manager's configuration file.

```bash
fzlauncher
```

-   Type to filter, <kbd>Enter</kbd> to launch, <kbd>Esc</kbd> to cancel.
-   The first run builds a cache; subsequent runs are instant.

### Optional: Example Workflow for a Tiling Window Manager

While `fzlauncher` works anywhere, you might want to configure your window manager to display it as a floating, centered window. Here is an example for Hyprland:

```ini
# hyprland.conf

# 1. Define a variable for the launcher command.
#    Replace 'foot' with your preferred terminal.
$menu = foot --app-id fzf-launcher -e fzlauncher

# 2. Add window rules to make it look like a launcher.
windowrulev2 = float, class:(fzf-launcher)
windowrulev2 = center, class:(fzf-launcher)
windowrulev2 = pin, class:(fzf-launcher)
windowrulev2 = noborder, class:(fzf-launcher)
windowrulev2 = animation fadeIn, class:(fzf-launcher)
windowrulev2 = stayfocused, class:(fzf-launcher)

# 3. Bind it to a key.
bind = $mainMod, D, exec, $menu
```

Similar rules can be created for other window managers like Sway or i3.

## License

Licensed under the BSD 2-Clause License. See [LICENSE](LICENSE) for details.