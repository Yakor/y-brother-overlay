# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils unpacker

SRC_REV="18+deb8u10"

KEYWORDS="-* ~amd64"

DESCRIPTION="i686 glibc for brother printer driver"

SRC_URI="ftp://ftp.us.debian.org/debian/pool/main/g/glibc/libc6-i686_${PV}-${SRC_REV}_i386.deb"

LICENSE="GPL-2"
SLOT="0"

IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"

S=${WORKDIR}
QA_PREBUILT="*"

src_install() {
	local BRLIB="opt/brother/lib32"

	mkdir -p ${ED}/${BRLIB}

	exeinto ${BRLIB}

	find . -type f -name "ld-*.so" -exec doexe '{}' +
	find . -type f -name "libc-*.so" -exec doexe '{}' +

	cd ${ED}/${BRLIB} || die

	find . -type f -name "ld-*.so" -exec dosym '{}' ${BRLIB}/ld-linux.so.2 \;
	find . -type f -name "libc-*.so" -exec dosym '{}' ${BRLIB}/libc.so.6 \;
}
