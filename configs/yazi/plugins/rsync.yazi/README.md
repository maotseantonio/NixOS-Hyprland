# rsync.yazi

A [yazi](https://yazi-rs.github.io/) plugin for simple rsync copying locally and up to remote servers.

![Demo](assets/demo.gif)
Thanks to [chrissabug](https://x.com/chrissabug) for creating lovely art!

## Pre-reqs

1. yazi 3.0+
2. rsync
3. passwordless authentication if copying to a remote server

## Installation

```sh
ya pack -a GianniBYoung/rsync
```

## Usage

Add the binds to your `~/.config/yazi/keymap.toml`

**WARNING:** Make sure the chosen binding isn't already in use!!

```toml
[[manager.prepend_keymap]]
on   = "R"
run  = "plugin rsync"
desc = "Copy files using rsync"
```

### Specify Default Remote Server

```toml
[[manager.prepend_keymap]]
on   = "R"
run  = "plugin rsync --args='user@server.com'"
desc = "Copy files using rsync to default location"
```

## Troubleshooting

Basic logging information is sent to `~/.local/state/yazi/yazi.log`

*Note: This plugin has only been tested on linux

## Contributing

Run into a bug or want a certain feature added? Submit an issue!

PRs welcome :)

Please keep in mind the yazi plugin system is still very new - as more features are added

more possibilities will open up for this plugin!
