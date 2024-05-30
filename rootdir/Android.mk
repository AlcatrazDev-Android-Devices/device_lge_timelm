LOCAL_PATH := $(call my-dir)

# Fstab

include $(CLEAR_VARS)
LOCAL_MODULE           := fstab.timelm
LOCAL_MODULE_TAGS      := optional
LOCAL_MODULE_CLASS     := ETC
LOCAL_SRC_FILES        := etc/fstab.timelm
LOCAL_MODULE_PATH      := $(TARGET_OUT_VENDOR_ETC)
include $(BUILD_PREBUILT)

# Init scripts

include $(CLEAR_VARS)
LOCAL_MODULE       := init.timelm.rc
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/init.timelm.rc
LOCAL_MODULE_PATH  := $(TARGET_OUT_VENDOR_ETC)/init/hw
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE       := init.recovery.timelm.rc
LOCAL_MODULE_TAGS  := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := etc/init.recovery.timelm.rc
LOCAL_MODULE_PATH  := $(TARGET_RECOVERY_ROOT_OUT)
include $(BUILD_PREBUILT)