XDG_CONFIG_DIRS="${XDG_CONFIG_DIRS:-/etc/xdg}"
config_home="${XDG_CONFIG_HOME:-${HOME}/.config}"
config_file=""

IFS=':' read -ra _sys_dirs <<< "$XDG_CONFIG_DIRS"
for dir in "$config_home" "${_sys_dirs[@]}"; do
  if [[ -f "$dir/msnap/msnap.conf" ]]; then
    config_file="$dir/msnap/msnap.conf"
    break
  fi
done

if [[ -z "$config_file" ]]; then
  mkdir -p "$config_home/msnap"
  cp "./msnap.conf" "$config_home/msnap/msnap.conf"
  config_file="$config_home/msnap/msnap.conf"
fi

CONFIG_FILE="$config_file"
ini_load "$config_file"
