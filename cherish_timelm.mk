#
# Copyright (C) 2023 The cherishOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from device
$(call inherit-product, device/lge/timelm/device.mk)

# Inherit some common cherish stuff.
$(call inherit-product, vendor/cherish/config/common_full_phone.mk)

# Device identifier. This must come after all inclusions.
PRODUCT_NAME := cherish_timelm
PRODUCT_DEVICE := timelm
PRODUCT_MANUFACTURER := LGE
PRODUCT_BRAND := LGE
PRODUCT_MODEL := V60 ThinQ
TARGET_VENDOR_PRODUCT_NAME := timelm
TARGET_VENDOR_DEVICE_NAME := timelm

PRODUCT_GMS_CLIENTID_BASE := android-lge

PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_DEVICE=timelm \
    PRIVATE_BUILD_DESC="timelm-user 13 TKQ1.220829.002 2318902104908 release-keys"

BUILD_FINGERPRINT := lge/timelm/timelm:13/TKQ1.220829.002/2318902104908:user/release-keys
