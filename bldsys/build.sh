#!/bin/bash

#
# Copyright (C) YuqiaoZhang(HanetakaYuminaga)
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
# 
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

# configure
if test \( $# -ne 1 \);
then
    echo "Usage: build.sh config platform arch"
    echo ""
    echo "Configs:"
    echo "  debug   -   build with the debug configuration"
    echo "  release -   build with the release configuration"
    exit 1
fi

if test \( \( -n "$1" \) -a \( "$1" = "debug" \) \);then 
    NDK_BUILD_ARG_CONFIG="APP_DEBUG:=true"
    INT_DIR_CONFIG="obj/local"
    OUT_DIR_CONFIG="debug"
elif test \( \( -n "$1" \) -a \( "$1" = "release" \) \);then
    NDK_BUILD_ARG_CONFIG="APP_DEBUG:=false"
    INT_DIR_CONFIG="libs"
    OUT_DIR_CONFIG="release"
else
    echo "The config \"$1\" is not supported!"
    echo ""
    echo "Configs:"
    echo "  debug   -   build with the debug configuration"
    echo "  release -   build with the release configuration"
    echo ""
    exit 1
fi

NDK_BUILD_ARG_PLATFORM="APP_BUILD_SCRIPT:=build.mk"
NDK_BUILD_CMD_DIR_PLATFORM="ndk_build"

NDK_BUILD_ARG_ARCH="APP_ABI:=x86_64"
INT_DIR_ARCH="x86_64"
OUT_DIR_ARCH="x64"

MY_DIR="$(cd "$(dirname "$0")" 1>/dev/null 2>/dev/null && pwd)"  

NDK_BUILD_CMD_DIR="${MY_DIR}/${NDK_BUILD_CMD_DIR_PLATFORM}/"
NDK_BUILD_ARGS="${NDK_BUILD_ARG_CONFIG} ${NDK_BUILD_ARG_ARCH} NDK_PROJECT_PATH:=null NDK_OUT:=obj NDK_LIBS_OUT:=libs NDK_APPLICATION_MK:=Application.mk ${NDK_BUILD_ARG_PLATFORM}"

INT_DIR="${MY_DIR}/${INT_DIR_CONFIG}/${INT_DIR_ARCH}/"
OUT_DIR="${MY_DIR}/../bin/"

OUT_BINS=("ResponsiveGrassDemo")

# build by ndk  
cd ${MY_DIR}

# rm -rf obj
# rm -rf libs

if ${NDK_BUILD_CMD_DIR}/ndk-build ${NDK_BUILD_ARGS}; then #V=1 VERBOSE=1 
    echo "ndk-build passed"
else
    echo "ndk-build failed"
    exit 1
fi

# before execute change the rpath to \$ORIGIN    
# fix me: define the $ORIGIN correctly in the Linux_X11.mk
for i in "${OUT_BINS[@]}"
do
    chrpath -r '$ORIGIN' ${INT_DIR}/${i} 
done

# mkdir the out dir if necessary
mkdir -p ${OUT_DIR}

# copy the unstriped so to out dir
for i in "${OUT_BINS[@]}"
do
    rm -rf ${OUT_DIR}/${i}
    cp -f ${INT_DIR}/${i} ${OUT_DIR}/
done

#
OUT_LIBS=("libPhysX3Cooking_x64.so" "libPhysX3_x64.so" "libPhysX3Common_x64.so" "libPxPvdSDK_x64.so" "libPxFoundation_x64.so")
for i in "${OUT_LIBS[@]}"
do
    rm -rf ${OUT_DIR}/${i}
    cp -f "${MY_DIR}/../external/libs/${i}" ${OUT_DIR}/
done

