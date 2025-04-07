list=$(flavours list | tr " " "\n")

while themes= read -r theme; do
  name=$(b=${theme##*/}; echo ${b%.*});
  name=${name//-/ };
  disp=( $name );
  name=${disp[@]^};
  printf "label=${name};exec=flavours apply $theme && notify-send -u low -a hyprland -t 750 \"Flavours\" \"Theme changed to:  ${name}\"\n"
done <<< "$list"
