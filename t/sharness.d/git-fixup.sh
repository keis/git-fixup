# Shared test helpers for the git-fixup test suite.
#
# This file is sourced automatically by sharness through t/sharness.d/.
# shellcheck shell=sh
# shellcheck disable=SC2154

# Isolate the tests from the user's own git configuration.
XDG_CONFIG_HOME="$SHARNESS_TRASH_DIRECTORY/.config"; export XDG_CONFIG_HOME
# The user scope alone is not enough: /etc/gitconfig can carry settings
# (init.defaultBranch, commit.gpgsign, ...) that alter test outcomes.
GIT_CONFIG_NOSYSTEM=1; export GIT_CONFIG_NOSYSTEM
# Editing should never block or spawn an interactive editor during tests.
GIT_EDITOR=:; export GIT_EDITOR
GIT_SEQUENCE_EDITOR=:; export GIT_SEQUENCE_EDITOR
# Test repositories get a fixed identity from the environment, so tests do not
# need per-repository git config for an author and committer (as in git/git).
GIT_AUTHOR_NAME="Test User"; export GIT_AUTHOR_NAME
GIT_AUTHOR_EMAIL=test@test.com; export GIT_AUTHOR_EMAIL
GIT_COMMITTER_NAME="Test User"; export GIT_COMMITTER_NAME
GIT_COMMITTER_EMAIL=test@test.com; export GIT_COMMITTER_EMAIL

# Compare two files and print a unified diff when they differ. The first
# argument is the expected content, the second the actual content, so the
# labels in the diff line up with the git convention test_cmp expected actual.
test_cmp () {
	diff -u "$1" "$2"
}

# Write <content> to <file>, honouring printf escapes such as \n, and stage
# the new content in the current repository.
# Note: POSIX sh has no local, so parameters live in prefixed names to avoid
# clobbering variables of the calling test body.
stage_file () {
	_file=$1
	_content=$2
	printf '%b' "$_content" >"$_file" &&
	git add -- "$_file"
}

# Write <content> to <file> and commit it, like git/git's test_commit() but
# without creating a tag.
commit_file () {
	_message=$1
	_file=$2
	_content=$3
	stage_file "$_file" "$_content" &&
	git commit -m "$_message" >/dev/null
}

# Create a fresh non-bare repository <name> in the trash directory and cd into
# it.
fresh_repo () {
	_name=$1
	cd "$SHARNESS_TRASH_DIRECTORY" &&
	rm -rf "$_name" &&
	git init -q "$_name" &&
	cd "$_name"
}

# Create a repository <name>repo cloned from a bare <name>remote and cd into
# it.
clone_repo () {
	_name=$1
	cd "$SHARNESS_TRASH_DIRECTORY" &&
	rm -rf "$_name"remote "$_name"repo &&
	git init -q --bare "$_name"remote &&
	git clone -q "$_name"remote "$_name"repo &&
	cd "$_name"repo
}

# Create a repository tracked by a remote. The upstream is pushed after the
# second commit, so the candidate search range covers "Add line three" and the
# remote-tracking branch resolves for @{upstream}.
#
# Commits:
#   Initial commit
#   Add line two         <- origin/master
#   Add line three
setup_repo () {
	(
		# A subshell scopes errexit, so a failing git command stops the
		# setup without && chains and without leaking state to the tests.
		set -e
		cd "$SHARNESS_TRASH_DIRECTORY"
		rm -rf remote repo
		git init -q --bare remote
		git clone -q remote repo
		cd repo
		commit_file "Initial commit" file.txt 'line one\n'
		commit_file "Add line two" file.txt 'line one\nline two\n'
		git push -q -u origin master
		commit_file "Add line three" file.txt 'line one\nline two\nline three\n'
	) || return 1
	# Tests leave the working directory inside the previous repo, so restore
	# it for the next test body that cd's into the freshly created one.
	cd "$SHARNESS_TRASH_DIRECTORY" || return 1
}

# Stage an extra line in file.txt
stage_change () {
	echo "$1" >>file.txt &&
	git add file.txt
}
