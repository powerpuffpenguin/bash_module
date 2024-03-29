#!/usr/bin/env bash
# api
# * english https://github.com/powerpuffpenguin/bash_module/tree/main/document/en/strings.md
# * zh_Hant https://github.com/powerpuffpenguin/bash_module/tree/main/document/zh_Hant/strings.md

if [[ "$__module_flag_of_core_strings" == 1 ]];then
    return 0
fi
__module_flag_of_core_strings=1


core_strings_Ok=0
# return core_strings_Ok
function core_strings.Ok
{
    echo -n "$core_strings_Ok"
}
# func StartWith(str: string, sub: string): 1 or 0
# return to core_strings_Ok
function core_strings.StartWith
{
    declare -i l0=${#1}
    declare -i l1=${#2}

    if (( $l0 < $l1 ));then
        core_strings_Ok=0
        return 0
    fi
    local sub=${1::l1}
    if [[ "$sub" == "$2" ]];then
        core_strings_Ok=1
    else
        core_strings_Ok=0
    fi
}
# func EndWith(str: string, sub: string): 1 or 0
# return to core_strings_Ok
function core_strings.EndWith
{
    declare -i l0=${#1}
    declare -i l1=${#2}

    if (( $l0 < $l1 ));then
        core_strings_Ok=0
        return 0
    fi
    local sub=${1:l0-l1}
     if [[ "$sub" == "$2" ]];then
        core_strings_Ok=1
    else
        core_strings_Ok=0
    fi
}

core_strings_Strings=()
function core_strings.Strings
{
    core.Copy "$1" core_strings_Strings
}

# func Split(str: string, separator: string=" "): []string
# return to core_strings_Strings
function core_strings.Split
{
    core_strings_Strings=()
    local str="$1"
    local sep="$2"
    if [[ "$sep" == "" ]];then
        sep=" "
    fi

    declare -i i=0
    while [[ "$str" != "" ]]
    do
        local sub=${str#*$sep}
        if [[ ${#sub} == ${#str} ]];then
             core_strings_Strings[i]=$str
            break
        fi
        declare -i length=${#str}-${#sub}
        local name=${str::length-${#sep}}
        core_strings_Strings[i]=$name
        i=i+1
        str=${str:length}
    done
}
# func Join(arrname: string, separator: string=" "): string
function core_strings.Join
{
    core.Copy core_strings_Strings "$1"
    local result=$?
    if [[ "$result" != 0 ]];then
        return $result
    fi
   local str
   local first=1
   for str in "${core_strings_Strings[@]}";do
    if [[ $first == 1 ]];then
        echo -n "$str"
        first=0
    else
        echo -n "$2$str"
    fi
   done
}
# func TrimLeft(str: string, sub: string): string
function core_strings.TrimLeft
{
    local str="$1"
    local sep="$2"
    if [[ "$sep" == "" ]];then
        sep=" "
    fi
    while true
    do
        local sub=${str#$sep}
        if [[ ${#sub} == ${#str} ]];then
            echo -n "$sub"
            break
        else
            str=$sub
        fi
    done
}
# func TrimRight(str: string, sub: string): string
function core_strings.TrimRight
{
    local str="$1"
    local sep="$2"
    if [[ "$sep" == "" ]];then
        sep=" "
    fi
    while true
    do
        local sub=${str%$sep}
        if [[ ${#sub} == ${#str} ]];then
            echo -n "$sub"
            break
        else
            str=$sub
        fi
    done
}
# func Trim(str: string, sub: string): string
function core_strings.Trim
{
    local str=`core_strings.TrimLeft "$1" "$2"`
    core_strings.TrimRight "$str" "$2"
}