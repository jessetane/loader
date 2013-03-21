#
# test.sh
#

cd "$(dirname "$0")"

MODULE_ROOT="$(pwd)/fixtures"

. ../lib/module.sh

module load one 0.0.1
