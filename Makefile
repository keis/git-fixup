PREFIX?=/usr/local
INSTALLDIR?=$(PREFIX)
INSTALL=install

install:
	${INSTALL} -d ${INSTALLDIR}/bin
	${INSTALL} -m755 git-fixup ${INSTALLDIR}/bin/git-fixup

install-zsh:
	${INSTALL} -d ${INSTALLDIR}/share/zsh/site-functions
	${INSTALL} -m755 completion.zsh ${INSTALLDIR}/share/zsh/site-functions/_git-fixup
