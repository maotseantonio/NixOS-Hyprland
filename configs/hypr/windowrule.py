
import re

def update_hyprland_config(config_path):
    with open(config_path, 'r') as file:
        lines = file.readlines()

    updated_lines = []
    for line in lines:
        # Convert 'windowrule' to 'windowrulev2' with updated syntax
        match = re.match(r'^\s*windowrule\s*=\s*([^,]+),\s*(.+)$', line)
        if match:
            rule = match.group(1).strip()
            window_class = match.group(2).strip()
            # Ensure the window class is enclosed with ^ and $
            if not window_class.startswith('^'):
                window_class = '^' + window_class
            if not window_class.endswith('$'):
                window_class = window_class + '$'
            updated_line = f'windowrule = {rule}, class:{window_class}\n'
            updated_lines.append(updated_line)
        else:
            # Rename 'windowrulev2' to 'windowrule'
            updated_line = line.replace('windowrulev2', 'windowrule')
            updated_lines.append(updated_line)

    # Write the updated lines back to the configuration file
    with open(config_path, 'w') as file:
        file.writelines(updated_lines)

# Replace 'path/to/hyprland.conf' with the actual path to your Hyprland configuration file
config_file_path = './UserConfigs/WindowRules.conf'
update_hyprland_config(config_file_path)
