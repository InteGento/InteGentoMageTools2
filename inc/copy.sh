#!/bin/bash

_newfile="${1}";
_basefile="${1}";

echo -e "${CLR_BLUE}## COPY${CLR_DEF}";

# Check file
if [[ "${_newfile}" == '' ]]; then
    echo -e "${CLR_RED}- ERROR : No file specified.${CLR_DEF}";
    return;
fi;

# Keep file part only after vendor
_newfile="${_newfile##*vendor/}";
_basefile="vendor/${_newfile##*vendor/}";

# Check if file exists
if [[ ! -f "${_basefile}" ]]; then
    echo -e "${CLR_RED}- ERROR : Input file do not exists.${CLR_DEF}";
    return;
fi;

# Get theme name
_theme_name='';
_themes=($(ls app/design/frontend/));
_dir='';
for _dir in "${_themes[@]}"; do
    if [[ "${_dir}" == 'Magento' ]];then
        continue;
    fi;
    _theme_name=$(echo "${_dir}" | tr -cd [:alnum:]);
done

# Check if theme exists
if [[ "${_theme_name}" == '' ]]; then
    echo -e "${CLR_RED}- ERROR : No theme found.${CLR_DEF}";
    return;
fi;


# Convert path
## Convert magento/module-test to Magento_test

# Replace /module- by delimiter
MODULE_PATH_PARTS="${_newfile/\/module-/?}";

# Uppercase for string before delimiter
MODULE_PATH_PARTS_before=$(magetools2_uppercase ${MODULE_PATH_PARTS%\?*});

# Uppercase for string after
MODULE_PATH_PARTS_after=$(magetools2_uppercase ${MODULE_PATH_PARTS##*\?});

_newfile="${MODULE_PATH_PARTS_before}_${MODULE_PATH_PARTS_after}";

## Remove vendor and infos
_newfile=${_newfile/view\/frontend\//};

# Add path
_newfile="app/design/frontend/${_theme_name}/default/${_newfile}";

if [[ -f "${_newfile}" ]]; then
    echo -e "${CLR_RED}- ERROR : Template already exists.${CLR_DEF}";
    return;
fi;

# Copy file
magetools2_bury_copy "${_basefile}" "${_newfile}";
echo "Success : ";
echo "from : ${_basefile}";
echo "to : ${_newfile}";
