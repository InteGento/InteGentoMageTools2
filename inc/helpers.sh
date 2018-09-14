#!/bin/bash

# Create path and copy
# https://stackoverflow.com/a/1534494
magetools2_bury_copy() {
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
