# rich-preview.yazi

Preview file types using `rich` command in Yazi. This plugin allows preview for various filetypes including -

- Markdown
- Jupyter notebook
- JSON
- CSV
- RestructuredText

## Previews/Screenshots

[rich-preview1.webm](https://github.com/user-attachments/assets/580e36a8-249f-48a8-95fc-8c3d60e6a7d7)

## Requirements

- [Yazi](https://github.com/sxyazi/yazi) v0.4 or higher.
- [rich-cli](https://github.com/Textualize/rich) v13.7.1 or higher.

## Installation

To install this plugin, simply run-

```bash
ya pack -a AnirudhG07/rich-preview
## For linux and MacOS
git clone https://github.com/AnirudhG07/rich-preview.yazi.git ~/.config/yazi/plugins/rich-preview.yazi

## For Windows
git clone https://github.com/AnirudhG07/rich-preview.yazi.git %AppData%\yazi\config\plugins\rich-preview.yazi
```

## Usages

The `rich` commands automatically detects if the file is markdown, csv, json, etc. files and accordingly the preview is viewed.

Add the below to your `yazi.toml` file to allow the respective file to previewed using `rich`.

```toml
[plugin]

prepend_previewers = [
    { name = "*.csv", run = "rich-preview"}, # for csv files
    { name = "*.md", run = "rich-preview" }, # for markdown (.md) files
    { name = "*.rst", run = "rich-preview"}, # for restructured text (.rst) files
    { name = "*.ipynb", run = "rich-preview"}, # for jupyter notebooks (.ipynb)
    { name = "*.json", run = "rich-preview"}, # for json (.json) files
#    { name = "*.lang_type", run = "rich-preview"} # for particular language files eg. .py, .go., .lua, etc.
]
```

## Configurations

If you would like to use `rich` with more configurations, you can go to `init.lua` and edit the arguments in the code with your preferences. You can view the options using `rich --help`.

```lua
-- init.lua
"-j",
"--left",
"--line-numbers",
"--force-terminal",
"--panel=rounded",
"--guides",
"--max-width" -- to area of preview
```

You can add more, remove and choose themes as you wish. You can set styles or Themes(as mentioned in `rich --help`) by `--theme=your_theme` and similarly for style.

## Notes

Currently the colors maynot be uniformly present, along with weird lines here and there. This is due to `"--force-terminal"` option. You can disable it if you find it annoying. Work is in progress to possibly fix the issue.

# Explore Yazi

Yazi is an amazing, blazing fast terminal file manager, with a variety of plugins, flavors and themes. Check them out at [awesome-yazi](https://github.com/AnirudhG07/awesome-yazi) and the official [yazi webpage](https://yazi-rs.github.io/).
