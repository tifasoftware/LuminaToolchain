FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    pkgconf \
    libreadline8 \
    libusb-0.1 \
    libgpgme11 \
    libarchive-tools \
    fakeroot \
    git \
    libgmp-dev \
    libmpfr-dev \
    libmpc-dev \
    gettext \
    libelf-dev \
    texinfo \
    bison \
    flex \
    libjpeg-dev \
    libpng-dev \
    pkg-config \
    libisofs-dev \
    meson \
    ninja-build \
    rake \
    autopoint \
    libgmp3-dev \
    libgsl-dev

ENV PSPDEV="/usr/local/pspdev"

ENV PS2DEV="/usr/local/ps2dev"
ENV PS2SDK="/usr/local/ps2dev/ps2sdk"
ENV GSKIT="/usr/local/ps2dev/gsKit"

ENV PSPBUILD="/opt/pspbuild"
ENV PS2BUILD="/opt/ps2build"

ENV DCTC="/opt/toolchains/dc"

ENV PATH="$PATH:$PSPDEV/bin:$PS2DEV/bin:$PS2DEV/ee/bin:$PS2DEV/iop/bin:$PS2DEV/dvp/bin:$PS2SDK/bin"

RUN ln -sf /proc/mounts /etc/mtab

RUN mkdir -p $PSPDEV && mkdir -p $PSPBUILD && git clone https://github.com/pspdev/pspdev.git $PSPBUILD && $PSPBUILD/prepare.sh && $PSPBUILD/build-all.sh && $PSPBUILD/build-extra.sh

RUN mkdir -p $PS2DEV && chown -R $USER: $PS2DEV && git clone https://github.com/ps2dev/ps2dev.git $PS2BUILD && $PS2BUILD/build-all.sh && $PS2BUILD/build-extra.sh

RUN wget -U "dkp-apt" https://apt.devkitpro.org/install-devkitpro-pacman && chmod +x ./install-devkitpro-pacman
RUN yes | ./install-devkitpro-pacman

RUN echo "\n\ny" | dkp-pacman -Syyu 3ds-dev 3ds-sdl-libs
RUN echo "\n\ny" | dkp-pacman -Syyu gamecube-dev gamecube-sdl2-libs

RUN mkdir -p $DCTC && chmod -R 755 $DCTC && chown -R $(id -u):$(id -g) $DCTC && git clone https://github.com/KallistiOS/KallistiOS.git -b v2.2.x $DCTC/kos && cd $DCTC/kos/utils/dc-chain && cp Makefile.default.cfg Makefile.cfg && make && make clean distclean 

RUN cd $DCTC/kos && cp $DCTC/kos/doc/environ.sh.sample $DCTC/kos/environ.sh && . $DCTC/kos/environ.sh && make
RUN git clone --recursive https://github.com/tifasoftware/kos-ports $DCTC/kos-ports && $DCTC/kos-ports/utils/build-all.sh
RUN git clone https://gitlab.com/simulant/mkdcdisc.git $DCTC/mkdcdisc && cd $DCTC/mkdcdisc && meson setup builddir && meson compile -C builddir
