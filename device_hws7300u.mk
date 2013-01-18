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

LOCAL_PATH := device/huawei/hws7300u  	
ifeq ($(TARGET_PREBUILT_KERNEL),)
    LOCAL_KERNEL := $(LOCAL_PATH)/kernel
else
    LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)	
endif

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

# Modules
PRODUCT_COPY_FILES += \
    device/huawei/hws7300u/prebuilt/lib/modules/qce.ko:system/lib/modules/qce.ko \
    device/huawei/hws7300u/prebuilt/lib/modules/sch_dsmark.ko:system/lib/modules/sch_dsmark.ko \
    device/huawei/hws7300u/prebuilt/lib/modules/spidev.ko:system/lib/modules/spidev.ko \
    device/huawei/hws7300u/prebuilt/lib/modules/ksapi.ko:system/lib/modules/ksapi.ko \
    device/huawei/hws7300u/prebuilt/lib/modules/rpc_server_handset.ko:system/lib/modules/rpc_server_handset.ko \
    device/huawei/hws7300u/prebuilt/lib/modules/qcrypto.ko:system/lib/modules/qcrypto.ko \
    device/huawei/hws7300u/prebuilt/lib/modules/dal_remotetest.ko:system/lib/modules/dal_remotetest.ko \
    device/huawei/hws7300u/prebuilt/lib/modules/tsif_chrdev.ko:system/lib/modules/tsif_chrdev.ko \
    device/huawei/hws7300u/prebuilt/lib/modules/lcd.ko:system/lib/modules/lcd.ko \
    device/huawei/hws7300u/prebuilt/lib/modules/tun.ko:system/lib/modules/tun.ko \
    device/huawei/hws7300u/prebuilt/lib/modules/ansi_cprng.ko:system/lib/modules/ansi_cprng.ko \
    device/huawei/hws7300u/prebuilt/lib/modules/scsi_wait_scan.ko:system/lib/modules/scsi_wait_scan.ko \
    device/huawei/hws7300u/prebuilt/lib/modules/librasdioif.ko:system/lib/modules/librasdioif.ko \
    device/huawei/hws7300u/prebuilt/lib/modules/mt9m114.ko:system/lib/modules/mt9m114.ko \
    device/huawei/hws7300u/prebuilt/lib/modules/cls_flow.ko:system/lib/modules/cls_flow.ko \
    device/huawei/hws7300u/prebuilt/lib/modules/dma_test.ko:system/lib/modules/dma_test.ko \
    device/huawei/hws7300u/prebuilt/lib/modules/evbug.ko:system/lib/modules/evbug.ko \
    device/huawei/hws7300u/prebuilt/lib/modules/msm_tsif.ko:system/lib/modules/msm_tsif.ko \
    device/huawei/hws7300u/prebuilt/lib/modules/dhd.ko:system/lib/modules/dhd.ko \
    device/huawei/hws7300u/prebuilt/lib/modules/gspca_main.ko:system/lib/modules/gspca_main.ko \
    device/huawei/hws7300u/prebuilt/lib/modules/msm-buspm-dev.ko:system/lib/modules/msm-buspm-dev.ko \
    device/huawei/hws7300u/prebuilt/lib/modules/qcedev.ko:system/lib/modules/qcedev.ko \
    device/huawei/hws7300u/prebuilt/lib/modules/xpad.ko:system/lib/modules/xpad.ko \
    device/huawei/hws7300u/prebuilt/lib/modules/ff-memless.ko:system/lib/modules/ff-memless.ko

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
    libhwcexternal \
    libhwcservice \
    libmemalloc \
    liboverlay \
    libqdutils \
    libtilerenderer \
    libI420colorconvert

# Audio
PRODUCT_PACKAGES += \
    audio.primary.msm8660 \
    audio.a2dp.default \
    audio_policy.msm8660 \
    libaudioutils

# Omx
PRODUCT_PACKAGES += \
    libdivxdrmdecrypt \
    libmm-omxcore \
    libOmxCore \
    libstagefrighthw \
    libOmxVdec \
    libOmxVenc \
    libOmxAacEnc \
    libOmxAmrEnc \
    libOmxEvrcEnc \
    libOmxQcelp13Enc
	
# Device specific settings
PRODUCT_PACKAGES += \
     MediapadSettings \

