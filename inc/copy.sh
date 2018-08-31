#!/bin/bash

_newfile="${1}";
_basefile="${1}";

# Get theme name
_theme_name='';
_themes=$(ls app/design/frontend/ -I "Magento");
for dir in "${_themes[@]}"; do
    _theme_name="${dir}";
done

if [[ "${_theme_name}" == '' ]]; then
    echo '- ERROR : No theme found.';
    return;
fi;

# Keep only after vendor
_newfile="${_newfile##*vendor/}";
_basefile="vendor/${_newfile##*vendor/}";

# Convert magento/module-test to Magento_Test
echo "${_newfile}" > tmp.txt;
sed -i 's/magento\/module-/Magento_/g' tmp.txt
_newfile=$(cat tmp.txt);
rm tmp.txt;

# Uppercase on the module name
_pathbefore=${_newfile%_*};
_pathafter=${_newfile##*_};
_newfile="${_pathbefore}_${_pathafter^}";

# Remove vendor and infos
_newfile=${_newfile/view\/frontend\//};

# Add path
_newfile="app/design/frontend/${_theme_name}/default/${_newfile}";

if [[ -f "${_newfile}" ]]; then
    echo '- ERROR : Template already exists.';
    return;
fi;

# Copy file
magetools2_bury_copy "${_basefile}" "${_newfile}";
echo "Success : ";
echo "from : ${_basefile}";
echo "to: ${_newfile}";
