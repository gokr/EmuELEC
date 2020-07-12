# SPDX-License-Identifier: Zlib
# Copyright (c) 2008-2020 Orx-Project

PKG_NAME="orx"
PKG_VERSION="1.11"
#PKG_SHA256="1354e0fc8bfb1f90a82a3c77ffaefbfde56f85077566483d4aaaf01343b1c107"
PKG_SHA256="1bce62a473d5348dc47a6809b92f26977163e75801f37abe983fb4e8efa50ecd"
PKG_ARCH="any"
PKG_LICENSE="Zlib"
PKG_SITE="https://github.com/orx/$PKG_NAME"
#PKG_URL="https://github.com/orx/$PKG_NAME/releases/download/$PKG_VERSION/$PKG_NAME-src-$PKG_VERSION.zip"
PKG_VERSION="856a017f82d039d4f14bf7ef195bcc34031ce8db"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_TOOLCHAIN="manual"
PKG_DEPENDS_TARGET="toolchain libX11 glfw openal-soft libXrandr"
PKG_LONGDESC="Orx is a 2D-oriented, data-driven, portable game engine focused primarily on ease of use and powerful features."

if [ "$OPENGL" != "no" ]; then
  PKG_DEPENDS_TARGET+=" $OPENGL"
fi

if [ "$OPENGLES" != "no" ]; then
  PKG_DEPENDS_TARGET+=" $OPENGLES"
fi

make_target() {
  cd $PKG_BUILD
  chmod +x code/build/rebol/r3-linux64
  bash ./setup.sh
  cd $PKG_BUILD/code/build/linux/gmake
  sed -i "s|\-msse2||g" orxLIB.make
  sed -i "s|\-m64||g" orxLIB.make
  make config=release64 CC=$CC CXX=$CXX PREFIX=$SYSROOT_PREFIX/usr
}

post_make_target() {
  mkdir -p $INSTALL/usr/lib
  cp -a $PKG_BUILD/code/lib/dynamic/*.so $INSTALL/usr/lib/
}
