# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmp3splt/libmp3splt-0.7.0.920.ebuild,v 1.2 2012/05/21 19:08:12 xarthisius Exp $

EAPI=2
inherit versionator autotools eutils multilib

DESCRIPTION="a library for mp3splt to split mp3 and ogg files without decoding."
HOMEPAGE="http://mp3splt.sourceforge.net"
SRC_URI="http://ioalex.net/testing_downloads/snapshots/$(get_version_component_range 4)/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc pcre"

RDEPEND="media-libs/libmad
	media-libs/libvorbis
	media-libs/libogg
	media-libs/libid3tag
	pcre? ( dev-libs/libpcre )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen media-gfx/graphviz )
	sys-apps/findutils"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.7-{flags,libltdl}.patch
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-static \
		$(use_enable pcre) \
		$(use_enable doc doxygen_doc) \
		--disable-cutter  # TODO package cutter <http://cutter.sourceforge.net/>
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog LIMITS NEWS README TODO || die
	find "${D}"/usr -name '*.la' -delete
}
