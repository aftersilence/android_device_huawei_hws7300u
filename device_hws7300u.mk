## Specify phone tech before including full_phone
$(call inherit-product, vendor/cm/config/gsm.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_tablet_wifionly.mk)

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, device/common/gps/gps_eu_supl.mk)

PRODUCT_CHARACTERISTICS := tablet

DEVICE_PACKAGE_OVERLAYS += device/huawei/hws7300u/overlay

LOCAL_PATH := device/huawei/hws7300u
ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := $(LOCAL_PATH)/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

# Modules
PRODUCT_COPY_FILES += \
    device/huawei/hws7300u/prebuilt/modules/qce.ko:system/lib/modules/qce.ko \
    device/huawei/hws7300u/prebuilt/modules/sch_dsmark.ko:system/lib/modules/sch_dsmark.ko \
    device/huawei/hws7300u/prebuilt/modules/spidev.ko:system/lib/modules/spidev.ko \
    device/huawei/hws7300u/prebuilt/modules/ksapi.ko:system/lib/modules/ksapi.ko \
    device/huawei/hws7300u/prebuilt/modules/rpc_server_handset.ko:system/lib/rpc_server_handset.ko \
    device/huawei/hws7300u/prebuilt/modules/qcrypto.ko:system/lib/modules/qcrypto.ko \
    device/huawei/hws7300u/prebuilt/modules/dal_remotetest.ko:system/lib/modules/dal_remotetest.ko \
    device/huawei/hws7300u/prebuilt/modules/tsif_chrdev.ko:system/lib/modules/tsif_chrdev.ko \
    device/huawei/hws7300u/prebuilt/modules/lcd.ko:system/lib/modules/lcd.ko \
    device/huawei/hws7300u/prebuilt/modules/tun.ko:system/lib/modules/tun.ko \
    device/huawei/hws7300u/prebuilt/modules/ansi_cprng.ko:system/lib/modules/ansi_cprng.ko \
    device/huawei/hws7300u/prebuilt/modules/scsi_wait_scan.ko:system/lib/modules/scsi_wait_scan.ko \
    device/huawei/hws7300u/prebuilt/modules/librasdioif.ko:system/lib/modules/librasdioif.ko \
    device/huawei/hws7300u/prebuilt/modules/mt9m114.ko:system/lib/modules/mt9m114.ko \
    device/huawei/hws7300u/prebuilt/modules/cls_flow.ko:system/lib/modules/cls_flow.ko \
    device/huawei/hws7300u/prebuilt/modules/dma_test.ko:system/lib/modules/dma_test.ko \
    device/huawei/hws7300u/prebuilt/modules/evbug.ko:system/lib/modules/evbug.ko \
    device/huawei/hws7300u/prebuilt/modules/msm_tsif.ko:system/lib/modules/msm_tsif.ko \
    device/huawei/hws7300u/prebuilt/modules/dhd.ko:system/lib/modules/dhd.ko \
    device/huawei/hws7300u/prebuilt/modules/gspca_main.ko:system/lib/modules/gspca_main.ko \
    device/huawei/hws7300u/prebuilt/modules/msm-buspm-dev.ko:system/lib/modules/msm-buspm-dev.ko \
    device/huawei/hws7300u/prebuilt/modules/qcedev.ko:system/lib/modules/qcedev.ko

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/base/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/base/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/base/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/base/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/base/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml \
    frameworks/base/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml

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
    audio.primary.msm8660 \
    libaudioutils

# Omx
PRODUCT_PACKAGES += \
    libdivxdrmdecrypt \
    libmm-omxcore \
    libOmxCore \
    libOmxVdec \
    libOmxVenc \
    libOmxAacEnc \
    libOmxAmrEnc \
    libstagefrighthw

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

## The gps config appropriate for this device
PRODUCT_COPY_FILES += device/common/gps/gps.conf_EU:system/etc/gps.conf

# Boot ramdisk
PRODUCT_COPY_FILES += \
    device/huawei/hws7300u/root/init:root/init \
    device/huawei/hws7300u/root/init.rc:root/init.rc \
    device/huawei/hws7300u/root/ueventd.rc:root/ueventd.rc \
    device/huawei/hws7300u/root/init.hws7300x.usb.rc:root/init.hws7300x.usb.rc \
    device/huawei/hws7300u/root/init.hws7300u.rc:root/init.hws7300u.rc \
    device/huawei/hws7300u/root/init.qcom.usb.rc:root/init.qcom.usb.rc \
    device/huawei/hws7300u/root/init.qcom.usb.sh:root/init.qcom.usb.sh \
    device/huawei/hws7300u/root/init.target.rc:root/init.target.rc \
    device/huawei/hws7300u/root/init.qcom.rc:root/init.qcom.rc \
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

# Custom media config for HTC camera
PRODUCT_COPY_FILES += \
    device/huawei/hws7300u/prebuilt/media_profiles.xml:system/etc/media_profiles.xml

## misc
PRODUCT_PROPERTY_OVERRIDES += \
    ro.setupwizard.enable_bypass=1 \
    dalvik.vm.lockprof.threshold=500 \
    ro.com.google.locationfeatures=1 \
    dalvik.vm.dexopt-flags=m=y

$(call inherit-product, frameworks/base/build/phone-xhdpi-1024-dalvik-heap.mk)

# proprietary side of the device
$(call inherit-product-if-exists, vendor/huawei/hws7300u/hws7300u-vendor.mk)

# 8660 Common Firmware
PRODUCT_COPY_FILES += \

# Common Qualcomm scripts
PRODUCT_COPY_FILES += \

$(call inherit-product, build/target/product/full.mk)

# We have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# This device is hdpi.
PRODUCT_AAPT_CONFIG := normal hdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi
PRODUCT_LOCALES += hdpi

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := cm_hws7300u
PRODUCT_DEVICE := hws7300u
