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
IUSE="-init"

DEPEND="
>=dev-libs/skalibs-2.14.3.0
>=sys-libs/oblibs-0.3.2.1
>=dev-lang/execline-2.9.6.1
"
RDEPEND="${DEPEND}
>=sys-apps/s6-2.13.1.0
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

 # Moving /sbin/init script to "/etc/66/init" for configurability and to avoid conflicts...
 edo mv "${ED}/usr/bin/init" "${ED}/etc/66/sbin-init"
 use init && mkdir -p "${ED}/sbin" && ln -s "../etc/66/init" "${ED}/sbin/init"

 # Moving the doc paths to conform to gentoo's FHS
 edo mv "${ED}/usr/share/doc/${PN}/${PV}" "${ED}/usr/share/doc/${PF}"
 edo rm -r "${ED}/usr/share/doc/${PN}"
}
