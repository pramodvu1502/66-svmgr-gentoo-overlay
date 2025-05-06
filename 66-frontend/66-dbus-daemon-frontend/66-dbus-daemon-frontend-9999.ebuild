# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit git-r3
inherit edo

DESCRIPTION="66 frontend for sys-apps/dbus"
HOMEPAGE="https://git.obarun.org/66-service/arch/dbus"
EGIT_REPO_URI="${HOMEPAGE}"

SLOT="0"
KEYWORDS="amd64"
LICENSE="ISC"

src_configure() {
local econfargs=(
--prefix="/usr"
--bindir="/bin"
--libdir="/usr/$(get_libdir)/66"
--shebangdir="/usr/bin"
)

# All other variables need to be defaults

# Needs a bit of work...
econfargs+=( --version="0.0.1" )

edo ./configure "${econfargs[@]}"
}
