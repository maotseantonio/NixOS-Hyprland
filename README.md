<h1 align="center">
   <img src="./.github/assets/logo/nixos-logo.png  " width="100px" /> 
   <br>
      Shizuru  
   <br>
    <br>
        My config is provided too much bleeding-edge. If you blindly run my install script, you got headache
    </br>
      <img src="./.github/assets/pallet/macchiato.png" width="600px" /> <br>

   <div align="center">
      <p></p>
      <div align="center">
         <a href="https://github.com/Frost-Phoenix/nixos-config/stargazers">
            <img src="https://img.shields.io/github/stars/maotseantonio/NixOS-Hyprland?color=A5ADCB&labelColor=1E1E2E&style=for-the-badge&logo=starship&logoColor=c6a0f6">
         </a>
         <a href="https://github.com/maotseantonio/NixOS-Hyprland/">
            <img src="https://img.shields.io/github/repo-size/maotseantonio/NixOS-Hyprland?color=A5ADCB&labelColor=1E1E2E&style=for-the-badge&logo=github&logoColor=C6A0F6">
         </a>
         <a = href="https://nixos.org">
            <img src="https://img.shields.io/badge/NixOS-unstable-blue.svg?style=for-the-badge&labelColor=1E1E2E&logo=NixOS&logoColor=C6A0F6&color=A5ADCB">
         </a>
         <a>
            <img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&colorA=1E1E2E&colorB=A5ADCB&logo=unlicense&logoColor=C6A0F6&"/>
         </a>
      </div>
      <br>
   </div>
</h1>


### 🖼️ Gallery for Hyprland

<p align="center">
   <img src="./.github/assets/screenshots/1.png" style="margin-bottom: 10px;"/> <br>
   <img src="./.github/assets/screenshots/2.png" style="margin-bottom: 10px;"/> <br>
   <img src="./.github/assets/screenshots/3.png" style="margin-bottom: 10px;"/> <br>
   <img src="./.github/assets/screenshots/4.png" style="margin-bottom: 10px;"/> <br>
   <img src="./.github/assets/screenshots/5.png" style="margin-bottom: 10px;"/> <br>
   <img src="./.github/assets/screenshots/6.jpg" style="margin-bottom: 10px;"/> <br>  
   <img src="./.github/assets/screenshots/7.png" style="margin-bottom: 10px;"/> <br>
   <img src="./.github/assets/screenshots/hyprlock.png" style="margin-bottom: 10px;"/> <br>

  Screenshots last updated <b>2025-3-12</b>
</p>

### 🖼️ Gallery for Niri the Goat

<p align="center">
   <img src="./.github/assets/screenshots/niri-1.png" style="margin-bottom: 10px;"/> <br>
   <img src="./.github/assets/screenshots/niri-2.png" style="margin-bottom: 10px;"/> <br>
   <img src="./.github/assets/screenshots/niri-3.png" style="margin-bottom: 10px;"/> <br>
   <img src="./.github/assets/screenshots/niri-4.png" style="margin-bottom: 10px;"/> <br>
   <img src="./.github/assets/screenshots/niri-5.png" style="margin-bottom: 10px;"/> <br>
   <img src="./.github/assets/screenshots/niri-6.png" style="margin-bottom: 10px;"/> <br>  
   <img src="./.github/assets/screenshots/hyprlock.png" style="margin-bottom: 10px;"/> <br>

  Screenshots last updated <b>2025-3-12</b>
</p>



# 🗃️ Overview
### My config was different from JaKooLit NixOS-Hyprland. Dont blindly use my install script. plz check the install.sh file.
### Now My Primary WM is Niri But I also update my hyprland and its config. good luck have fun. 
## 📚 Layout

-   [flake.nix](flake.nix) base of the configuration
-   [hosts](hosts) 🌳 per-host configurations that contain machine specific configurations
    - [default](hosts/default/) 🖥️Default configurations for my desktop if you have laptop, use hostname as shizuru
    - [shizuru](hosts/shizuru/) 💻 Laptop specific configuration for my like
        - [config](hosts/shizuru/config.nix) kernel packages(cachyos kernel), scx enable(scx_lavd) and system level packages
        - [hardware](hosts/shizuru/hardware.nix) hardware configuration
        - [user](hosts/shizuru/user.nix) user specific packages(shell)
        - [variables](hosts/shizuru/variables.nix) user variables git username email
