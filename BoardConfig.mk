#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/lge/mh2lm

# inherit from common tree
-include device/lge/sm8150-common/BoardConfigCommon.mk

# Platform
TARGET_SPECIFIC_HEADER_PATH := $(DEVICE_PATH)/include

# Display
TARGET_SCREEN_DENSITY := 401

# Kernel
TARGET_KERNEL_CONFIG := vendor/mh2lm-perf_defconfig

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 90

# SELinux
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor

# inherit from the proprietary version
-include vendor/lge/mh2lm/BoardConfigVendor.mk
