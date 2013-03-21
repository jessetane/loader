#
# test.sh
#

# go to dir
cd "$(dirname "$0")"

# source module library
. ../lib/module.sh

# env
MODULE_ROOT="$(pwd)/fixtures"

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
    summarize
    exit 1
  fi
  ((t++))
}

summarize() {
  [ $((--t)) = $expected ] && status="success" || status="failure"
  echo ""
  echo "-- $status --"
  echo "$t of $expected tests passed"
}

# 1
module load tester 0.0.1
tap "module load tester 0.0.1"

# 2
test "$PATH" != "$original_path"
tap "PATH changed"
original_path="$PATH"

# 2
test "$(tester)" = "0.0.1"
tap "execute tester 0.0.1"

# 4
man -d tester &> /dev/null
tap "man page lookup for tester 0.0.1"

# 5
module load tester 0.0.2
tap "module load tester 0.0.2"

# 6
test "$PATH" != "$original_path"
tap "PATH changed"
original_path="$PATH"

# 7
test "$(tester)" = "0.0.2"
tap "execute tester 0.0.2"

# 8
man -d tester &> /dev/null
tap "man page lookup for tester 0.0.2"

# done
summarize
