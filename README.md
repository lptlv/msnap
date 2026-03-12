# msnap

Screenshot and screencast utility built for [mangowm](https://github.com/mangowm/mango).

https://github.com/user-attachments/assets/53a4c616-3a6f-4400-ae9c-a15e277e710f

---

## Dependencies

| Tool | Purpose |
|------|---------|
| [`grim`](https://gitlab.freedesktop.org/emersion/grim) | Screenshot capture |
| [`slurp`](https://github.com/emersion/slurp) | Region selection |
| [`wl-copy`](https://github.com/bugaevc/wl-clipboard) | Clipboard |
| [`notify-send`](https://gitlab.gnome.org/GNOME/libnotify) | Notifications |
| [`wayfreeze`](https://github.com/Jappie3/wayfreeze) | Freeze screen before capture |
| [`satty`](https://github.com/gabm/Satty) | Screenshot annotation |
| [`gpu-screen-recorder`](https://git.dec05eba.com/gpu-screen-recorder/) | Screen recording |
| [`quickshell` (`qs`)](https://github.com/quickshell-mirror/quickshell) | GUI |
| [`ffmpeg`](https://git.ffmpeg.org/ffmpeg.git) | Recording thumbnail generation |

---

## Installation

### Install Script

```sh
curl -fsSL https://raw.githubusercontent.com/atheeq-rhxn/msnap/main/install.sh | sh
```

Installs to user paths under `XDG_BIN_HOME`, `XDG_CONFIG_HOME`, and `XDG_DATA_HOME`. See [XDG paths](#xdg-paths) below.

> Ensure `~/.local/bin` (or `$XDG_BIN_HOME`) is in your `PATH`.

### Package (System Install)

Install via your distribution's package manager. System paths are used — no user config is created until first run.

---

## XDG Paths

msnap follows the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/latest/). All paths respect the standard environment variables:

| Variable | Default |
|----------|---------|
| `XDG_CONFIG_HOME` | `~/.config` |
| `XDG_CONFIG_DIRS` | `/etc/xdg` |
| `XDG_DATA_HOME` | `~/.local/share` |
| `XDG_BIN_HOME` | `~/.local/bin` *(non-standard)* |

### Installed Paths

| Component | User Install | System Install |
|-----------|--------------|----------------|
| CLI | `$XDG_BIN_HOME/msnap` | `/usr/bin/msnap` |
| Config | `$XDG_CONFIG_HOME/msnap/msnap.conf` | `/etc/xdg/msnap/msnap.conf` |
| GUI | `$XDG_CONFIG_HOME/msnap/gui/` | `/etc/xdg/msnap/gui/` |
| Desktop entry | `$XDG_DATA_HOME/applications/msnap.desktop` | `/usr/share/applications/msnap.desktop` |
| Icon | `$XDG_DATA_HOME/icons/hicolor/scalable/apps/msnap.svg` | `/usr/share/icons/hicolor/scalable/apps/msnap.svg` |

### Config Search Order

Config is resolved in this order, first match wins:

1. `$XDG_CONFIG_HOME/msnap/` — user config (highest priority)
2. `$XDG_CONFIG_DIRS/msnap/` — system config (fallback)

---

## Usage

```sh
msnap shot [OPTIONS]    # Take a screenshot
msnap cast [OPTIONS]    # Record screen
```

### `msnap shot`

| Flag | Argument | Description |
|------|----------|-------------|
| *(no flags)* | | Full screen screenshot |
| `-r`, `--region` | | Interactive region selection |
| `-g`, `--geometry` | `X,Y WxH` | Capture a fixed geometry region |
| `-w`, `--window` | | Capture the active window |
| `-p`, `--pointer` | | Include mouse pointer |
| `-a`, `--annotate` | | Open in Satty for annotation after capture |
| `-F`, `--freeze` | | Freeze screen before capturing |
| `-o`, `--output` | `DIR` | Output directory |
| `-f`, `--filename` | `NAME` | Output filename or pattern |
| `-n`, `--no-copy` | | Skip copying to clipboard |
| `-c`, `--only-copy` | | Copy to clipboard only, don't save file |

### `msnap cast`

| Flag | Argument | Description |
|------|----------|-------------|
| *(no flags)* | | Record full screen |
| `-r`, `--region` | | Interactive region selection |
| `-g`, `--geometry` | `X,Y WxH` | Record a fixed geometry region |
| `-t`, `--toggle` | | Toggle recording on/off |
| `-a`, `--audio` | | Record system audio |
| `-m`, `--mic` | | Record microphone |
| `-A`, `--audio-device` | `DEVICE` | System audio device (default: `default_output`) |
| `-M`, `--mic-device` | `DEVICE` | Microphone device (default: `default_input`) |
| `-o`, `--output` | `DIR` | Output directory |
| `-f`, `--filename` | `NAME` | Output filename or pattern |

---

## GUI

Launch the GUI directly:

```sh
qs -p ~/.config/msnap/gui
```

Or search for **msnap** in your application launcher.

### Keyboard Shortcuts

| Key | Action |
|-----|--------|
| `H` / `L` | Navigate capture modes |
| `J` / `K` | Switch between Screenshot and Record |
| `Tab` | Toggle mode |
| `Enter` / `Space` | Execute action |
| `P` | Toggle pointer *(screenshot only)* |
| `E` | Toggle annotation *(screenshot only)* |
| `A` | Toggle system audio *(recording only)* |
| `M` | Toggle microphone *(recording only)* |
| `Escape` | Close / stop recording |

When recording, a red indicator appears in the top-right corner — hover and click to stop.

---

## Configuration

Config files live in `$XDG_CONFIG_HOME/msnap/` (default: `~/.config/msnap/`).

### `msnap.conf`

Controls screenshot and recording defaults.

| Key | Default | Description |
|-----|---------|-------------|
| `shot_output_dir` | `~/Pictures/Screenshots` | Screenshot save directory |
| `shot_filename_pattern` | `%Y%m%d%H%M%S.png` | Screenshot filename pattern |
| `shot_pointer_default` | `false` | Include pointer by default |
| `cast_output_dir` | `~/Videos/Screencasts` | Recording save directory |
| `cast_filename_pattern` | `%Y%m%d%H%M%S.mp4` | Recording filename pattern |

### `gui.conf`

Controls GUI theme (colors, accents, alphas) and behaviour (`quick_capture`).

### Value Precedence

Options are resolved in this order, highest priority first:

1. CLI flags (e.g. `--output`, `--filename`)
2. `msnap.conf` values
3. XDG environment variables (e.g. `XDG_PICTURES_DIR`, `XDG_VIDEOS_DIR`)
4. Built-in defaults

---

## mango Integration

Example keybinds for `mango.conf`:

```ini
# GUI
bind = none, Print, spawn, qs -p ~/.config/msnap/gui

# Screenshot: region
bind = SHIFT, Print, spawn_shell, msnap shot --region

# Screencast: toggle region recording
bind = SHIFT, ALT, spawn_shell, msnap cast --toggle --region
```

Add this layer rule to prevent the GUI from being animated or blurred:

```ini
layerrule = layer_name:msnap, noanim:1, noblur:1
```
