LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
    bootanimation_main.cpp \
    AudioPlayer.cpp \
    BootAnimation.cpp

LOCAL_CFLAGS += -DGL_GLEXT_PROTOTYPES -DEGL_EGLEXT_PROTOTYPES

LOCAL_CFLAGS += -Wall -Werror -Wunused -Wunreachable-code
ifeq ($(MTK_TER_SERVICE),yes)
	LOCAL_CFLAGS += -DMTK_TER_SERVICE
	LOCAL_CPPFLAGS += -DMTK_TER_SERVICE
    ifdef MTK_CARRIEREXPRESS_PACK
        ifneq ($(strip $(MTK_CARRIEREXPRESS_PACK)), no)
            LOCAL_CFLAGS += -DMTK_CARRIEREXPRESS_PACK
            LOCAL_CPPFLAGS += -DMTK_CARRIEREXPRESS_PACK
        endif
    endif
endif
LOCAL_C_INCLUDES += external/tinyalsa/include

LOCAL_SHARED_LIBRARIES := \
    libcutils \
    liblog \
    libandroidfw \
    libutils \
    libbinder \
    libui \
    libskia \
    libEGL \
    libETC1 \
    libGLESv2 \
    libmedia \
    libGLESv1_CM \
    libgui \
    libtinyalsa

#add for regional phone
ifeq ($(MTK_TER_SERVICE),yes)
LOCAL_SHARED_LIBRARIES += libterservice
LOCAL_C_INCLUDES += $(MTK_PATH_SOURCE)/hardware/terservice/include/
endif
LOCAL_C_INCLUDES += $(TOP)/$(MTK_ROOT)/frameworks-ext/native/include
LOCAL_C_INCLUDES += external/skia/include
LOCAL_MODULE:= bootanimation

LOCAL_INIT_RC := bootanim.rc

ifdef TARGET_32_BIT_SURFACEFLINGER
LOCAL_32_BIT_ONLY := true
endif

include $(BUILD_EXECUTABLE)
