# fish completion for git fixup

function __fish_git_fixup_target
    git fixup --no-commit --no-rebase 2>/dev/null | string replace -r '^([0-9a-f]{10})[0-9a-f]* (.*)' '$1\t$2'
end

complete -c git -n '__fish_git_using_command fixup' -s s -l squash -f -d 'create a squash commit rather than a fixup'
complete -c git -n '__fish_git_using_command fixup' -s c -l commit -f -d 'show a menu to pick a commit'
complete -c git -n '__fish_git_using_command fixup' -l no-commit -f -d 'don\'t show a menu to pick a commit'
complete -c git -n '__fish_git_using_command fixup' -l no-verify -f -d 'bypass the pre-commit and commit-msg hooks'
complete -c git -n '__fish_git_using_command fixup' -f -k -a '(__fish_git_fixup_target)'
