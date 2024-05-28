TARGET_GAPPS_ARCH := arm64
include build/make/target/product/aosp_arm64.mk
$(call inherit-product, device/phh/treble/base.mk)



$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

$(call inherit-product, vendor/lineage/config/BoardConfigSoong.mk)
$(call inherit-product, device/lineage/sepolicy/common/sepolicy.mk)
include vendor/lineage/build/core/config.mk

PRODUCT_NAME := rising_arm64_bvN
PRODUCT_DEVICE := arm64_bvN
PRODUCT_BRAND := google
PRODUCT_SYSTEM_BRAND := google
PRODUCT_MODEL := RisingOS vanilla

# Rising stuff
RISING_MAINTAINER=UniversalX
PRODUCT_BUILD_PROP_OVERRIDES += \
    RISING_MAINTAINER="UniversalX"

TARGET_ENABLE_BLUR := false
PRODUCT_NO_CAMERA := false

RISING_PACKAGE_TYPE := "VANILLA_AOSP"

# Overwrite the inherited "emulator" characteristics
PRODUCT_CHARACTERISTICS := device

PRODUCT_PACKAGES += 

