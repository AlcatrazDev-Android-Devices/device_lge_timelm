/*
 * Copyright (C) 2023 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#pragma once

/*
 * Board specific nodes
 *
 * If your kernel exposes these controls in another place, you can either
 * symlink to the locations given here, or override this header in your
 * device tree.
 */

#define BL              "/sys/class/backlight/panel0-backlight/"
#define BL_EX           "/sys/class/backlight/panel0-backlight-ex/"

#define BRIGHTNESS      "brightness"
#define MAX_BRIGHTNESS  "max_brightness"
