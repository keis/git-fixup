# fish completion for git fixup

function __fish_git_fixup_target
    git-fixup --no-commit --no-rebase 2>/dev/null | string replace -r '^([0-9a-f]{10})[0-9a-f]* (.*)' '$1\t$2'
end

complete -c git-fixup -s s -l squash -f -d 'Create a squash commit rather than a fixup'
complete -c git-fixup -s c -l commit -f -d 'Show a menu to pick a commit'
complete -c git-fixup -l no-commit -f -d 'Don\'t show a menu to pick a commit'
complete -c git-fixup -s n -l no-verify -f -d 'Bypass the pre-commit and commit-msg hooks'
complete -c git-fixup -l rebase -f -d 'Do a rebase after commit'
complete -c git-fixup -l no-rebase -f -d 'Don\'t do a rebase after commit'
complete -c git-fixup -s b -l base -x -d 'Use <rev> as base of the revision range for the search]' -a '(__fish_git_refs)'
complete -c git-fixup -f -k -a '(__fish_git_fixup_target)'
