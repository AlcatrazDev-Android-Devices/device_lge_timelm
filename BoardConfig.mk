#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/lge/timelm

# inherit from common tree
-include device/lge/sm8250-common/BoardConfigCommon.mk

# Platform
TARGET_SPECIFIC_HEADER_PATH := $(DEVICE_PATH)/include

# Display
TARGET_SCREEN_DENSITY := 420

# HIDL
ODM_MANIFEST_FILES += $(DEVICE_PATH)/manifest_odm.xml

# Kernel
TARGET_KERNEL_CONFIG := vendor/timelm-perf_defconfig

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 90

# inherit from the proprietary version
-include vendor/lge/timelm/BoardConfigVendor.mk
