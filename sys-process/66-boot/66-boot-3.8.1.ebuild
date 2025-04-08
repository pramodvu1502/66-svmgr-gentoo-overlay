# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit optfeature
inherit edo

# PackageName: sys-process/66-boot Version: 3.8.1
DESCRIPTION="The core boot@ module for booting using sys-apps/66"
HOMEPAGE="https://git.obarun.org/66-service/gentoo/boot"
SRC_URI="https://git.obarun.org/66-service/gentoo/boot-module/-/archive/${PV}/boot-module-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nftables dmraid lvm btrfs zfs" # udev tmpfiles etc... coming soon

BDEPEND="
app-text/lowdown
"

RDEPEND="
sys-apps/66
sys-apps/66-tools
sys-apps/systemd-utils[udev,kmod,tmpfiles]
app-shells/bash
sys-apps/iproute2
>=sys-apps/s6-linux-utils-2.6.2.1
>=sys-apps/s6-portable-utils-2.3.0.4
btrfs? ( sys-fs/btrfs-progs )
zfs? ( sys-fs/zfs sys-fs/zfs-kmod )
nftables? ( net-firewall/nftables )
"

pkg_setup() {
optfeature_header "Optional dependencies for basic network-packet routing and firewall:"
optfeature "Use iptables, ebtables, arbtables etc..." net-firewall/iptables
optfeature "Use the more advanced nft" net-firewall/nftables
}

src_configure() { # Under construction
local econfargs=(
"--prefix=${EPREFIX}/usr"
"--version=${PV}"
)
# --opentmpfiles-script not touched as source using bindir instead; using systemd-tmpfiles
# --modules-script also left alone as modules.sh is inlined into the modules-system frontend
# rest of the options untouched as defaults are used

# EnvVars editable in boot@'s envfile; here only "defaults" are set
# A prefixed '!' to the value means the envVar will be unset after substitution into the script; Kindly respect that to avoid pollution
econfargs+=(
"--HOSTNAME=gentoo" # This will be written to /etc/hostname in case of mismatch here and /etc/hostname
"--HARDWARECLOCK=UTC"
"--SETUPCONSOLE=!yes"
"--UDEV=!yes" # Will soon be configurable via USE=udev
# many more such EnvVars
)

use cryptsetup && econfargs+=("--CRYPTTAB=!yes")
use nftables && econfargs+=("--FIREWALL=nftables")
use btrfs && econfargs+=("--BTRFS=!yes")
use zfs && econfargs+=("--ZFS=!yes")
use lvm && econfargs+=("--LVM=!yes")
use dmraid && econfargs+=("--DMRAID=!yes" "--MDRAID=!yes")

edo ./configure "${econfargs[@]}"
}

src_build() { # The makefile defines make to call make-install internally; passing DESTDIR just in case
emake DESTDIR="${ED}"
}

src_install() {
emake DESTDIR="${ED}" install

# Moving document paths to respect gentoo
#mv "${ED}/usr/share/doc/${PN}/${PV}" "${ED}/usr/share/doc/${PF}"
}
