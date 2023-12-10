#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from device
$(call inherit-product, device/lge/mh2lm/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Device identifier. This must come after all inclusions.
PRODUCT_NAME := lineage_mh2lm
PRODUCT_DEVICE := mh2lm
PRODUCT_MANUFACTURER := LGE
PRODUCT_BRAND := LGE
PRODUCT_MODEL := G8X ThinQ
TARGET_VENDOR_PRODUCT_NAME := mh2lm
TARGET_VENDOR_DEVICE_NAME := mh2lm

PRODUCT_GMS_CLIENTID_BASE := android-lge

PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_DEVICE=mh2lm \
    PRIVATE_BUILD_DESC="mh2lm-user 12 SKQ1.211103.001 8150120221001 release-keys"

BUILD_FINGERPRINT := lge/mh2lm/mh2lm:12/SKQ1.211103.001/8150120221001:user/release-keys
