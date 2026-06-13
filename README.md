# LuminaBuildEnvironment
Docker Image for Multiplatform development of Lumina Engine

## How to use
```bash
docker run -ti -v $PWD:/source lumina-be
```

### Sony PSP

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