# GPS
PRODUCT_PACKAGES += \
    gps.default

# Power
PRODUCT_PACKAGES += \
    power.msm8660

# HDMI
PRODUCT_PACKAGES += \
    hdmid

# QRNGD
PRODUCT_PACKAGES += \
    qrngd

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
    e2fsck \
    setup_fs

# Boot ramdisk
PRODUCT_COPY_FILES += \
    device/huawei/hws7300u/root/init.emmc.rc:root/init.emmc.rc \
    device/huawei/hws7300u/root/fstab.qcom:root/fstab.qcom \
    device/huawei/hws7300u/root/ueventd.rc:root/ueventd.rc \
    device/huawei/hws7300u/root/init.hws7300u.usb.rc:root/init.hws7300u.usb.rc \
    device/huawei/hws7300u/root/init.hws7300u.rc:root/init.hws7300u.rc \
    device/huawei/hws7300u/root/init.qcom.usb.sh:root/init.qcom.usb.sh \
    device/huawei/hws7300u/root/init.target.rc:root/init.target.rc \
    device/huawei/hws7300u/root/init.qcom.sh:root/init.qcom.sh

# Scripts
PRODUCT_COPY_FILES += \
    device/huawei/hws7300u/prebuilt/etc/init.qcom.fm.sh:system/etc/init.qcom.fm.sh \
    device/huawei/hws7300u/prebuilt/etc/init.qcom.modem_links.sh:system/etc/init.qcom.modem_links.sh \
    device/huawei/hws7300u/prebuilt/etc/init.qcom.mdm_links.sh:system/etc/init.qcom.mdm_links.sh \
    device/huawei/hws7300u/prebuilt/etc/init.qcom.coex.sh:system/etc/init.qcom.coex.sh \
    device/huawei/hws7300u/prebuilt/etc/init.hw.insmod.sh:system/etc/init.hw.insmod.sh \
    device/huawei/hws7300u/prebuilt/etc/init.brcm.bt.sh:system/etc/init.brcm.bt.sh \
    device/huawei/hws7300u/prebuilt/etc/init.bt.sh:system/etc/init.bt.sh \
    device/huawei/hws7300u/prebuilt/etc/init.qcom.sdio.sh:system/etc/init.qcom.sdio.sh \
    device/huawei/hws7300u/prebuilt/etc/init.qcom.bt.sh:system/etc/init.qcom.bt.sh \
    device/huawei/hws7300u/prebuilt/etc/init.qcom.post_boot.sh:system/etc/init.qcom.post_boot.sh \
    device/huawei/hws7300u/prebuilt/etc/bluetooth_power.sh:system/etc/bluetooth_power.sh

# Firmware
PRODUCT_COPY_FILES += \
    device/huawei/hws7300u/prebuilt/etc/firmware/cyttsp_8660_ffa.hex:system/etc/firmware/cyttsp_8660_ffa.hex \
    device/huawei/hws7300u/prebuilt/etc/firmware/cyttsp_8660_fluid_p2.hex:system/etc/firmware/cyttsp_8660_fluid_p2.hex \
    device/huawei/hws7300u/prebuilt/etc/firmware/cyttsp_8660_fluid_p3.hex:system/etc/firmware/cyttsp_8660_fluid_p3.hex \
    device/huawei/hws7300u/prebuilt/etc/firmware/dsps_fluid.b00:system/etc/firmware/dsps_fluid.b00 \
    device/huawei/hws7300u/prebuilt/etc/firmware/dsps_fluid.b01:system/etc/firmware/dsps_fluid.b01 \
    device/huawei/hws7300u/prebuilt/etc/firmware/dsps_fluid.b02:system/etc/firmware/dsps_fluid.b02 \
    device/huawei/hws7300u/prebuilt/etc/firmware/dsps_fluid.b03:system/etc/firmware/dsps_fluid.b03 \
    device/huawei/hws7300u/prebuilt/etc/firmware/dsps_fluid.mdt:system/etc/firmware/dsps_fluid.mdt \
    device/huawei/hws7300u/prebuilt/etc/firmware/leia_pfp_470.fw:system/etc/firmware/leia_pfp_470.fw \
    device/huawei/hws7300u/prebuilt/etc/firmware/leia_pm4_470.fw:system/etc/firmware/leia_pm4_470.fw \
    device/huawei/hws7300u/prebuilt/etc/firmware/vidc_1080p.fw:system/etc/firmware/vidc_1080p.fw \
    device/huawei/hws7300u/prebuilt/etc/firmware/yamato_pfp.fw:system/etc/firmware/yamato_pfp.fw \
    device/huawei/hws7300u/prebuilt/etc/firmware/yamato_pm4.fw:system/etc/firmware/yamato_pm4.fw \
    device/huawei/hws7300u/prebuilt/etc/firmware/t1320_tm1828_001.img:system/etc/firmware/t1320_tm1828_001.img \
    device/huawei/hws7300u/prebuilt/etc/firmware/t1320_tm1885_004.img:system/etc/firmware/t1320_tm1885_004.img \
    device/huawei/hws7300u/prebuilt/etc/firmware/s7020_suc.img:system/etc/firmware/s7020_suc.img \
    device/huawei/hws7300u/prebuilt/etc/firmware/atmel_cmi_pro.img:system/etc/firmware/atmel_cmi_pro.img