-   [modules](modules) 🍱 for more modularize
  - [system](system) for system wide config
    - [bootloader](modules/system/bootloader.nix) kernel packages(cachyos kernel) grub2 plymouth theme(catppuccin)
    - [flatpak](modules/system/flatpak.nix) declarative flatpak
    - [fonts](modules/system/fonts.nix) fonts packages
    - [hardwareconf](modules/system/hardwareconf.nix) hardware configuration
    - [intel-driver](modules/system/intel-driver.nix) intel graphic intel-driver
    - [nvidia-driver](modules/system/nvidia-driver) nvidia graphic driver
    - [local-hardware-clock](modules/system/local-hardware-clock.nix)hardware clock(i dontknow this will be needed)
    - [network](modules/system/network.nix) network configuration 
    - [nvidia-prime](modules/system/nvidia-prime-driver) nvidia prime configuration
    - [nvidia-patch](modules/system/nvidia-patch) nvidia patch for linux 6.12 kernel
    - [services](modules/system/services.nix) services for nix system
    - [system](modules/system/system.nix) system specific packages and settings
    - [virtualization](modules/system/virtualization.nix) virtualization specific packages
    - [wayland](modules/system/wayland.nix) wayland specific packages
    - [packages](modules/system/packages.nix) packages config
    - [nix](modules/system/nix.nix) nix related settings
    - [niri](modules/system/niri.nix) niri flake for nixos
  - [home-manager](home-manager) home-manager config
    - [home](modules/home-manager/home.nix) home-manager config 
    - [vscodium](modules/home-manager/vscodium.nix) vscodium config 
    - [helix](modules/home-manager/helix.nix) helix config 
    - [spicetify](modules/home-manager/spicetify.nix) spotify client config
    - [nvchad](modules/home-manager/nvchad.nix) nvchad config
    - [textfox](modules/home-manager/textfox.nix)textfox config
    - [git](modules/home-manager/git)git config 
    - [gtk.nix](modules/home-manager/gtk.nix) themeing related 
    - [nixcord](modules/home-manager/nixcord.nix) vencord for nix way 
    - [HyprPanel](modules/home-manager/hyprpanel.nix) hm module for hyprpanel 
    - [nixy](modules/home-manager/nixy.nix) system utilities
    - [hom-packages](modules/home-manager/home-packages.nix) packages for user specific 
    - [fhsenv](modules/home-manager/fhsenv.nix) fhs enviornment(will remove in 25.11)
    - [anyrun](modules/home-manager/anyrun) anyrun for application launcher 
    - [niri](modules/home-manager/niri) niri settings via home-manager


## 📓 Components
|                             | NixOS + Hyprland                                                                              |
| --------------------------- | :---------------------------------------------------------------------------------------------:
| **Window Manager**          | [Hyprland] |
| **Bar**                     | [HyprPanel] |
| **Application Launcher**    | [walker] |
| **Notification Daemon**     | ags|
| **Terminal Emulator**       | Wezterm + kitty |
| **Shell**                   | fish + atuin + [Starship] |
| **Text Editor**             | [VSCodium] + nix4nvchad |
| **network management tool** | [NetworkManager] + [network-manager-applet] |
| **System resource monitor** | Btop + Bottom |
| **File Manager**            | thunar + [yazi] |
| **Fonts**                   | LigaMono Nerd Font + JetBrainsMono Nerd Font|
| **Color Scheme**            | Catppuccin-Mocha + Catppuccin-Dark |
| **Cursor**                  | Chiharu |
| **Icons**                   | [Papirus-Dark] |
| **Lockscreen**              | [Hyprlock] |
| **Image Viewer**            |  imv |
| **Media Player**            | [mpv] |
| **Music Player**            | spotify |
| **Screenshot Software**     | [grimblast] |
| **kernel**                  | [linux cachyos kernel] |
| **Clipboard**               | [wl-clip-persist] |
| **Color Picker**            | [hyprpicker] |


## 📝 Shell aliases

<details>
<summary>
Utils (EXPAND)
</summary>

