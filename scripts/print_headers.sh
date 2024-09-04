#!/usr/bin/env bash
find . -type f -name "*.nix" | while read -r file;
do
   printf "[\033[1;33m$file\033[0m]:   "
   head -n 1 "$file"
done

