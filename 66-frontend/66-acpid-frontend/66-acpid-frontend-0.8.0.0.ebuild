# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit git-r3
inherit edo

DESCRIPTION="A useflag-configured metapackage to pull in 66 frontend packages without cluttering set @world"
HOMEPAGE="https://git.obarun.org/66-service/arch/acpid"
EGIT_REPO_URI="${HOMEPAGE}"
EGIT_COMMIT="8d2c01b7" # Commit tagged 0.8.0

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
