# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit git-r3

DESCRIPTION="A useflag-configured metapackage to pull in 66 frontend packages without cluttering set @world"
EGIT_REPO_URI=""

SLOT="0"
KEYWORDS="amd64"
IUSE="-busybox -acpid -iwd -wpa-supplicant -utlogd -elogind"

RDEPEND="
busybox? 66-frontend/66-busybox-frontends
acpid? 66-frontend/66-acpid-frontend
iwd? 66-frontend/66-iwd-frontend
wpa-supplicant? 66-frontend/66-wpa-supplicant-frontends
utlogd? 66-frontend/66-utlogd-frontend
elogind? 66-frontend/66-elogind-frontend
"