# Adreno libs
PRODUCT_COPY_FILES += \
    device/huawei/hws7300u/prebuilt/lib/egl/eglsubAndroid.so:system/lib/egl/eglsubAndroid.so \
    device/huawei/hws7300u/prebuilt/lib/egl/libEGL_adreno200.so:system/lib/egl/libEGL_adreno200.so \
    device/huawei/hws7300u/prebuilt/lib/egl/libGLESv1_CM_adreno200.so:system/lib/egl/libGLESv1_CM_adreno200.so \
    device/huawei/hws7300u/prebuilt/lib/egl/libGLESv2_adreno200.so:system/lib/egl/libGLESv2_adreno200.so \
    device/huawei/hws7300u/prebuilt/lib/egl/libq3dtools_adreno200.so:system/lib/egl/libq3dtools_adreno200.so \
    device/huawei/hws7300u/prebuilt/lib/egl/libGLESv2S3D_adreno200.so:system/lib/egl/libGLESv2S3D_adreno200.so \
    device/huawei/hws7300u/prebuilt/lib/libc2d2_z180.so:system/lib/libc2d2_z180.so \
    device/huawei/hws7300u/prebuilt/lib/libC2D2.so:system/lib/libC2D2.so \
    device/huawei/hws7300u/prebuilt/lib/libgsl.so:system/lib/libgsl.so \
    device/huawei/hws7300u/prebuilt/lib/libOpenVG.so:system/lib/libOpenVG.so \
    device/huawei/hws7300u/prebuilt/lib/libsc-a2xx.so:system/lib/libsc-a2xx.so \

# Some misc configuration files
PRODUCT_COPY_FILES += \
    device/huawei/hws7300u/prebuilt/etc/audio_policy.conf:system/etc/audio_policy.conf \
    device/huawei/hws7300u/prebuilt/etc/vold.fstab:system/etc/vold.fstab \
    device/huawei/hws7300u/prebuilt/usr/idc/t1320.idc:system/usr/idc/t1320.idc \
    device/huawei/hws7300u/prebuilt/usr/idc/s7020.idc:system/usr/idc/s7020.idc

# Keylayouts
PRODUCT_COPY_FILES += \
    device/huawei/hws7300u/prebuilt/usr/keylayout/8660_handset.kl:system/usr/keylayout/8660_handset.kl \
    device/huawei/hws7300u/prebuilt/usr/keylayout/fluid-keypad.kl:system/usr/keylayout/fluid-keypad.kl \
    device/huawei/hws7300u/prebuilt/usr/keylayout/ffa-keypad.kl:system/usr/keylayout/ffa-keypad.kl

# Custom media config
PRODUCT_COPY_FILES += \
    device/huawei/hws7300u/prebuilt/etc/media_profiles.xml:system/etc/media_profiles.xml \
    device/huawei/hws7300u/prebuilt/etc/media_codecs.xml:system/etc/media_codecs.xml

# Auto loading of gamepad modules
PRODUCT_COPY_FILES += \
    device/huawei/hws7300u/prebuilt/etc/init.d/01x360ctrlr:system/etc/init.d/01x360ctrlr

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
