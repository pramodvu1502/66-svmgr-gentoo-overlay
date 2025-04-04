# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo

# Package name: sys-apps/66
DESCRIPTION="Init system and dependency management over s6"
HOMEPAGE="https://web.obarun.org/software/66/0.8.0.2/index/"
SRC_URI="https://git.obarun.org/Obarun/${PN}/-/archive/${PV}/${P}.tar.gz"

LICENSE="0BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="init"

DEPEND="
>=dev-libs/skalibs-2.14.3.0
>=sys-libs/oblibs-0.3.2.1
>=dev-lang/execline-2.9.6.1
"
RDEPEND="${DEPEND}
>=sys-apps/s6-2.13.1.0
"
BDEPEND="app-text/lowdown"

src_configure() {
 local econfargs=(
 "--with-sysdeps=${EPREFIX}/usr/$(get_libdir)/skalibs"
 "--dynlibdir=${EPREFIX}/usr/$(get_libdir)"
 "--libdir=${EPREFIX}/usr/$(get_libdir)/${PN}"
 )

 edo ./configure "${econfargs[@]}"
}

src_install() {
 emake DESTDIR="${ED}" install
 # Moving the doc paths to conform to gentoo's FHS
 mv "${ED}/usr/share/doc/${PN}/${PV}" "${ED}/usr/share/doc/${PF}"
}
