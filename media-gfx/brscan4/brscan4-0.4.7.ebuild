# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils unpacker

SRC_REV="1"

KEYWORDS="~x86 ~amd64"

DESCRIPTION="Brother Image Scan"
SRC_URI="amd64? (${PN}-${PV}-${SRC_REV}.amd64.deb)
		 x86? (${PN}-${PV}-${SRC_REV}.i386.deb)"

LICENSE="GPL-2"
SLOT="0"

IUSE=""
RESTRICT="fetch mirror splitdebug"

RDEPEND="media-gfx/sane-backends"
DEPEND="${RDEPEND}"

S=${WORKDIR}
QA_PREBUILT="*"

pkg_nofetch() {
	einfo "Please download"
	einfo "  - ${SRC_URI}"
	einfo "from BROTHER and put it into DISTDIR"
}

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	doins -r *

	find ${ED} -type f -name "*.so.*" -exec chmod +x '{}' +
	fperms +x /opt/brother/scanner/brscan4/brsaneconfig4
}

pkg_postinst() {
	local DLL_CONF="/etc/sane.d/dll.conf"

	if grep -q "\<brother4\>" ${DLL_CONF}; then
		elog "A entry 'brother4' was in ${DLL_CONF}"
	else
		echo "brother4" >> ${DLL_CONF}
		elog "A new entry 'brother4' was added to ${DLL_CONF}"
	fi
	elog "If you are using a USB scanner, add all users who want"
	elog "to access your scanner to the \"scanner\", \"lp\", \"usb\" group."
}
