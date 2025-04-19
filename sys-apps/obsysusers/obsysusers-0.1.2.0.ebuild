# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo

# Package name: sys-apps/obsysusers
DESCRIPTION="Creates system users and groups as per sysusers.d definitions"
HOMEPAGE="https://web.obarun.org/software/obsysusers/v0.1.2.0/index"
SRC_URI="https://git.obarun.org/Obarun/${PN}/-/archive/${PV}/${P}.tar.gz"

LICENSE="0BSD"
SLOT="0"
KEYWORDS="~amd64"
#IUSE=""

DEPEND="
>=dev-libs/skalibs-2.14.3.0
>=sys-libs/oblibs-0.3.2.1
"
RDEPEND="${DEPEND}
sys-apps/shadow
"
BDEPEND="
app-text/lowdown
"

src_configure() {
 local econfargs=(
 "--prefix=/usr"
 "--with-sysdeps=${EPREFIX}/usr/$(get_libdir)/skalibs"
 "--dynlibdir=${EPREFIX}/usr/$(get_libdir)"
 "--libdir=${EPREFIX}/usr/$(get_libdir)/${PN}"
 )

 edo ./configure "${econfargs[@]}"
}

src_install() {
 emake DESTDIR="${ED}" install

 # Moving the doc paths to conform to gentoo's FHS
 edo mv "${ED}/usr/share/doc/${PN}/${PV}" "${ED}/usr/share/doc/${PF}"
 edo rm -r "${ED}/usr/share/doc/${PN}"
}
