#compdef git-fixup
#description create a fixup commit

function _fixup_target {
    local -a lines commits

    lines=(${(f)"$(git fixup --no-commit 2>&1)"})
    if test $? -ne 0; then
        _message ${(F)lines}
        return 1
    fi

    commits=(${lines[@]%% *})
    compadd -l -d lines -a -- commits
}

_arguments -A \
    '(-s --squash)'{-s,--squash}'[create a squash commit rather than a fixup]' \
    '(-c --commit --no-commit)'{-c,--commit}'[create commit]' \
    '(-c --commit --no-commit)'--no-commit'[do not create commit]' \
    '(--no-verify)'--no-verify'[bypass the pre-commit and commit-msg hooks]' \
    ':commit:_fixup_target'
