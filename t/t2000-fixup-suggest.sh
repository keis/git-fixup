#!/bin/sh
# shellcheck disable=SC2034,SC2016,SC1091
test_description="git-fixup suggestion generation"

. "$(dirname "$0")/sharness.sh"

test_expect_success 'listing candidates suggests the commit that last touched the file' '
	setup_repo &&
	cd repo &&
	stage_change "candidate content" &&
	git fixup >candidates &&
	grep -q "\[F\]" candidates &&
	grep -q "Add line three" candidates
'

test_expect_success 'listing candidates uses line-level blame' '
	cd "$SHARNESS_TRASH_DIRECTORY" &&
	rm -rf frameremote framerepo &&
	git init --bare frameremote >/dev/null &&
	git clone -q frameremote framerepo &&
	cd framerepo &&
	git config core.editor : &&
	git config user.email "test@test.com" &&
	git config user.name "Test User" &&
	printf "one\ntwo\nthree\nfour\nfive\n" >frame.txt &&
	git add frame.txt &&
	git commit -m "Initial frame" >/dev/null &&
	git push -q -u origin master &&
	printf "one\ntwo\nTHREE\nfour\nfive\n" >frame.txt &&
	git add frame.txt &&
	git commit -m "Modify line three" >/dev/null &&
	printf "one\ntwo\nTHREE\nFOUR\nfive\n" >frame.txt &&
	git add frame.txt &&
	git fixup >candidates &&
	grep -q "\[L\]" candidates &&
	grep -q "Modify line three" candidates
'

test_expect_success '-A lists every commit in the range' '
	setup_repo &&
	cd repo &&
	stage_change "all content" &&
	git fixup -A >output &&
	test "$(wc -l <output)" -eq 1 &&
	grep -q "Add line three" output
'

test_expect_success '-A with -b uses the given base for the range' '
	setup_repo &&
	cd repo &&
	stage_change "range content" &&
	git fixup -A -b HEAD~2 >output &&
	test "$(wc -l <output)" -eq 2 &&
	grep -q "Add line two" output &&
	grep -q "Add line three" output
'

test_expect_success '-b restricts the candidate search to the given range' '
	setup_repo &&
	cd repo &&
	echo "separate file" >other.txt &&
	git add other.txt &&
	git commit -m "Add other file" >/dev/null &&
	echo "more lines" >>other.txt &&
	git add other.txt &&
	git commit -m "Extend other file" >/dev/null &&
	echo "change" >>other.txt &&
	git add other.txt &&
	git fixup -b HEAD~1 >output &&
	grep -q "Extend other file" output &&
	! grep -q "Add line three" output
'

test_expect_success 'fails when nothing is staged' '
	setup_repo &&
	cd repo &&
	! git fixup 2>error &&
	grep -q "No staged changes" error
'

test_expect_success 'does not abort when no upstream is configured' '
	cd "$SHARNESS_TRASH_DIRECTORY" &&
	rm -rf noupstream &&
	git init -q noupstream &&
	cd noupstream &&
	git config core.editor : &&
	git config user.email "test@test.com" &&
	git config user.name "Test User" &&
	echo "line one" >file.txt &&
	git add file.txt &&
	git commit -m "Initial commit" >/dev/null &&
	echo "line two" >>file.txt &&
	git add file.txt &&
	git commit -m "Add line two" >/dev/null &&
	echo "candidate" >>file.txt &&
	git add file.txt &&
	git fixup >candidates &&
	grep -q "Add line two" candidates
'

test_done
