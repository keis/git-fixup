#compdef git-fixup
#description create a fixup commit

function _fixup_target {
    local -a lines commits

    lines=(${(f)"$(git fixup --no-commit --no-rebase 2>&1)"})
    if test $? -ne 0; then
        _message ${(F)lines}
        return 1
    fi

    commits=(${lines[@]%% *})
    compadd -l -d lines -a -- commits
}

_arguments -A \
    '(-s --squash)'{-s,--squash}'[Create a squash commit rather than a fixup]' \
    '(-c --commit --no-commit)'{-c,--commit}'[Create a commit]' \
    '(-c --commit --no-commit)'--no-commit"[Don't create a commit]" \
    '(--rebase --no-rebase)'--rebase'[Do a rebase after commit]' \
    '(--rebase --no-rebase)'--no-rebase"[Don't do a rebase after commit]" \
    '(-b --base)'{-b,--base}+"[Use <rev> as base of the revision range for the search]":rev:__git_references \
    '(-n --no-verify)'{-n,--no-verify}'[Bypass the pre-commit and commit-msg hooks]' \
    ':commit:_fixup_target'
