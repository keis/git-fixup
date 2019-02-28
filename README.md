# git-fixup

Fighting the copy-paste element of your rebase workflow.

`git fixup <ref>` is simply an alias for `git commit --fixup <ref>`. That's
just a convenience feature that can be also be used to trigger tab completion.

The magic is in plain `git fixup` without any arguments.  It finds which
lines/files you have changed, uses git blame/log to find the most recent commits
that touched those lines/files, and displays a list for you to pick from. This
is a convenient alternative to manually searching through the commit log and
copy-pasting the commit hash.

<img src="https://cloud.githubusercontent.com/assets/484559/6431298/344ded94-c023-11e4-8b82-314387ceeee3.png" alt="git fixup" width="500px" />

## Install

On **OS X** you can install this script with _homebrew_

    brew install git-fixup

On **Arch linux** you can install from AUR using _yaourt_ or a similar tool

    yaourt git-fixup

On **gentoo** there is an [overlay](https://wiki.gentoo.org/wiki/Overlay) you
can use https://github.com/Shir0kamii/shiro-overlay

For most other systems (as long as they include `install` and `make`) you can
install by cloning this repo and running make

    git clone https://github.com/keis/git-fixup.git
    cd git-fixup
    make install
    make install-zsh

Or if you don't want to deal with any of that you can simply download the
scripts in anyway you like and make sure to put the program and completion
script into your `$PATH` and `$fpath` respectively.

## Usage

For this tool to make any sense you should enable the `rebase.autosquash`
setting in the git config.


```bash
# Select the changes that should be part of the fixup.
$ git add -p

# Output a list of commits that the staged changes are likely a fixup of.
$ git fixup

# Create a fixup!-<commit> of the given ref. If you have installed the zsh script
# you can cycle through the list of fixup candidates with tab completion.
$ git fixup <ref>

# Commit rebased into the selected commit as a fixup.
$ git rebase -i ...
```

### Squashing

`git-fixup` also supports squashing commits when you pass the `-s` or
`--squash` command-line flag.  This is equivalent to using `git commit
--squash <ref>`.

    $ git fixup --squash <ref>

Squashing gives you the opportunity to edit the commit message before
the commits are squashed together.

### The `--commit` option

If you are not using [tab completion](#tab-completion), it can easily become
tedious to use `git fixup` to list commit candidates and then copying the
commit hash to use with `git fixup <ref>`. For those use-cases, `git-fixup`
provides the `--commit` (or `-c`) command-line flag to make your life easier.
All options that apply to `git fixup <rev>` also apply to `git fixup --commit`.

With that option, `git fixup` expects you to select one commit from a menu and
then it creates the fixup/squash commit for you. We provide a [default
menu](#the-default-menu) that is intentionally very simple and with no advanced
features. Instead of using it you can tell `git fixup` to use an external tool
for the menu by defining a command line via either the `fixup.menu` setting in
the git config or the `GITFIXUPMENU` environment variable (the latter overrides
the former). Example:

```bash
# Use fzf as a menu program
$ GITFIXUPMENU=fzf git fixup -c
```

See [External menu](#external-menu) for more details and a more advanced
example.

#### `--commit` by default

If you find it convenient, you can configure `git-fixup` have the `--commit`
option enabled by default by setting `fixup.commit` in the git config.
Example:

```bash
# Enable --commit for all my projects
$ git config --global fixup.commit true
```

You can use `--no-commit` for disabling for a single command.

#### External menu

In order to use an external tool for display the commit menu, you need to
either define the `fixup.menu` setting in the git config or set the
`GITFIXUPMENU` environment variable with the command for the menu. The menu
command must receive as input the lines as the options for the user and return
the selected line to the standard output.

The following example is a fragment of a git config that makes `git fixup
--commit` display a nice menu with [fzf](https://github.com/junegunn/fzf):

```ini
[fixup]
    menu = fzf --height '60%' \
                --bind 'tab:toggle-preview' \
                --preview 'git show --color {+1}' \
                --preview-window=up:80% \
                --prompt 'Select commit: '
```

#### The default menu

If you have not configured an external menu, the default menu is used. See the
example below:

```bash
$ git fixup -c
1) 500be603c66040dd8a9ca18832d6221c00e96184 [F] Add README.md <foo@bar.com>
2) ddab3b03da529af5303531a3d4127e3663063e08 [F] Add index.js <foo@bar.com>
Which commit should I fixup? <your-selection>
```

Here `<your-selection>` should be the number of the desired commit in the list.
You can use `q` to abort the operation and `h` to see a help message for the
menu.

If the commit title alone is not enough for you to decide, you can use `show
<number>` to call `git show` on the `<number>`-th commit of the menu.

## Tab completion

The suggestions for the tab completion is the suggested fixup bases as
generated by running the tool without any arguments.

To be able to tab complete the command itself add a line like this to your zsh
configuration::

    zstyle ':completion:*:*:git:*' user-commands fixup:'Create a fixup commit'


## Changelog

See [CHANGELOG.md](CHANGELOG.md)

## Authors

- Rickard Dybeck ([alde](https://github.com/alde))
- Cristiano Giuffrida ([cgiuffr](https://github.com/cgiuffr))
- David Keijser ([keis](https://github.com/keis))
- Tiago Ribeiro ([fixe](https://github.com/fixe))
- Joe Shaw ([joeshaw](https://github.com/joeshaw))
- Gustavo Sousa ([guludo](https://github.com/guludo))
