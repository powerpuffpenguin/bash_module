#!/usr/bin/env bash
set -e

BashDir=$(cd "$(dirname $BASH_SOURCE)" && pwd)
source "$BashDir/conf.sh"
if [[ "$Command" == "" ]];then
    Command="$0"
fi

function help(){
    echo "run test script"
    echo
    echo "Usage:"
    echo "  $Command [flags]"
    echo
    echo "Flags:"
    echo "  -h, --help          help for $Command"
}

ARGS=`getopt -o h --long help -n "$Command" -- "$@"`
eval set -- "${ARGS}"
while true
do
    case "$1" in
        -h|--help)
            help
            exit 0
        ;;
        --)
            shift
            break
        ;;
        *)
            echo Error: unknown flag "$1" for "$Command"
            echo "Run '$Command --help' for usage."
            exit 1
        ;;
    esac
done

dirs=(
    "test"
    "test/lib"
)

for dir in ${dirs[@]} 
do
    find "$Dir/$dir" -maxdepth 1 -name "*_test.sh" -type f | 
    while read file
    do
        "$file"
    done
done