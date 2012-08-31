#
# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

PRODUCT_AAPT_CONFIG := normal large tvdpi hdpi
PRODUCT_AAPT_PREF_CONFIG := tvdpi

DEVICE_PACKAGE_OVERLAYS := \
    device/huawei/hws7300u/overlay

PRODUCT_PROPERTY_OVERRIDES := \
    wifi.interface=wlan0 \
    wifi.supplicant_scan_interval=15 \
    tf.enable=y \
    drm.service.enabled=true

include frameworks/native/build/tablet-7in-hdpi-1024-dalvik-heap.mk

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, device/common/gps/gps_eu_supl.mk)

PRODUCT_CHARACTERISTICS := tablet

DEVICE_PACKAGE_OVERLAYS += device/huawei/hws7300u/overlay

# Modules that are currently not built on the fly
PRODUCT_COPY_FILES += \
    device/huawei/hws7300u/prebuilt/modules/rpc_server_handset.ko:system/lib/rpc_server_handset.ko \
    device/huawei/hws7300u/prebuilt/modules/dhd.ko:system/lib/modules/dhd.ko

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml

# for PDK build, include only when the dir exists
# too early to use $(TARGET_BUILD_PDK)
ifneq ($(wildcard packages/wallpapers/LivePicker),)
PRODUCT_COPY_FILES += \
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml
endif

# QCOM Display
PRODUCT_PACKAGES += \
    copybit.msm8660 \
    gralloc.msm8660 \
    hwcomposer.msm8660 \
    libgenlock \
    libmemalloc \
    liboverlay \
    libQcomUI \
    libtilerenderer

# Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio_policy.msm8660 \
    audio_policy.conf \
    audio.primary.msm8660 \
    libaudioutils

# Omx
PRODUCT_PACKAGES += \
    libdivxdrmdecrypt \
    libmm-omxcore \
    libOmxCore \
    libOmxVdec \
    libOmxVenc \
    libstagefrighthw \
    libstagefright_client

# GPS
PRODUCT_PACKAGES += \
    gps.default

# Power
PRODUCT_PACKAGES += \
    power.msm8660

# HDMI
PRODUCT_PACKAGES += \
    hdmid

# Misc
PRODUCT_PACKAGES += \
    com.android.future.usb.accessory

# Live Wallpapers
PRODUCT_PACKAGES += \
    LiveWallpapers \
    LiveWallpapersPicker \
    VisualizationWallpapers \
    librs_jni

# Filesystem management tools
PRODUCT_PACKAGES += \
    make_ext4fs \
    setup_fs

# Boot ramdisk
PRODUCT_COPY_FILES += \
    device/huawei/hws7300u/root/init:root/init \
    device/huawei/hws7300u/root/init.rc:root/init.rc \
    device/huawei/hws7300u/root/ueventd.rc:root/ueventd.rc \
    device/huawei/hws7300u/root/init.hws7300x.usb.rc:root/init.hws7300x.usb.rc \
    device/huawei/hws7300u/root/init.hws7300u.rc:root/init.hws7300u.rc \
    device/huawei/hws7300u/root/init.qcom.usb.sh:root/init.qcom.usb.sh \
    device/huawei/hws7300u/root/init.target.rc:root/init.target.rc \
    device/huawei/hws7300u/root/init.qcom.sh:root/init.qcom.sh

# Recovery ramdisk
PRODUCT_COPY_FILES += \
    device/huawei/hws7300u/recovery/ueventd.rc:recovery/root/ueventd.rc

# Scripts
PRODUCT_COPY_FILES += \
    device/huawei/hws7300u/prebuilt/scripts/init.qcom.fm.sh:system/etc/init.qcom.fm.sh \
    device/huawei/hws7300u/prebuilt/scripts/init.qcom.modem_links.sh:system/etc/init.qcom.modem_links.sh \
    device/huawei/hws7300u/prebuilt/scripts/init.qcom.mdm_links.sh:system/etc/init.qcom.mdm_links.sh \
    device/huawei/hws7300u/prebuilt/scripts/init.qcom.coex.sh:system/etc/init.qcom.coex.sh \
    device/huawei/hws7300u/prebuilt/scripts/init.hw.insmod.sh:system/etc/init.hw.insmod.sh \
    device/huawei/hws7300u/prebuilt/scripts/init.brcm.bt.sh:system/etc/init.brcm.bt.sh \
    device/huawei/hws7300u/prebuilt/scripts/test.bt.sh:system/etc/test.bt.sh \
    device/huawei/hws7300u/prebuilt/scripts/init.bt.sh:system/etc/init.bt.sh \
    device/huawei/hws7300u/prebuilt/scripts/init.qcom.sdio.sh:system/etc/init.qcom.sdio.sh \
    device/huawei/hws7300u/prebuilt/scripts/init.qcom.bt.sh:system/etc/init.qcom.bt.sh \
    device/huawei/hws7300u/prebuilt/scripts/init.qcom.post_boot.sh:system/etc/init.qcom.post_boot.sh \
    device/huawei/hws7300u/prebuilt/scripts/init.qcom.wifi.sh:system/etc/init.qcom.wifi.sh \
    device/huawei/hws7300u/prebuilt/scripts/bluetooth_power.sh:system/etc/bluetooth_power.sh

# Some misc configuration files
PRODUCT_COPY_FILES += \
    device/huawei/hws7300u/prebuilt/vold.fstab:system/etc/vold.fstab \
    device/huawei/hws7300u/prebuilt/t1320.idc:system/usr/idc/t1320.idc

# Keylayouts
PRODUCT_COPY_FILES += \
    device/huawei/hws7300u/prebuilt/keylayout/8660_handset.kl:system/usr/keylayout/8660_handset.kl \
    device/huawei/hws7300u/prebuilt/keylayout/fluid-keypad.kl:system/usr/keylayout/fluid-keypad.kl \
    device/huawei/hws7300u/prebuilt/keylayout/ffa-keypad.kl:system/usr/keylayout/ffa-keypad.kl

# Custom media config
PRODUCT_COPY_FILES += \
    device/huawei/hws7300u/prebuilt/media_profiles.xml:system/etc/media_profiles.xml \
    device/huawei/hws7300u/prebuilt/media_codecs.xml:system/etc/media_codecs.xml

## misc
PRODUCT_PROPERTY_OVERRIDES += \
    ro.setupwizard.enable_bypass=1 \
    dalvik.vm.lockprof.threshold=500 \
    ro.com.google.locationfeatures=1 \
    dalvik.vm.dexopt-flags=m=y

# proprietary side of the device
$(call inherit-product-if-exists, vendor/huawei/hws7300u/hws7300u-vendor.mk)

# We have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := cm_hws7300u
PRODUCT_DEVICE := hws7300u
