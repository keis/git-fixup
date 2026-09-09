#!/bin/sh
# shellcheck disable=SC2034,SC2016,SC1091
test_description="git-fixup flags and operations"

. "$(dirname "$0")/sharness.sh"

test_expect_success 'git-fixup can create a fixup commit' '
	setup_repo &&
	cd repo &&
	stage_change "fixup content" &&
	git fixup HEAD~1 &&
	git log -1 --format=%s | grep -q "^fixup!"
'

test_expect_success '-s creates a squash commit' '
	setup_repo &&
	cd repo &&
	stage_change "squash content" &&
	git fixup -s HEAD~1 &&
	git log -1 --format=%s | grep -q "^squash!"
'

test_expect_success '-a creates an amend commit' '
	setup_repo &&
	cd repo &&
	stage_change "amend content" &&
	git fixup -a HEAD~1 &&
	git log -1 --format=%s | grep -q "^amend!"
'

test_expect_success 'GITFIXUPACTION overrides the default operation' '
	setup_repo &&
	cd repo &&
	stage_change "env action content" &&
	GITFIXUPACTION=squash git fixup HEAD~1 &&
	git log -1 --format=%s | grep -q "^squash!"
'

test_expect_success 'too many refs is rejected' '
	setup_repo &&
	cd repo &&
	stage_change "multi ref content" &&
	! git fixup HEAD~1 HEAD 2>error &&
	grep -q "Pass only one ref" error
'

test_expect_success 'pre-commit hook failure blocks git-fixup' '
	setup_repo &&
	cd repo &&
	printf "#!/bin/sh\necho \"pre-commit hook blocked the commit\" >&2\nexit 1\n" >.git/hooks/pre-commit &&
	chmod +x .git/hooks/pre-commit &&
	stage_change "hooked content" &&
	! git fixup HEAD~1 2>error &&
	grep -q "pre-commit hook blocked the commit" error
'

test_expect_success '-n bypasses the pre-commit hook' '
	setup_repo &&
	cd repo &&
	printf "#!/bin/sh\nexit 1\n" >.git/hooks/pre-commit &&
	chmod +x .git/hooks/pre-commit &&
	stage_change "noverify content" &&
	git fixup -n HEAD~1 &&
	git log -1 --format=%s | grep -q "^fixup!"
'

test_expect_success '-c with an external menu creates the commit' '
	setup_repo &&
	cd repo &&
	stage_change "menu content" &&
	GITFIXUPMENU="head -n 1" git fixup -c &&
	git log -1 --format=%s | grep -q "^fixup!" &&
	git log -1 --format=%s | grep -q "Add line three"
'

test_expect_success 'menu mode can be enabled through the environment' '
	setup_repo &&
	cd repo &&
	stage_change "commit config content" &&
	GITFIXUPCOMMIT=true GITFIXUPMENU="head -n 1" git fixup &&
	git log -1 --format=%s | grep -q "^fixup!"
'

test_expect_success '--rebase performs a rebase after the fixup' '
	setup_repo &&
	cd repo &&
	stage_change "rebase content" &&
	git fixup --rebase HEAD~1 2>rebase.log &&
	grep -q "Successfully rebased" rebase.log
'

test_done
