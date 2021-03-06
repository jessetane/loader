#
# test.sh
#

# go to dir
cd "$(dirname "$0")"

# source library
. ../bin/loader.sh

# env
PKGPATH="$(pwd)/fixtures"

# vars
t=1
expected=8
original_path="$PATH"

# helpers
tap() {
  if [ $? = 0 ]
  then
    echo "✔  passed test #$t: $1"
  else
    echo "✘  failed test #$t: $1" >&2
    summarize && exit 1
  fi
  ((t++))
}

summarize() {
  [ $((--t)) = $expected ] && status="success" || status="failure"
  echo ""
  echo "----- $status -----"
  echo "$t of $expected tests passed"
}

# 1
load tester 0.0.1
tap "load tester 0.0.1"

# 2
test "$PATH" != "$original_path"
tap "PATH changed"
original_path="$PATH"

# 2
test "$(tester)" = "0.0.1"
tap "execute tester 0.0.1"

# 4
man -d tester 2>&1 | grep -q tester/build/0.0.1
tap "man page lookup for tester 0.0.1"

# 5
load tester 0.0.2
tap "load tester 0.0.2"

# 6
test "$PATH" != "$original_path"
tap "PATH changed"
original_path="$PATH"

# 7
test "$(tester)" = "0.0.2"
tap "execute tester 0.0.2"

# 8
man -d tester 2>&1 | grep -q tester/build/0.0.2
tap "man page lookup for tester 0.0.2"

# all done
summarize
