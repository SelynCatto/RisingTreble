TARGET_GAPPS_ARCH := arm64
include build/make/target/product/aosp_arm64.mk
$(call inherit-product, device/phh/treble/base.mk)

$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

$(call inherit-product, vendor/lineage/config/BoardConfigSoong.mk)
$(call inherit-product, device/lineage/sepolicy/common/sepolicy.mk)
include vendor/lineage/build/core/config.mk

PRODUCT_NAME := rising_arm64_bcgN
PRODUCT_DEVICE := arm64_bcgN
PRODUCT_BRAND := google
PRODUCT_SYSTEM_BRAND := google
PRODUCT_MODEL := RisingOS with Core GApps

# Rising stuff
RISING_MAINTAINER=UniversalX
PRODUCT_BUILD_PROP_OVERRIDES += \
    RISING_MAINTAINER="UniversalX"

TARGET_ENABLE_BLUR := false
PRODUCT_NO_CAMERA := false

# Rising GMS
WITH_GMS := true
TARGET_CORE_GMS := true
#Uncomment for core+ build
#TARGET_CORE_GMS_EXTRAS := true
TARGET_DEFAULT_PIXEL_LAUNCHER := false

# Overwrite the inherited "emulator" characteristics
PRODUCT_CHARACTERISTICS := device

PRODUCT_PACKAGES += 