- ```cl```     $\rightarrow$ ```clear```
- ```cd```    $\rightarrow$ ```z```
- ```tt```    $\rightarrow$ ```gtrash put```
- ```v```   $\rightarrow$ ```nvim```
- ```cat```   $\rightarrow$ ```bat```
- ```code```  $\rightarrow$ ```codium```
- ```icat```  $\rightarrow$ ```kitten icat```
- ```l```     $\rightarrow$ ```eza --icons  -a --group-directories-first -1```
- ```ll```    $\rightarrow$ ```eza --icons  -a --group-directories-first -1 --no-user --long```
- ```tree```  $\rightarrow$ ```eza --icons --tree --group-directories-first```
</details>

<details>
<summary>
Nixos (EXPAND)
</summary>

- ```fuckdit```      $\rightarrow$ ```cd ~/NixOS-Hyprland/ && codium ~/NixOS-Hyprland/```
- ```fucknix```   $\rightarrow$ ```sudo nixos rebuild switch --flake .#nixy4life```
</details>

<details>
<summary>
</summary>
</details>

## 🛠️ Scripts

All the scripts are in ```~/.config/home-manager/scripts/scripts/``` and are exported as packages in ```~/.config/home-manager/scripts/scripts.nix```

<details>
<summary>
extract.sh 
</summary>

**Description:** This script extract ```tar.gz``` archives in the current directory.

**Usage:** ```extract <archive_file>```
</details>

<details>
<summary>
compress.sh 
</summary>
</details>

<details>
<summary>
maxfetch.sh 
</summary>

**Description:** This script is a modified version of the [jobcmax/maxfetch][maxfetch] script.

**Usage:** ```maxfetch```
</details>

<details>
<summary>
music.sh 
</summary>

**Description:** This script is for managing Audacious (music player). If Audacious is currently running, it will be killed (stopping the music); otherwise, it will start Audacious in the 8th workspace and resume the music. 

**Usage:** ```music```
</details>

<details>
<summary>
runbg.sh 
</summary>

**Description:** This script runs a provided command along with its arguments and detaches it from the terminal. Handy for launching apps from the command line without blocking it. 

**Usage:** ```runbg <command> <arg1> <arg2> <...>```
</details>


```bash
nix-shell -p git
git clone https://github.com/maotseantonio/NixOS-Hyprland
cd NixOS-Hyprland
```
#### 3. **Install script**
> [!CAUTION]
> For some computers, the default rebuild command might get stuck due to CPU cores running out of RAM. To fix that modify the install script line: ```sudo nixos-rebuild switch --flake .#${HOST}``` to ```sudo nixos-rebuild switch --cores <less than your max number of cores> --flake .#${HOST}```

