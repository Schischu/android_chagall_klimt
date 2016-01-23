#!/bin/bash

DEBUG="debug"
#DEBUG=""

GCC_PATH=`pwd`/prebuilts/gcc/linux-x86/arm/arm-eabi-4.8/bin
export PATH=$GCC_PATH:$PATH

export USE_CCACHE=1
export CCACHE_DIR=`pwd`/.ccache
prebuilts/misc/linux-x86/ccache/ccache -M 120G

if [ "x$1" == "x" ]; then
  products="chagalllte chagallwifi klimtlte klimtwifi"
else
  products=$1
fi

if [ "x$2" == "xnoclean" ]; then
  noclean=1
else
  noclean=0
fi

# Fix build dependency
mkdir -p prebuilts/qemu-kernel/arm
touch prebuilts/qemu-kernel/arm/LINUX_KERNEL_COPYING

source build/envsetup.sh

if [ "x$noclean" == "x0" ]; then
  make clean
fi

for product in $products
do
  echo "lunch aosp_${product}-user$DEBUG"
  lunch aosp_${product}-user$DEBUG
  make -j 16 otapackage 2>&1 | tee build.log
  
  ROM_ORG="aosp_${product}-ota-eng.ubuntu.zip"
  ROM="aosp-`grep "ro.build.version.incremental" out/target/product/${product}/system/build.prop | sed "s/ro.build.version.incremental=//g"`.zip"
  
  mv out/target/product/${product}/${ROM_ORG} out/target/product/${product}/${ROM}
  md5sum out/target/product/${product}/${ROM} > out/target/product/${product}/${ROM}.md5sum
done
