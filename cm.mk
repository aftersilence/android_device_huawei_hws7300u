## Specify phone tech before including full_phone
$(call inherit-product, vendor/cm/config/gsm.mk)

# Boot animation	  	
TARGET_SCREEN_HEIGHT := 1280	
TARGET_SCREEN_WIDTH := 800

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_tablet_wifionly.mk)

# Inherit device configuration
$(call inherit-product, device/huawei/hws7300u/device_hws7300u.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := hws7300u
PRODUCT_NAME := cm_hws7300u
PRODUCT_BRAND := Huawei
PRODUCT_MODEL := Huawei MediaPad
PRODUCT_MANUFACTURER := Huawei

ADDITIONAL_DEFAULT_PROPERTIES += ro.secure=0
ADDITIONAL_DEFAULT_PROPERTIES += ro.allow.mock.location=1
