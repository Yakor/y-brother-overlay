# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MULTILIB_COMPAT=( abi_x86_{32,64} )
inherit multilib-build eutils unpacker

SRC_REV="1"

KEYWORDS="-* ~amd64 ~x86"

DESCRIPTION="Brother DCP L2500D driver"

SRC_URI="${PN}-${PV}-${SRC_REV}.i386.deb"

LICENSE="GPL-2"
SLOT="0"

IUSE=""
RESTRICT="fetch mirror splitdebug"

RDEPEND="!abi_x86_32? ( sys-libs/brother-nomultilib-glibc )
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
	local DCPDIR="opt/brother/Printers/DCPL2500D"
	local BRLIB="opt/brother/lib32"

	doins -r *

	cd "${ED}" || die

	dosym ${EPREFIX}/${DCPDIR}/inf/brDCPL2500Drc etc/${DCPDIR}/inf/brDCPL2500Drc

	mkdir -p usr/bin
	{
		echo -e "#!/bin/sh"
		echo -e "/${DCPDIR}/lpd/brprintconflsr3 -P DCPL2500D" '$''*'
	} > usr/bin/brprintconflsr3_DCPL2500D
	fperms +x /usr/bin/brprintconflsr3_DCPL2500D


	if ! use abi_x86_32; then
		mv ${DCPDIR}/lpd/brprintconflsr3 ${DCPDIR}/lpd/brprintconflsr3.bin
		{
			echo -e "#!/bin/sh"
			echo -e "linux32 /${BRLIB}/ld-linux.so.2 --library-path /${BRLIB} /${DCPDIR}/lpd/brprintconflsr3.bin" '$''*'
		} > ${DCPDIR}/lpd/brprintconflsr3
		fperms +x /${DCPDIR}/lpd/brprintconflsr3.bin

		mv ${DCPDIR}/lpd/rawtobr3 ${DCPDIR}/lpd/rawtobr3.bin
		{
			echo -e "#!/bin/sh"
			echo -e "linux32 /${BRLIB}/ld-linux.so.2 --library-path /${BRLIB} /${DCPDIR}/lpd/rawtobr3.bin" '$''*'
		} > ${DCPDIR}/lpd/rawtobr3
		fperms +x /${DCPDIR}/lpd/rawtobr3.bin

		mv ${DCPDIR}/inf/braddprinter ${DCPDIR}/inf/braddprinter.bin
		{
			echo -e "#!/bin/sh"
			echo -e "linux32 /${BRLIB}/ld-linux.so.2 --library-path /${BRLIB} /${DCPDIR}/inf/braddprinter.bin" '$''*'
		} > ${DCPDIR}/inf/braddprinter
		fperms +x /${DCPDIR}/inf/braddprinter.bin
	fi

	fperms +x /${DCPDIR}/lpd/brprintconflsr3
	fperms +x /${DCPDIR}/lpd/rawtobr3
	fperms +x /${DCPDIR}/lpd/filter_DCPL2500D
	fperms +x /${DCPDIR}/inf/braddprinter
	fperms +x /${DCPDIR}/inf/setupPrintcap

	keepdir var/spool/lpd/DCPL2500D
}