> [!TIP]
> As it is better to know what a script does before running it, you are advised to read it or at least see the [Install script walkthrough](#Install-script-walkthrough) section before execution.
   
Execute and follow the installation script :
```bash
./install.sh
```
  
#### 4. **Reboot**

After rebooting, the config should be applied, you'll be greeted by hyprlock prompting for your password.

#### 5. **Manual config**

```

## Install script walkthrough

A brief walkthrough of what the install script does.

#### 1. **Get username**

You will receive a prompt to enter your username, with a confirmation check.

#### 2. **Set username**

The script will replace all occurancies of the default usename ```CURRENT_USERNAME``` by the given one stored in ```$username```

#### 3. Create basic directories

The following directories will be created:
- ```~/Music```
- ```~/Documents```
- ```~/Pictures/wallpapers/others```

#### 4. Copy the wallpapers

Then the wallpapers will be copied into ```~/Pictures/wallpapers/others``` which is the folder in which the ```wallpaper-picker.sh``` script will be looking for them.

#### 5. Get the hardware configuration

It will also automatically copy the hardware configuration from ```/etc/nixos/hardware-configuration.nix``` to ```./hosts/${host}/hardware-configuration.nix``` so that the hardware configuration used is yours and not the default one.

#### 6. Choose a host (desktop / laptop)

Now you will need to choose the host you want. It depend on whether you are using a desktop or laptop (or a VM altho it can be realy buggy).

#### 7. Build the system

Lastly, it will build the system, which includes both the flake config and home-manager config.
```
# 👥 Credits

Other dotfiles that I learned / copy from:

- I really thanksful for frost-phoenix making this template and i credits to this man
 - [https://github.com/Frost-Phoenix/nixos-config/tree/catppuccin?tab=readme-ov-file]
- Nix Flakes
  - [nomadics9/NixOS-Flake](https://github.com/nomadics9/NixOS-Flake): This is where I start my nixos / hyprland journey.
  - [samiulbasirfahim/Flakes](https://github.com/samiulbasirfahim/Flakes): General flake / files structure
  - [justinlime/dotfiles](https://github.com/justinlime/dotfiles): Mainly waybar (old design)
  - [skiletro/nixfiles](https://github.com/skiletro/nixfiles): Vscodium config (that prevent it to crash)
  - [fufexan/dotfiles](https://github.com/fufexan/dotfiles)
  - [tluijken/.dotfiles](https://github.com/tluijken/.dotfiles): base rofi config
  - [mrh/dotfiles](https://codeberg.org/mrh/dotfiles): base waybar config
  - [JaKooLit/NixOS-Hyprland](https://github.com/JaKooLit/NixOS-Hyprland): my base config
  - [Matt-FTW/dotfiles](https://github.com/Matt-FTW/dotfiles.git): most of my dotfiles
  - [orangc/dots](https://github.com/orangci/dots.git): shout out to this man. He helps me in my begining of nixos jorney. If i didnt get help from this people i will leave this beautiful world.

  -[hmajid2301/nixicle](https://github.com/hmajid2301/nixicle.git): for some config idea
  - [nix-community/nix4nvchad](https://github.com/nix-community/nix4nvchad.git)
- README
  - [ryan4yin/nix-config](https://github.com/ryan4yin/nix-config)
  - [NotAShelf/nyx](https://github.com/NotAShelf/nyx)
  - [sioodmy/dotfiles](https://github.com/sioodmy/dotfiles)
  - [Ruixi-rebirth/flakes](https://github.com/Ruixi-rebirth/flakes)
  - [LinuxMobile](https://github.com/linuxmobile/kaku.git): for niri config and astal bar i love u man


<!-- # ✨ Stars History -->

<!-- <p align="center"><img src="https://api.star-history.com/svg?repos=frost-phoenix/nixos-config&type=Timeline&theme=dark" /></p> -->

<p align="center"><img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true" /></p>

<!-- end of page, send back to the top -->

<div align="right">
  <a href="#readme">Back to the Top</a>
</div>

<!-- Links -->
[Hyprland]: https://github.com/hyprwm/Hyprland
[HyprPanel]: https://github.com/Jas-SinghFSU/HyprPanel
[Wezterm]: https://wezfurlong.org/wezterm/index.html
[Starship]: https://github.com/starship/starship
[Waybar]: https://github.com/Alexays/Waybar
[walker]: https://github.com/abenz1267/walker
[Btop]: https://github.com/aristocratos/btop
[nemo]: https://github.com/linuxmint/nemo/
[yazi]: https://github.com/sxyazi/yazi
[zsh]: https://ohmyz.sh/
[oh-my-zsh]: https://ohmyz.sh/
[Swaylock-effects]: https://github.com/mortie/swaylock-effects
[Hyprlock]: https://github.com/hyprwm/hyprlock
[audacious]: https://audacious-media-player.org/
[mpv]: https://github.com/mpv-player/mpv
[VSCodium]:https://vscodium.com/
[Neovim]: https://github.com/neovim/neovim
[grimblast]: https://github.com/hyprwm/contrib
[qview]: https://interversehq.com/qview/
[swaync]: https://github.com/ErikReider/SwayNotificationCenter
[Nerd fonts]: https://github.com/ryanoasis/nerd-fonts
[NetworkManager]: https://wiki.gnome.org/Projects/NetworkManager
[network-manager-applet]: https://gitlab.gnome.org/GNOME/network-manager-applet/
[wl-clip-persist]: https://github.com/Linus789/wl-clip-persist
[wf-recorder]: https://github.com/ammen99/wf-recorder
[hyprpicker]: https://github.com/hyprwm/hyprpicker
[Catppuccin]: https://github.com/catppuccin 
[Papirus-Dark]: https://github.com/PapirusDevelopmentTeam/papirus-icon-theme
[Bibata-Modern-Ice]: https://www.gnome-look.org/p/1197198
[maxfetch]: https://github.com/jobcmax/maxfetch
