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
    git

ENV PSPDEV="/usr/local/pspdev"
ENV BUILDDIR="/opt/pspbuild"
ENV PATH="$PATH:$PSPDEV/bin"

RUN ln -sf /proc/mounts /etc/mtab

RUN mkdir -p $PSPDEV && mkdir -p $BUILDDIR && git clone https://github.com/pspdev/pspdev.git $BUILDDIR && $BUILDDIR/prepare.sh && $BUILDDIR/build-all.sh && $BUILDDIR/build-extra.sh

RUN wget -U "dkp-apt" https://apt.devkitpro.org/install-devkitpro-pacman && chmod +x ./install-devkitpro-pacman
RUN yes | ./install-devkitpro-pacman
RUN echo "\nyy" | dkp-pacman -Syyu 3ds-dev 3ds-sdl-libs
RUN echo "\nyy" | dkp-pacman -Syyu gamecube-dev gamecube-sdl2-libs
