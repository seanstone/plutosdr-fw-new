################################################################################
#
# libini
#
################################################################################

LIBINI_VERSION = c3413da
LIBINI_SITE = https://github.com/pcercuei/libini.git
LIBINI_SITE_METHOD = git

LIBINI_INSTALL_STAGING = YES
LIBINI_LICENSE = LGPLv2.1+
LIBINI_LICENSE_FILES = LICENSE.txt

$(eval $(cmake-package))
