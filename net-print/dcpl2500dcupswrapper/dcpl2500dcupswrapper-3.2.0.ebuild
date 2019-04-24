# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils unpacker

SRC_REV="1"

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Brother DCP L2500D cups wrapper"

SRC_URI="${PN}-${PV}-${SRC_REV}.i386.deb"

LICENSE="GPL-2"
SLOT="0"

IUSE=""
RESTRICT="fetch mirror splitdebug"

RDEPEND="net-print/cups
		net-print/dcpl2500dlpr
		dev-lang/perl"
DEPEND="${RDEPEND}"

S=${WORKDIR}
QA_PREBUILT="*"

pkg_nofetch() {
	einfo "Please download"
	einfo " - ${PN}-${PV}-${SRC_REV}.i386.deb"
	einfo "from BROTHER and put it into DISTDIR"
}

src_install() {
	DCPDIR="opt/brother/Printers/DCPL2500D"

	doins -r *
	cd "${ED}" || die

	mkdir -p usr/libexec/cups/filter
	mkdir -p usr/share/cups/model

	dosym ${EPREFIX}/${DCPDIR}/cupswrapper/brother_lpdwrapper_DCPL2500D usr/libexec/cups/filter/brother_lpdwrapper_DCPL2500D
	dosym ${EPREFIX}/${DCPDIR}/cupswrapper/brother-DCPL2500D-cups-en.ppd usr/share/cups/model/brother-DCPL2500D-cups-en.ppd

	fperms +x /${DCPDIR}/cupswrapper/paperconfigml1
	fperms +x /${DCPDIR}/cupswrapper/brother_lpdwrapper_DCPL2500D
}
