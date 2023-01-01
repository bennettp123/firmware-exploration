#!/bin/bash


cd "$(dirname "${1}")"
if binwalk --signature --term --extract "$1"; then
  echo "files have been extracted to $(dirname "$1")/_$(basename "$1")* | head -n1)"
fi

for file in "$(ls -dt $(dirname "$1")/_$(basename "$1")* | head -n1)"/*; do
  extract-ikconfig "${file}" && break
done > "$(ls -dt $(dirname "$1")/_$(basename "$1")* | head -n1)/kernel-config"

echo "kernel config has been written to $(ls -dt $(dirname "$1")/_$(basename "$1")* | head -n1)/kernel-config"

exit


# old implementation below


tmpfile=$(mktemp)

# 1. get the file (prevent too much seeking)
dd if="$(dirname "${0}")"/13ad-UDW-3.0.14-02e69b5d468443a1aaeab3c27c0a7179.bin of="${tmpfile}" count=$((65536 / 32)) bs=32 skip=$((0x001724a0 / 32))

# 2. get each block offset
for num in $(seq 0 1024); do
  real_offset=$((0x001724a0 + $num))
  echo "offset=$( printf '0x%08x' $(( $real_offset )) ): $( dd if="${tmpfile}" bs=1 skip=$(($num)) 2>/dev/null | file - )"
done

rm "${tmpfile}"
