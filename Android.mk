#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifneq ($(filter timelm,$(TARGET_DEVICE)),)
include $(call all-makefiles-under,$(LOCAL_PATH))

include $(CLEAR_VARS)

CAMERA_CPP_SHARED_SYMLINK := $(TARGET_OUT_VENDOR)
$(CAMERA_CPP_SHARED_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating camera c++ shared libs symlinks: $@"
	@mkdir -p $@
	$(hide) ln -sf /vendor/lib/libc++_shared_snpe.so $@/lib/libc++_shared.so
	$(hide) ln -sf /vendor/lib64/libc++_shared_snpe.so $@/lib64/libc++_shared.so

ALL_DEFAULT_INSTALLED_MODULES += $(CAMERA_CPP_SHARED_SYMLINK)

endif
