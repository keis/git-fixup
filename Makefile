PREFIX?=/usr/local
INSTALLDIR?=$(PREFIX)
INSTALL=install

install:
	${INSTALL} -d -m755 git-fixup ${INSTALLDIR}/bin/git-fixup

install-zsh:
	${INSTALL} -d -m755 completion.zsh ${INSTALLDIR}/share/zsh/site-functions/_git-fixup
