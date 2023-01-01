#!/bin/bash

mkdir -p /loop/rootfs

unset rootfs

for num in $(seq 192 255 | while read n; do printf '%02x\n' "$n"; done); do
  if mount \
	  -o "loop,offset=0x00f015${num}" \
	  "$1" \
          /loop/rootfs
  then
    echo "successfully mounted root filesystem at offset=0x00f015$num"
    rootfs=mounted
    break
  fi
done

if [ "$rootfs" = "mounted" ]; then
  echo "rootfs is mounted at /loop/rootfs"
fi

