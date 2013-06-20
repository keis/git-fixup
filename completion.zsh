#compdef git-fixup
local lines words

lines=(${(f)"$(git fixup)"})
words=(${(f)"$(git fixup | cut -d' ' -f 1)"})

compadd -l -d lines -a -- words
