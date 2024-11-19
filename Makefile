PREFIX?=/usr/local
INSTALLDIR?=$(PREFIX)
MANDIR?=$(INSTALLDIR)/usr/share/man/man1
INSTALL=install

all: git-fixup.1 git-fixup.html

install: git-fixup.1 install-fish install-zsh
	${INSTALL} -d ${DESTDIR}${INSTALLDIR}/bin
	${INSTALL} -m755 git-fixup ${DESTDIR}${INSTALLDIR}/bin/git-fixup
	${INSTALL} -m644 git-fixup.1 ${DESTDIR}${MANDIR}/man1/git-fixup.1

install-fish:
	${INSTALL} -d ${DESTDIR}${INSTALLDIR}/share/fish/vendor_completions.d/
	${INSTALL} -m644 completion.fish ${DESTDIR}${INSTALLDIR}/share/fish/vendor_completions.d/git-fixup.fish

install-zsh:
	${INSTALL} -d ${DESTDIR}${INSTALLDIR}/share/zsh/site-functions
	${INSTALL} -m644 completion.zsh ${DESTDIR}${INSTALLDIR}/share/zsh/site-functions/_git-fixup

git-fixup.1: git-fixup.txt
	asciidoctor -b manpage -d manpage -o $@ $<

git-fixup.html: git-fixup.txt
	asciidoctor -d manpage -o $@ $<

clean:
	rm -f git-fixup.html git-fixup.1 *~

.PHONY: install-fish install-zsh
