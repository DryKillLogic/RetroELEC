# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="makemkv"
PKG_VERSION="1.14.5"
PKG_SHA256="d177f5962054d3b866d871aa06f1611dcced7ef2f0dcd41a771a50467505e1c9"
PKG_ARCH="x86_64"
PKG_LICENSE="OSS"
PKG_SITE="http://www.makemkv.com/forum2/viewforum.php?f=3"
PKG_URL="http://www.makemkv.com/download/makemkv-oss-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl expat ffmpeg zlib"
PKG_SECTION="escalade"
PKG_LONGDESC="MakeMKV can instantly stream decrypted video without intermediate conversion to wide range of players, so you may watch Blu-ray and DVD discs with your favorite player on your favorite OS or on your favorite device."

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="MakeMKV"
PKG_ADDON_TYPE="xbmc.python.script"

PKG_CONFIGURE_OPTS_TARGET="--disable-gui"

post_unpack() {
  curl -s http://www.makemkv.com/download/makemkv-bin-$PKG_VERSION.tar.gz | tar -C $PKG_BUILD -zxf -
}

pre_configure_target() {
  cd ..
  rm -rf .$TARGET_NAME
}

makeinstall_target() {
  :
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  install -m 0755 $PKG_BUILD/makemkv-bin-$PKG_VERSION/bin/amd64/makemkvcon $ADDON_BUILD/$PKG_ADDON_ID/bin/makemkvcon.bin

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/lib
  cp $PKG_BUILD/out/libmakemkv.so.? $ADDON_BUILD/$PKG_ADDON_ID/lib
  cp $PKG_BUILD/out/libdriveio.so.? $ADDON_BUILD/$PKG_ADDON_ID/lib
  cp $PKG_BUILD/out/libmmbd.so.? $ADDON_BUILD/$PKG_ADDON_ID/lib
  cp -PL $(get_build_dir openssl)/.install_pkg/usr/lib/libcrypto.so.?.? $ADDON_BUILD/$PKG_ADDON_ID/lib

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/license
  cp $PKG_BUILD/makemkv-bin-$PKG_VERSION/src/eula_en_linux.txt $ADDON_BUILD/$PKG_ADDON_ID/license
}
