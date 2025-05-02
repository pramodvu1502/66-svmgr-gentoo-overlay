# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo

# Package name: sys-apps/sdnotify-wrapper
DESCRIPTION="A wrapper which uses sd_notify() in behalf of the daemon, allowing the daemon to use the s6 protocol"
HOMEPAGE="https://www.skarnet.org/software/misc/sdnotify-wrapper.c"
SRC_URI="${HOMEPAGE}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
>=dev-libs/skalibs-2.14.3.0
"

RDEPEND="${DEPEND}"

pkg_setup() {
einfo "The source file itself has simple documentation for usage;"
einfo "A single C file is the software's web homepage, source, documentation, everything."
einfo "It does depend on skalibs; A small lightweight general-purpose C library"
ewarn "The package ebuild is incapable of compiling using anything other than gcc for now"
}

src_unpack() {
# The source is just a C file; just copy it
edo mkdir -p "${S}"
edo cp "${A}" "${S}/sdnotify-wrapper.c"
}

src_build() {
# As the source is just a single C file, no Makefile or whatever
# Just a single call to gcc
edo gcc -o sdnotify-wrapper -L"${EPREFIX}/usr/$(get_libdir)/skalibs" "sdnotify-wrapper.c" -l"skarnet"
}

src_install() {
# Manually copy the binary as required
edo mkdir -p "${ED}/bin"
edo cp "${S}/sdnotify-wrapper" "${ED}/bin/sdnotify-wrapper"
}
