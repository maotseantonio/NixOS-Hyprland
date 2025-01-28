#!/usr/bin/env bash 
pushd ~/NixOS-Hyprland 
sudo nixos-rebuild switch --flake .#"$hostname"
popd
notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
