/*
 * Copyright (C) 2017 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#define LOG_TAG "fingerprint@2.3-service.mh2lm"

#include "BiometricsFingerprint.h"

#include <android-base/file.h>
#include <android-base/logging.h>
#include <fcntl.h>
#include <poll.h>
#include <sys/stat.h>

#include <chrono>
#include <cmath>
#include <fstream>
#include <thread>

#define NOTIFY_SCAN_START FingerCmdLge::SCAN_START
#define NOTIFY_SCAN_STOP FingerCmdLge::SCAN_STOP

#define FOD_HBM_PATH "/sys/devices/virtual/panel/brightness/fp_lhbm"

namespace android {
namespace hardware {
namespace biometrics {
namespace fingerprint {
namespace V2_3 {
namespace implementation {

void setFodHbm(bool status) {
    android::base::WriteStringToFile(status ? "1" : "0", FOD_HBM_PATH);
}

void BiometricsFingerprint::disableHighBrightFod() {
    std::lock_guard<std::mutex> lock(mSetHbmFodMutex);

    if (!hbmFodEnabled)
        return;

    mLgeFingerprint->extraCmd(NOTIFY_SCAN_STOP, {},
                                   [](const hidl_vec<signed char> &) {});

    setFodHbm(false);

    hbmFodEnabled = false;
}

void BiometricsFingerprint::enableHighBrightFod() {
    std::lock_guard<std::mutex> lock(mSetHbmFodMutex);

    if (hbmFodEnabled)
        return;

    mLgeFingerprint->extraCmd(NOTIFY_SCAN_START, {},
                                   [](const hidl_vec<signed char> &) {});

    setFodHbm(true);

    hbmFodEnabled = true;
}

BiometricsFingerprint::BiometricsFingerprint() {
    biometrics_2_1_service = IBiometricsFingerprint_2_1::getService();
    mLgeFingerprint = ILgeBiometricsFingerprint::getService();

    hbmFodEnabled = false;
}

Return<uint64_t> BiometricsFingerprint::setNotify(
    const sp<IBiometricsFingerprintClientCallback> &clientCallback) {
    return biometrics_2_1_service->setNotify(clientCallback);
}

Return<uint64_t> BiometricsFingerprint::preEnroll() {
    return biometrics_2_1_service->preEnroll();
}

Return<RequestStatus> BiometricsFingerprint::enroll(const hidl_array<uint8_t, 69> &hat,
                                                    uint32_t gid, uint32_t timeoutSec) {
    return biometrics_2_1_service->enroll(hat, gid, timeoutSec);
}

Return<RequestStatus> BiometricsFingerprint::postEnroll() {
    return biometrics_2_1_service->postEnroll();
}

Return<uint64_t> BiometricsFingerprint::getAuthenticatorId() {
    return biometrics_2_1_service->getAuthenticatorId();
}

Return<RequestStatus> BiometricsFingerprint::cancel() {
    auto ret = biometrics_2_1_service->cancel();
    BiometricsFingerprint::onFingerUp();
    return ret;
}

Return<RequestStatus> BiometricsFingerprint::enumerate() {
    return biometrics_2_1_service->enumerate();
}

Return<RequestStatus> BiometricsFingerprint::remove(uint32_t gid, uint32_t fid) {
    return biometrics_2_1_service->remove(gid, fid);
}

Return<RequestStatus> BiometricsFingerprint::setActiveGroup(uint32_t gid,
                                                            const hidl_string &storePath) {
    return biometrics_2_1_service->setActiveGroup(gid, storePath);
}

Return<RequestStatus> BiometricsFingerprint::authenticate(uint64_t operationId, uint32_t gid) {
    auto ret = biometrics_2_1_service->authenticate(operationId, gid);
    BiometricsFingerprint::onFingerUp();
    return ret;
}

Return<bool> BiometricsFingerprint::isUdfps(uint32_t) {
    return true;
}

Return<void> BiometricsFingerprint::onFingerDown(uint32_t, uint32_t, float, float) {
    BiometricsFingerprint::enableHighBrightFod();

    std::thread([this]() {
        std::this_thread::sleep_for(std::chrono::milliseconds(500));
        BiometricsFingerprint::onFingerUp();
    }).detach();

    return Void();
}

Return<void> BiometricsFingerprint::onFingerUp() {
    BiometricsFingerprint::disableHighBrightFod();

    return Void();
}

}  // namespace implementation
}  // namespace V2_3
}  // namespace fingerprint
}  // namespace biometrics
}  // namespace hardware
}  // namespace android
