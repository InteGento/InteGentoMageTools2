#!/bin/bash

# MageTools2 v 0.7.3
#
# @author      Darklg <darklg.blog@gmail.com>
# @copyright   Copyright (c) 2020 Darklg
# @license     MIT

CLR_BLUE='\033[34m'; # SECTION
CLR_GREEN='\033[32m'; # MESSAGE
CLR_YELLOW='\033[33m'; # INFO
CLR_RED='\033[31m'; # MESSAGE
CLR_DEF='\033[0m'; # RESET

SOURCEDIR="$( dirname "${BASH_SOURCE[0]}" )/";
TOOLSDIR="${SOURCEDIR}tools/";
SCRIPTSTARTDIR="$( pwd )/";

_MAGERUN_FILE="${TOOLSDIR}n98-magerun2.phar";
_COMPOSER_FILE="${TOOLSDIR}composer.phar";

###################################
## Looking for a Magento Install
###################################

ismagento='n';
MAGETOOLS_PROJECTPATH="$( pwd )/";
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
## Tools
###################################

. "${TOOLSDIR}BashUtilities/modules/files.sh";
. "${TOOLSDIR}BashUtilities/modules/messages.sh";
. "${TOOLSDIR}BashUtilities/modules/texttransform.sh";
. "${TOOLSDIR}BashUtilities/modules/values.sh";
. "${TOOLSDIR}BashUtilities/modules/git.sh";

. "${SOURCEDIR}/inc/helpers.sh";

###################################
## Load autocomplete
###################################

_magetools_options='cache copy dlmedia env help self-update';
complete -W "${_magetools_options}" 'magetools'

###################################
## Test submodules
###################################

if [[ ! -f "${TOOLSDIR}BashUtilities/README.md" ]]; then
    cd "${SOURCEDIR}";
    git submodule update --init --recursive;
    cd "${_CURRENT_DIR}";
fi;

magetools2_check_dependencies;

###################################
## Routing from initial argument
###################################

case "${1}" in
    'cache' | 'deploy' | 'dlmedia' | 'env' | 'self-update' )
        . "${SOURCEDIR}/inc/${1}.sh" "${2}";
    ;;
    'copy' | 'cp')
        . "${SOURCEDIR}/inc/copy.sh" "${2}";
    ;;
    'help' | *)
        if [[ "${1}" != 'n' && "${1}" != 'help' && "${1}" != '' ]]; then
            echo $(bashutilities_message "'${1}' is an invalid command." 'error');
        fi;
        . "${SOURCEDIR}/inc/help.sh" "${2}";
    ;;
esac
