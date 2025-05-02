# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit git-r3
inherit optfeature
inherit edo

# PackageName: sys-process/66-boot
DESCRIPTION="The core boot@ module for booting using sys-apps/66"
HOMEPAGE="https://git.obarun.org/66-service/gentoo/boot-module"
EGIT_REPO_URI="https://git.obarun.org/66-service/gentoo/boot-module"
EGIT_COMMIT="7acaf10a" # The commit for the tag ${PV} (=3.8.1)

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cryptsetup nftables dmraid lvm btrfs zfs"

BDEPEND="
app-text/lowdown
"
#sys-apps/systemd-utils[udev,kmod,tmpfiles]
RDEPEND="
sys-apps/66
sys-apps/66-tools
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
# --opentmpfiles-script not touched as frontends are using bindir instead; using systemd-tmpfiles
# --modules-script also left alone as modules.sh is inlined into the modules-system frontend itself
# rest of the options untouched as defaults are used

# EnvVars editable in boot@'s envfile; here only "defaults" are set
# A prefixed '!' to the value means the envVar will be unset after substitution into the script; Kindly respect that to avoid pollution
econfargs+=(
"--HARDWARECLOCK=!UTC"
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

# DESTDIR envVar needs to be set *before* configure too...
export DESTDIR="${ED}"

edo ./configure "${econfargs[@]}"
}

src_install() {
emake DESTDIR="${ED}" install

# Moving document paths to respect gentoo
edo mkdir -p "#{ED}/usr/share/doc/${PF}"
edo mv "${ED}/usr/share/doc/boot@.html" "${ED}/usr/share/doc/${PF}"
}
