# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit git-r3
inherit edo

DESCRIPTION="66 frontends for services included in the busybox suite"
HOMEPAGE="https://git.obarun.org/66-service/alpine/busybox-daemons"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="ISC"
SLOT="0"
#KEYWORDS="~amd64" # masked anyway by -9999
#IUSE=""

src_configure() {
for _frontend_ in ${S}/frontends/*
do edo sed "s|%%BUSYBOXBIN%%|\/bin\/busybox|g" -i "${_frontend_}"
done
}

src_install() {
edo mkdir -p "${ED}/usr/share/66/service"

for _frontend_ in ${S}/frontends/*
do edo cp -ra "${_frontend_}" "${ED}/usr/share/66/service"
done
}
