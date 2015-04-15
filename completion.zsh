#compdef git-fixup

function _fixup_target {
    local -a lines commits

    lines=(${(f)"$(git fixup)"}) 2>&1 | read err
    if [ $#lines -eq 0 ]; then
        _message $err
        return 1
    fi
    commits=(${lines[@]%% *})
    compadd -l -d lines -a -- commits
}

_arguments -A \
    '(-s --squash)'{-s,--squash}'[Create a squash commit rather than a fixup]' \
    ':commit:_fixup_target'
