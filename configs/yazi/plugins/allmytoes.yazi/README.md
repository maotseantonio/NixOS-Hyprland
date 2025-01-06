# Allmytoes.yazi

Generate and preview freedesktop-compatible thumbnails for images on [Yazi](https://github.com/sxyazi/yazi) with the power of [AllMyToes](https://gitlab.com/allmytoes/allmytoes).

## Installation

```sh
# Linux only
git clone https://github.com/Sonico98/allmytoes.yazi.git ~/.config/yazi/plugins/allmytoes.yazi

```

## Usage

For the time being, it's recommended to follow [these steps](https://github.com/Sonico98/allmytoes.yazi/issues/1#issuecomment-2052600806) instead.

If you build yazi from source, starting from [commit c2affae](https://github.com/sxyazi/yazi/commit/c2affae3a9e7d33e69fc5a2d6dfb01dd252e25b0) you can add the following to your `yazi.toml` configuration file:
<details>
<summary>Only compatible with commit c2affae or higher (or yazi 0.2.6, to be released)</summary>
Add this to your `yazi.toml`:

```toml
[plugin]
prepend_previewers = [
	# Allmytoes doesn't handle these by default
	{ mime = "image/svg+xml", run = "magick" },
	{ mime = "image/heic",    run = "magick" },
	{ mime = "image/jxl",     run = "magick" },
	# Handle other image types with allmytoes
	{ mime = "image/*", run = "allmytoes" },
]

prepend_preloaders = [
	# Allmytoes doesn't handle these by default
	{ mime = "image/svg+xml", run = "magick" },
	{ mime = "image/heic",    run = "magick" },
	{ mime = "image/jxl",     run = "magick" },
	# Handle other image types with allmytoes
	{ mime = "image/*", run = "allmytoes" },
]


```
</details>

Make sure you have AllMyToes [installed](https://gitlab.com/allmytoes/allmytoes#installation) and in your PATH.

## Why would I want this instead of the default image previewer?

### Compatibility 

Because the thumbnails follow the freedesktop spec, they can be generated from any other application that follows the spec, like graphical file managers. This means you'll be able to re-use preexisting thumbnails between yazi and other programs.

### Fast

Once generated, yazi will display the largest thumbnail directly the next time you use it. It works just like how the default previewer caches images, but in a multi-application compatible way, and persistent across reboots by default.
In my limited, not benchmarked tests, I could notice faster image previews in directories containing multiple large images using allmytoes than with the default previewer.

