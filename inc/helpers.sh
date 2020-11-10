#!/bin/bash

# Create path and copy
# https://stackoverflow.com/a/1534494
function magetools2_bury_copy() {
    mkdir -p `dirname $2` && cp "$1" "$2";
}

# Sed
function magetools2_sed(){
    sed_tmp_file="${MAGETOOLS_PROJECTPATH}/tmp.txt";
    echo "${2}" > "${sed_tmp_file}";
    sed -i.bak "${1}" "${sed_tmp_file}";
    rm "${sed_tmp_file}.bak";
    cat "${sed_tmp_file}";
    rm "${sed_tmp_file}";
}

function magetools2_uppercase(){
    sttr="${1}";
    sttr="$(tr '[:lower:]' '[:upper:]' <<< ${sttr:0:1})${sttr:1}";
    echo "${sttr}";
}

function magetools2_check_dependencies(){
    if [[ ! -f "${_MAGERUN_FILE}" ]];then
        echo '# Downloading Magerun';
        wget -P "${TOOLSDIR}" https://files.magerun.net/n98-magerun2.phar;
        chmod +x "${_MAGERUN_FILE}";
    fi;

    if [[ ! -f "${_COMPOSER_FILE}" ]];then
        echo '# Downloading composer';
        curl -sS https://getcomposer.org/installer | php;
        mv composer.phar "${TOOLSDIR}composer.phar";
        chmod +x "${_COMPOSER_FILE}";
    fi;
}
