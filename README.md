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

```
git-fixup [-s|--squash] [-f|--fixup] [-c|--commit] [--no-verify]
          [--rebase] [-b|--base <rev>] [<ref>]
```

For this tool to make any sense you should enable the `rebase.autosquash`
setting in the git config, or use the `--rebase` option.


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

## Options

### -s, --squash

Instruct `git-fixup` to create a `squash!` commit instead of a `fixup!` commit.

Squashing gives you the opportunity to edit the commit message before
the commits are squashed together.

Default action can be configured by setting [fixup.action](#fixupaction)

### -f, --fixup

Instruct `git-fixup` to create `fixup!` commit (This is the default).

Default action can be configured by setting [fixup.action](#fixupaction)

### -c, --commit

Instead of listing the suggested commits show a menu to pick a commit to
create a fixup/squash commit of.

A [default menu](#the-default-menu) is provided that is intentionally very
simple and with no advanced features. Instead of using it you can tell `git
fixup` to use an external tool for the menu by defining a command line via
either the [fixup.menu](#fixupmenu) setting in the git config or the `GITFIXUPMENU`
environment variable (the latter overrides the former).

```bash
# Use fzf as a menu program
$ GITFIXUPMENU=fzf git fixup -c
```

This option can be enabled by default by setting [fixup.commit](#fixupcommit)
in the git config.

### --no-commit

Don't show the commit menu even if previously instructed to do so.

### --rebase

Call an interactive rebase right after the commit is created, to automatically apply the
fix-up into the target commit. This is merely to avoid doing two commands one after the
other (`git fixup && git rebase`).

This simply calls `git rebase --interactive --autosquash target~1`, with the target being the
commit to fix-up.

Default rebase/no-rebase can be configured by setting [fixup.rebase](#fixuprebase)

### --no-rebase

Don't do a rebase even if previously instructed to do so (useful to bypass [fixup.rebase](#fixuprebase))

### --no-verify

Bypass the pre-commit and commit-msg hooks. (see `git help commit`)


### --base <rev>

This option receives as argument the revision to be used as base commit for
the search of fixup/squash candidates. You can use anything that resolves to a
commit. The special value `closest` resolves to the closest ancestor branch of
the current head.

If omitted, the default base commit is resolved in the following order:

1. The value of the environment variable `GITFIXUPBASE` if present;
2. The value of the configuration key `fixup.base` if present;
3. The branch configured as upstream of the current one (i.e. `@{upstream}`)
   if existing;
4. Finally, the root commit (i.e. full history) if nothing of the above is
   satisfied.

## Configuration

`git-fixup` uses configuration from the ENVIRONMENT or from `git config`

### fixup.base

Or `GITFIXUPBASE`

The default argument for `--base`. You can set the value `closest` to make
`git-fixup` use the closest ancestor branch by default, for example.

### fixup.action

Or `GITFIXUPACTION`

Decides if the default actions will be `fixup` or `squash`.

### fixup.commit

Or `GITFIXUPCOMMIT`

Decides if the commit menu should be displayed instead of the commit list by
default.

```bash
# Enable --commit for all my projects
$ git config --global fixup.commit true
```

### fixup.rebase

Or `GITFIXUPREBASE`

Decides if `git rebase` should be called right after the `git commit` call.

```bash
# Enable --rebase for all my projects
$ git config --global fixup.rebase true
```

### fixup.menu

Or `GITFIXUPMENU`

Sets the command that will be used to display the commit menu. If not set
a simple [default menu](default menu] will be used.

See [External menu](#external-menu) for more details and a more advanced
example.

## Tab completion

Tab completion for zsh/fish is implemented. The suggestions for the tab completion
are the suggested fixup bases as generated by running the tool without any
arguments.

To be able to tab complete the command itself add a line like this to your zsh
configuration::

    zstyle ':completion:*:*:git:*' user-commands fixup:'Create a fixup commit'


## External menu

In order to use an external tool for display the commit menu, you need to
either define the [fixup.menu](#fixupmenu) setting in the git config or set the
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

## The default menu

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

## Changelog

See [CHANGELOG.md](CHANGELOG.md)

## Authors

The fine people who have contributed to this script in ASCIIbetical order.

- Cristiano Giuffrida ([cgiuffr](https://github.com/cgiuffr))
- David Keijser ([keis](https://github.com/keis))
- Elan Ruusamäe ([glensc](https://github.com/glensc))
- Gustavo Sousa ([guludo](https://github.com/guludo))
- Joe Shaw ([joeshaw](https://github.com/joeshaw))
- Philippe ([pe](https://github.com/pe))
- Rickard Dybeck ([alde](https://github.com/alde))
- Tiago Ribeiro ([fixe](https://github.com/fixe))
