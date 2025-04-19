# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson
inherit ninja-utils
inherit optfeature

# Package name: sys-apps/turnstile
DESCRIPTION="A login/session manager which also supports user-service-managers"
HOMEPAGE="https://github.com/chimera-linux/turnstile"
SRC_URI="https://github.com/chimera-linux/${PN}/archive/refs/tags/v${PV}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
sys-libs/pam
"
RDEPEND="${DEPEND}"
BDEPEND="
dev-build/cmake
app-text/scdoc
"

pkg_setup() {
optfeature_header
optfeature "Seat management; ${PN} doesn't do it" sys-auth/seatd
}
