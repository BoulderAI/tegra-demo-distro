DESCRIPTION = "System installation scripts"
HOMEPAGE = "https://github.com/madisongh/tegra-sysinstall"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=5e5799d70d07956d01af05a7a92ea0d7"

DEPENDS = "zlib"

COMPATIBLE_MACHINE = "(tegra)"

SRC_URI = "https://github.com/madisongh/tegra-sysinstall/releases/download/v${PV}/tegra-sysinstall-${PV}.tar.gz"
SRC_URI[sha256sum] = "3952c94cca4365db215f92accbe79d1522c21b153507f39960fa1e36b96931e7"

S = "${WORKDIR}/tegra-sysinstall-${PV}"

inherit autotools

FILES_${PN} += "${datadir}/tegra-sysinstall"
EXTRA_RDEPENDS = ""
RDEPENDS_${PN} = "tegra-boot-tools tar ${EXTRA_RDEPENDS} \
                  bash curl util-linux-blkid util-linux-lsblk util-linux-mountpoint \
                  parted gptfdisk e2fsprogs util-linux-mkfs util-linux-mount \
                  util-linux-umount tegra-fuse-tool tegra-eeprom-tool-boardspec \
                  sysinstall-partition-layout mtd-utils"