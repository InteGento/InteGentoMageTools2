#!/bin/bash

# MageTools2 v 0.1.0
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
        fi;
        ismagento='y';
        break;
    fi;
done

if [ $ismagento == 'n' ]; then
    cd ${SCRIPTSTARTDIR};
    echo "/!\\ The script could not find a Magento root dir /!\\";
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
case "$1" in
    'copy' | 'cp')
        echo -e "${CLR_BLUE}## COPY${CLR_DEF}";
        . "${SOURCEDIR}/inc/copy.sh" $2;
    ;;
esac
