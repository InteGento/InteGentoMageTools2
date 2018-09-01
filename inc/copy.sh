#!/bin/bash

_newfile="${1}";
_basefile="${1}";

# Check file
if [[ "${_newfile}" == '' ]]; then
    echo "${CLR_RED}- ERROR : No file specified.${CLR_DEF}";
    return;
fi;

# Keep file part only after vendor
_newfile="${_newfile##*vendor/}";
_basefile="vendor/${_newfile##*vendor/}";

# Check if file exists
if [[ ! -f "${_basefile}" ]]; then
    echo "${CLR_RED}- ERROR : Input file do not exists.${CLR_DEF}";
    return;
fi;

# Get theme name
_theme_name='';
_themes=$(ls app/design/frontend/);
for dir in "${_themes[@]}"; do
    if [[ "${dir}" == 'Magento' ]];then
        continue;
    fi;
    _theme_name="${dir}";
done

# Check if theme exists
if [[ "${_theme_name}" == '' ]]; then
    echo "${CLR_RED}- ERROR : No theme found.${CLR_DEF}";
    return;
fi;


# Convert path
## Convert magento/module-test to Magento_test
_newfile=$(magetools2_sed 's/magento\/module-/Magento_/g' "${_newfile}");

## Convert Magento_test to Magento_Test
_pathbefore=${_newfile%_*};
_pathafter=${_newfile##*_};
_newfile="${_pathbefore}_${_pathafter^}";

## Remove vendor and infos
_newfile=${_newfile/view\/frontend\//};

# Add path
_newfile="app/design/frontend/${_theme_name}/default/${_newfile}";

if [[ -f "${_newfile}" ]]; then
    echo "${CLR_RED}- ERROR : Template already exists.${CLR_DEF}";
    return;
fi;

# Copy file
magetools2_bury_copy "${_basefile}" "${_newfile}";
echo "Success : ";
echo "from : ${_basefile}";
echo "to: ${_newfile}";
