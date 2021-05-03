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

LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := ResponsiveGrassDemo

LOCAL_SRC_FILES:= \
	$(abspath $(LOCAL_PATH)/../src)/AutoMover.cpp \
	$(abspath $(LOCAL_PATH)/../src)/AutoRotator.cpp \
	$(abspath $(LOCAL_PATH)/../src)/BoundingBox.cpp \
	$(abspath $(LOCAL_PATH)/../src)/BoundingSphere.cpp \
	$(abspath $(LOCAL_PATH)/../src)/Camera.cpp \
	$(abspath $(LOCAL_PATH)/../src)/Clock.cpp \
	$(abspath $(LOCAL_PATH)/../src)/Common.cpp \
	$(abspath $(LOCAL_PATH)/../src)/DemoScene.cpp \
	$(abspath $(LOCAL_PATH)/../src)/FontRenderer.cpp \
	$(abspath $(LOCAL_PATH)/../src)/FPSCounter.cpp \
	$(abspath $(LOCAL_PATH)/../src)/GLClock.cpp \
	$(abspath $(LOCAL_PATH)/../src)/Grass.cpp \
	$(abspath $(LOCAL_PATH)/../src)/GrassObject.cpp \
	$(abspath $(LOCAL_PATH)/../src)/HeightMap.cpp \
	$(abspath $(LOCAL_PATH)/../src)/ImageProcess.cpp \
	$(abspath $(LOCAL_PATH)/../src)/main.cpp \
	$(abspath $(LOCAL_PATH)/../src)/OpenGLState.cpp \
	$(abspath $(LOCAL_PATH)/../src)/PhysXController.cpp \
	$(abspath $(LOCAL_PATH)/../src)/Plane.cpp \
	$(abspath $(LOCAL_PATH)/../src)/SceneObject.cpp \
	$(abspath $(LOCAL_PATH)/../src)/Shader.cpp \
	$(abspath $(LOCAL_PATH)/../src)/Skybox.cpp \
	$(abspath $(LOCAL_PATH)/../src)/SpherePackedObject.cpp \
	$(abspath $(LOCAL_PATH)/../src)/SpherePacker.cpp \
	$(abspath $(LOCAL_PATH)/../src)/Texture2D.cpp \
	$(abspath $(LOCAL_PATH)/../src)/WindGenerator.cpp

#LOCAL_CFLAGS += -fdiagnostics-format=msvc
LOCAL_CFLAGS += -finput-charset=UTF-8 -fexec-charset=UTF-8
LOCAL_CFLAGS += -fvisibility=hidden

LOCAL_CPPFLAGS += -std=c++11

LOCAL_LDFLAGS += -finput-charset=UTF-8 -fexec-charset=UTF-8
LOCAL_LDFLAGS += -Wl,--enable-new-dtags # the linker can't recognize the old dtags
LOCAL_LDFLAGS += -Wl,-rpath,XORIGIN # chrpath can only make path shorter
LOCAL_LDFLAGS += -Wl,--version-script,$(abspath $(LOCAL_PATH))/ResponsiveGrassDemo.def

LOCAL_C_INCLUDES += /usr/include/freetype2

LOCAL_LDFLAGS += -lpng
LOCAL_LDFLAGS += -lfreetype
LOCAL_LDFLAGS += -lassimp
LOCAL_LDFLAGS += -lglfw

LOCAL_CPP_FEATURES := exceptions
LOCAL_C_INCLUDES += $(abspath $(LOCAL_PATH)/../external)/include/PhysX_3.4/
LOCAL_C_INCLUDES += $(abspath $(LOCAL_PATH)/../external)/include/PxShared/
LOCAL_C_INCLUDES += $(abspath $(LOCAL_PATH)/../external)/include/
LOCAL_LDFLAGS += -L$(abspath $(LOCAL_PATH)/../external)/libs/
LOCAL_LDFLAGS += -lPhysX3Extensions 
LOCAL_LDFLAGS += -lPhysX3Cooking_x64
LOCAL_LDFLAGS += -lPhysX3_x64 
LOCAL_LDFLAGS += -lPhysX3Common_x64 
LOCAL_LDFLAGS += -lPxPvdSDK_x64 
LOCAL_LDFLAGS += -lPxFoundation_x64
LOCAL_LDFLAGS += -lGLEW

LOCAL_LDFLAGS += -lGL

include $(BUILD_EXECUTABLE)
