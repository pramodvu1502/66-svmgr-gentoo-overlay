# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Library with convenience functions used mainly by sys-apps/66"
HOMEPAGE="https://git.obarun.org/Obarun/oblibs"
SRC_URI="https://git.obarun.org/Obarun/${PN}/-/archive/${PV}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pic pie"

DEPEND="
>=dev-libs/skalibs-2.14.3.0
>=dev-lang/execline-2.9.6.1
"
RDEPEND="${DEPEND}"

pkg_setup() {
local emesonargs="-D with-pkgconfig=true $(meson_use pic enable-all-pic) $(meson_use pie enable-pie)"
}
