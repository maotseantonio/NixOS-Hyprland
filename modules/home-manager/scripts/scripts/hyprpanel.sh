#!/nix/store/p6k7xp1lsfmbdd731mlglrdj2d66mr82-bash-5.2p37/bin/bash
if [ "$#" -eq 0 ]; then
    exec /nix/store/cprklyvbi1gs902vf5sh850lxzfxy31s-hyprpanel/bin/hyprpanel
else
    exec /nix/store/1q2hyjji29s2wvv4rwlbi8f9p2blxz3i-astal-0.1.0/bin/astal -i hyprpanel "$@"
fi


