#
# Copyright (C) 2023 The cherishOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_MAKEFILES += \
    $(LOCAL_DIR)/cherish_timelm.mk

COMMON_LUNCH_CHOICES := \
    cherish_timelm-eng \
    cherish_timelm-user \
    cherish_timelm-userdebug
