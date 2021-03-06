# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="scummvm-libretro"
PKG_VERSION="9b12208"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/scummvm"
PKG_URL="https://github.com/libretro/scummvm/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="scummvm-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain flac libmad munt"
PKG_SECTION="escalade"
PKG_SHORTDESC="ScummVM with libretro backend."
PKG_TOOLCHAIN="manual"

if [ "$ARCH" = "arm" ]; then
  PKG_BUILD_FLAGS="+lto-parallel"
else
  PKG_BUILD_FLAGS="-lto"
fi

pre_configure_target() {
  cd $PKG_BUILD
}

configure_target() {
  :
}

make_target() {
  export CXXFLAGS="$CXXFLAGS -DHAVE_POSIX_MEMALIGN=1"
  make -C backends/platform/libretro/build GIT_VERSION=$PKG_VERSION CC=$CC CXX=$CXX LD=$CXX AR="$AR cru" RANLIB="$RANLIB"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/retroarch/cores
  cp backends/platform/libretro/build/*.so $INSTALL/usr/share/retroarch/cores/
}
