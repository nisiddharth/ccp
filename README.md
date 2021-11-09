# CCP color Picker

A color picker tool for X11.

<p align="center">
  <img src="screenshot.png" alt="Screenshot">
</p>

The CCP color Picker (CCP) is a simple color picker for X11 in POSIX which uses `xdotool` to get mouse position, `convert` for getting color values, `xclip` to copy it to clipboard and `notify-send` to show the color in a notification.

## Dependencies

```bash
xdotool
ImageMagick
xclip
libnotify-bin
```

## Install

Copy [`ccp`](ccp) to `~/.local/bin/`, like so:

```bash
curl https://raw.githubusercontent.com/nisiddharth/ccp/main/ccp > ~/.local/bin/ccp && chmod +x ~/.local/bin/ccp
```

For further ease of use you can create a keyboard shortcut to run `ccp`.

## Usage

```
    Usage: ccp [rgb|h]
    rgb: use rgb value instead of hex
      h: help
```

## Example

```bash
ccp
```
