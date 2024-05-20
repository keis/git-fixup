## Changelog

### v1.6.0 / 2024-05-20
- [#71](https://github.com/keis/git-fixup/pull/71) Install zsh completion with mode 644, add `install-fish` target (@mattst88)
- [#70](https://github.com/keis/git-fixup/pull/70) Fail script if git-commit fails (@keis)
- [#66](https://github.com/keis/git-fixup/pull/66) Add --all option (@jerome-reybert-tiempo)
- [#67](https://github.com/keis/git-fixup/pull/67) Add --amend option (@guludo)
- [#64](https://github.com/keis/git-fixup/pull/64) Fix tab completion for revisions in base parameter (@pe)
- [#63](https://github.com/keis/git-fixup/pull/63) Remove filenames in tab-completion in fish (@pe)
- [#62](https://github.com/keis/git-fixup/pull/62) Add short option -n for --no-verify (@bbannier)
- [#61](https://github.com/keis/git-fixup/pull/61) Fix default menu markdown link (@glensc)

### v1.5.0 / 2022-05-24
- [#60](https://github.com/keis/git-fixup/pull/60) Add new options to completion scripts (@keis)
- [#59](https://github.com/keis/git-fixup/pull/59) Add `--rebase` option that calls rebase after commit (@FdelMazo)
- [#57](https://github.com/keis/git-fixup/pull/57) Recover lost `git fixup <ref>` functionality (@FdelMazo)
- [#56](https://github.com/keis/git-fixup/pull/56) Add --base option (#56) (@guludo)
- [#55](https://github.com/keis/git-fixup/pull/55) Use the option parsing plumbing of git-sh-setup (@keis)
- [#54](https://github.com/keis/git-fixup/pull/54) No-verify: doc and completion (@pe)

### v1.4.0 / 2021-08-25
- [#52](https://github.com/keis/git-fixup/pull/52) Add --no-verify option to pass to git commit (@glensc)
- [#50](https://github.com/keis/git-fixup/pull/50) Add tab completion for the fish shell (@pe)
- [#49](https://github.com/keis/git-fixup/pull/49) replace readarray (@pe)
- [#47](https://github.com/keis/git-fixup/pull/47) Make the various options and config behave consistently (@keis)

### v1.3.0 / 2020-02-14
- [#45](https://github.com/keis/git-fixup/pull/45) Use bash from PATH for brew (@glensc)
- [#43](https://github.com/keis/git-fixup/pull/43) Updates to zsh completion (@aschrab)

### v1.2.0 / 2019-02-28
- [#39](https://github.com/keis/git-fixup/pull/39) Add the --commit option (@guludo)

### v1.1.2 / 2018-04-26
- [#36](https://github.com/keis/git-fixup/pull/36) Fix completion for Zsh 5.3 (@eigengrau)
- [#34](https://github.com/keis/git-fixup/pull/34) Don’t use --invert-grep. (@mcepl)

### v1.1.1 / 2016-08-11
- [#31](https://github.com/keis/git-fixup/pull/31) Use DESTDIR in Makefile (@Shir0kamii)
- [#28](https://github.com/keis/git-fixup/pull/28) Don't use symmetrical rev range (@keis)

### v1.1.0 / 2015-12-22
- [#27](https://github.com/keis/git-fixup/pull/27) Exclude other fixups from recent commits (@keis)
- [#25](https://github.com/keis/git-fixup/pull/25) update zsh completion script (@keis)
- [#24](https://github.com/keis/git-fixup/pull/24) add support for squashing with the `-s` or `--squash` params (@joeshaw)

### v1.0.2 / 2015-04-09
- [#22](https://github.com/keis/git-fixup/pull/22) add ISC license text (@keis)
- [#20](https://github.com/keis/git-fixup/pull/20) redirect error message to stderr (@keis)
- [#17](https://github.com/keis/git-fixup/pull/17) Add screenshot to README (@fixe)

### v1.0.1 / 2015-02-26
- [#16](https://github.com/keis/git-fixup/pull/16) When installing, create any missing parent dirs. (@Josh-Tilles)
- [#15](https://github.com/keis/git-fixup/pull/15) Add brew install information to README (@nunofgs)

### v1.0.0 / 2015-02-24
- [#13](https://github.com/keis/git-fixup/pull/13) no pager on git log please (@keis)
- [#12](https://github.com/keis/git-fixup/pull/12) fallback to all commits when rev range is empty (@keis)
- [#10](https://github.com/keis/git-fixup/pull/10) Update README (@fixe)
- [#8](https://github.com/keis/git-fixup/pull/8) Fix git blame file usage (@fixe)
- [#6](https://github.com/keis/git-fixup/pull/6) Simplify how the commit message is fetched (@fixe)
- [#4](https://github.com/keis/git-fixup/pull/4) git-fixup improvements (@cgiuffr)
- [#3](https://github.com/keis/git-fixup/pull/3) cd to toplevel before doing git blame (@keis)
- [#1](https://github.com/keis/git-fixup/pull/1) Create dir before installing to it (@alde)
