PREFIX?=/usr/local
INSTALLDIR?=$(PREFIX)
INSTALL=install

install:
	${INSTALL} -d ${DESTDIR}${INSTALLDIR}/bin
	${INSTALL} -m755 git-fixup ${DESTDIR}${INSTALLDIR}/bin/git-fixup

install-fish:
	${INSTALL} -d ${DESTDIR}${INSTALLDIR}/share/fish/vendor_completions.d/
	${INSTALL} -m644 completion.fish ${DESTDIR}${INSTALLDIR}/share/fish/vendor_completions.d/git-fixup.fish

install-zsh:
	${INSTALL} -d ${DESTDIR}${INSTALLDIR}/share/zsh/site-functions
	${INSTALL} -m644 completion.zsh ${DESTDIR}${INSTALLDIR}/share/zsh/site-functions/_git-fixup
