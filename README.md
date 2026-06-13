# LuminaBuildEnvironment
Docker Image for Multiplatform development of Lumina Engine

## How to use
```bash
docker run -ti -v $PWD:/source lumina-be
```

### Sony PSP
```bash
psp-cmake ..
make -j16
```

### Sony PS2
```bash
Coming Soon
```

### Nintendo 3DS
```bash
source ../init_devkitpro.sh
cmake -DCMAKE_TOOLCHAIN_FILE=$DEVKITPRO/cmake/3DS.cmake -D3DS=ON ..
make -j16
```

### Nintendo GameCube
```bash
source ../init_devkitpro.sh
cmake -DCMAKE_TOOLCHAIN_FILE=$DEVKITPRO/cmake/GameCube.cmake -DWEISS=ON ..
make -j16
```

### Sega Dreamcast
```bash
Coming Soon
```

### OG Xbox
```bash
Coming Soon
```
