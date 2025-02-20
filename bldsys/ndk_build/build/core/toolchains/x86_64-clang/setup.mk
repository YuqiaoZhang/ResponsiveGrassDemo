# Copyright (C) 2014 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# this file is used to prepare the NDK to build with the x86_64 llvm toolchain
# any number of source files
#
# its purpose is to define (or re-define) templates used to build
# various sources into target object files, libraries or executables.
#
# Note that this file may end up being parsed several times in future
# revisions of the NDK.
#

#
# Override the toolchain prefix
#

LLVM_TOOLCHAIN_PREBUILT_ROOT := /usr/
LLVM_TOOLCHAIN_PREFIX := $(LLVM_TOOLCHAIN_PREBUILT_ROOT)/bin/

TOOLCHAIN_NAME := x86_64-linux-android
BINUTILS_ROOT := $(call get-binutils-root,$(NDK_ROOT),$(TOOLCHAIN_NAME))
TOOLCHAIN_ROOT := $(call get-toolchain-root,x86_64-4.9)
TOOLCHAIN_PREFIX := $(TOOLCHAIN_ROOT)/bin/

TARGET_CC := $(LLVM_TOOLCHAIN_PREFIX)/clang$(HOST_EXEEXT)
TARGET_CXX := $(LLVM_TOOLCHAIN_PREFIX)/clang++$(HOST_EXEEXT)

TARGET_CFLAGS := \
    -ffunction-sections \
    -funwind-tables \
    -fstack-protector-strong \
    -fPIE \
    -fPIC \
    -Wno-invalid-command-line-argument \
    -Wno-unused-command-line-argument \
    -no-canonical-prefixes \
    -pthread \

# Always enable debug info. We strip binaries when needed.
TARGET_CFLAGS += -g

TARGET_LDFLAGS += \
    -no-canonical-prefixes \
    -pthread \
    -fuse-ld=gold \

TARGET_x86_64_release_CFLAGS := \
    -O2 \
    -DNDEBUG \

TARGET_x86_64_debug_CFLAGS := \
    -O0 \
    -UNDEBUG \
    -fno-limit-debug-info \

# This function will be called to determine the target CFLAGS used to build
# a C or Assembler source file, based on its tags.
#
TARGET-process-src-files-tags = \
$(eval __debug_sources := $(call get-src-files-with-tag,debug)) \
$(eval __release_sources := $(call get-src-files-without-tag,debug)) \
$(call set-src-files-target-cflags, $(__debug_sources), $(TARGET_x86_64_debug_CFLAGS)) \
$(call set-src-files-target-cflags, $(__release_sources),$(TARGET_x86_64_release_CFLAGS)) \

# The ABI-specific sub-directory that the SDK tools recognize for
# this toolchain's generated binaries
TARGET_ABI_SUBDIR := x86_64
