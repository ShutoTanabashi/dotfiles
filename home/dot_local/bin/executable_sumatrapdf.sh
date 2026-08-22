#!/usr/bin/env zsh
set -eu

new_args=()
integer mounted_path_count=0

for arg in "$@"; do
  if [[ "$arg" == /mnt/* ]]; then
    (( mounted_path_count += 1 ))
    new_args+=("$(wslpath -m "$arg")")

    if (( mounted_path_count == 1 )); then
      find "$PWD" -maxdepth 1 -name "*.synctex.gz" -execdir \
        bash -c 'gunzip -c "$1" | sed --expression="s@/mnt/\(.\)/@\1:/@g" | gzip > "$1.tmp" && mv "$1.tmp" "$1"' _ "{}" \;
    fi
  else
    new_args+=("$arg")
  fi
done

exec sumatrapdf.exe "${new_args[@]}"
