#!/bin/sh

test_description='.'

export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME

TEST_PASSES_SANITIZE_LEAK=true
. ./test-lib.sh

test_expect_success 'setup' '
    git init almost-complete
    cd almost-complete/
    
    echo "Testing file 1" >test_01.txt
    git add test_01.txt
    git commit -m "Commiting the first file."
    echo "Testing file 2" >test_02.txt
    git add test_02.txt 
    git commit -m "Commiting the second file."
    echo "Modifying the first file." >>test_01.txt 
    git add test_01.txt 
    # git fixup --no-commit |grep -s "something"
    /bin/true
'

test_done
