# firmware-exploration

## usage

1. Build the image

```bash
docker build -t ubidev -f Dockerfile.debian .
```

2. Launch the image

```bash
docker run --rm -it -v `pwd`:/pwd -w /pwd --privileged ubidev bash
```

3. Mount the root fs

```bash
./mount.sh <firmware-file>
```

This is fragile: only works for a specific version of a specific firmware :P

4. Extract firmware files, extract kernel config

```bash
./scan-kernel.sh <firmware-file>
```

