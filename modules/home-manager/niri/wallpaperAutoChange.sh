#!/usr/bin/env bash
    WALLPAPER_DIR="$HOME/Pictures/wallpapers"
    DAY=$(date +%j)
    WALLPAPER=$(ls -1 "$WALLPAPER_DIR" | sed -n "$(( (DAY % $(ls -1 "$WALLPAPER_DIR" | wc -l)) + 1 ))p")
    
    swww img "$WALLPAPER_DIR/$WALLPAPER" \
      --transition-type wipe \
      --transition-angle 30 \
      --transition-step 90
    
    wallust run -c "$HOME/.config/wallust/wallust.toml" "$WALLPAPER_DIR/$WALLPAPER"
