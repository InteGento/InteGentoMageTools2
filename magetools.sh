#!/bin/bash

# MageTools2 v 0.2.2
#
# @author      Darklg <darklg.blog@gmail.com>
# @copyright   Copyright (c) 2017 Darklg
# @license     MIT

CLR_BLUE='\033[34m'; # SECTION
CLR_GREEN='\033[32m'; # MESSAGE
CLR_YELLOW='\033[33m'; # INFO
CLR_RED='\033[31m'; # MESSAGE
CLR_DEF='\033[0m'; # RESET

SCRIPTSTARTDIR="$( pwd )/";
MAGETOOLS_PROJECTPATH="$( pwd )/";

###################################
## Looking for a Magento Install
###################################

ismagento='n';
SOURCEDIR="$( dirname "${BASH_SOURCE[0]}" )/";
for (( c=1; c<=10; c++ )); do
    if [ ! -d "app" ]; then
        cd ..;
        echo ".";
    else
        if [ $c != 1 ]; then
            echo ". Found a Magento root dir";
            MAGETOOLS_PROJECTPATH="$( pwd )/";
        fi;
        ismagento='y';
        break;
    fi;
done

if [ $ismagento == 'n' ]; then
    cd "${SCRIPTSTARTDIR}";
    echo -e "${CLR_RED}/!\\ The script could not find a Magento root dir /!\\ ${CLR_DEF}";
    return 0;
fi;

###################################
## Load autocomplete
###################################

_magetools_options='copy';
complete -W "${_magetools_options}" 'magetools'

###################################
## Routing from initial argument
###################################

. "${SOURCEDIR}/inc/helpers.sh";
case "${1}" in
    'copy' | 'cp')
        . "${SOURCEDIR}/inc/copy.sh" "${2}";
    ;;
    'help' | *)
        if [ "${1}" != 'n' ]; then
            echo -e "${CLR_RED}Error : '${1}' is an invalid command.${CLR_DEF}";
        fi;
        . "${SOURCEDIR}/inc/help.sh" "${2}";
    ;;
esac
