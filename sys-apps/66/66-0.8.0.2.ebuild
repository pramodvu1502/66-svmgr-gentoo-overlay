# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo

# Package name: sys-apps/66
DESCRIPTION="Init system and dependency management over s6"
HOMEPAGE="https://web.obarun.org/software/66/0.8.0.2/index/"
SRC_URI="https://git.obarun.org/Obarun/${PN}/-/archive/${PV}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="-init +tools +networking +s6-linux-utils +s6-portable-utils"

DEPEND="
>=sys-libs/oblibs-0.3.2.1
"
RDEPEND="${DEPEND}
>=sys-apps/s6-2.13.1.0
tools? ( sys-apps/66-tools )
networking? ( net-misc/s6-networking )
s6-linux-utils? ( sys-apps/s6-linux-utils )
s6-portable-utils? ( sys-apps/s6-portable-utils )
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
 use init && edo mkdir -p "${ED}/sbin" && edo ln -sf "../etc/66/sbin-init" "${ED}/sbin/init"

 # Moving the doc paths to conform to gentoo's FHS
 edo mv "${ED}/usr/share/doc/${PN}/${PV}" "${ED}/usr/share/doc/${PF}"
 edo rm -rf "${ED}/usr/share/doc/${PN}"
}
