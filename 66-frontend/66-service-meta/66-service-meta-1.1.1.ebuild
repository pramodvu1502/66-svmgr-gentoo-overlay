# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

#inherit git-r3
#inherit edo

DESCRIPTION="A useflag-configured metapackage to pull in 66 frontend packages without cluttering set @world"
#EGIT_REPO_URI=""

SLOT="0"
KEYWORDS="amd64"
IUSE="-busybox -acpid -iwd -wpa-supplicant -elogind -iwd -networkmanager -wifi -acpi -dbus -dbus-broker -colord -connman -cups -dhclient"

# The basic package-name useflags
DEPEND="
busybox? ( 66-frontend/66-busybox-frontends )
acpid? ( 66-frontend/66-acpid-frontend )
iwd? ( 66-frontend/66-iwd-frontend )
wpa-supplicant? ( 66-frontend/66-wpa-supplicant-frontends )
elogind? ( 66-frontend/66-elogind-frontend )
networkmanager? ( 66-frontend/66-networkmanager-frontend )
bluetooth? ( 66-frontend/66-bluez-frontends )
colord? ( 66-frontend/66-colord-frontend )
connman? ( 66-frontend/66-connmand-frontend )
cups? ( 66-frontend/66-cups-frontend )
dhclient? ( 66-frontend/66-dhclient-frontend )
dhcpcd? ( 66-frontend/66-dhcpcd-frontends )
dmraid? ( 66-frontend/66-dmraid-frontend )
dnsmasq? ( 66-frontend/66-dnsmasq-frontend )
docker? ( 66-frontend/66-dockerd-frontend )
"

# Twisted flags to respect the usual USE whenever possible and above not sufficient.
RDEPEND="${DEPEND}
acpi? ( !elogind? ( 66-frontend/66-acpid-frontend ) )
wifi? ( !iwd? ( 66-frontend/66-wpa-supplicant-frontends ) )
dbus? ( dbus-broker? ( 66-frontend/dbus-broker-frontend ) !dbus-broker? ( 66-frontend/dbus-daemon-frontend ) )
"

pkg_setup() {
einfo "${CATEGORY}/${PN} is a metapackage"
einfo "It pulls other packages in category ${CATEGORY} based on useflags"
einfo "This category is meant exclusively for packages supplying 66 frontends"
einfo ""
einfo "Rather than cluttering portage's @world by manually merging the required frontend packages,"
einfo "just install this package. (And maybe tweak a bit of it via package.use)"
einfo ""
einfo "However, some packages (like sys-apps/utlogd in this repo) already have frontends in their packages;"
einfo "Their frontends aren't handled here"
einfo ""
einfo "It determines the required frontend packages via USE flags"
einfo "Sometines, the general USE flags aren't useful;"
einfo "sys-apps/busybox is just a package one installs, no useflag to pull it;"
einfo "for such packages, manually enable the appropriate package.use flag for this one package ${CATEGORY}/${PN}"
einfo ""
einfo "The limitation to us is that we can't modify existing frontends in ::gentoo to depend on us"
einfo "Nor can we set ourselves as requiredby..."
einfo "The only solution for now is to supply 66 frontends in separate packages"
einfo "And the task of determining and pulling them is handled by this metapackage"
einfo ""
}
