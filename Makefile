TARGET := iphone:clang:16.5:14.0
INSTALL_TARGET_PROCESSES = YouTube

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = YTeto
YTeto_FILES = src/YTeto.xm src/Settings.xm
YTeto_CFLAGS = -fobjc-arc
YTeto_FRAMEWORKS = UIKit Foundation

include $(THEOS_MAKE_PATH)/tweak.mk
