#compdef git-fixup

function _fixup_target {
    local -a lines commits
    local expl

    lines=(${(f)"$(git fixup)"}) 2>&1 | read err
    if [ $#lines -eq 0 ]; then
        _message $err
        return 1
    fi
    commits=(${lines[@]%% *})
    _wanted commits expl 'likely commits' compadd -l -d lines -a -- commits

    more=(${(f)"$(git --no-pager log @{upstream}..HEAD --format='%H %s <%ae>')"})
    more_commits=(${more[@]%% *})
    _wanted more-commits expl 'more commits' compadd -l -d more -a -- more_commits
}

_arguments -A \
    '(-s --squash)'{-s,--squash}'[Create a squash commit rather than a fixup]' \
    ':commit:_fixup_target'
