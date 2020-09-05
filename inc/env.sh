#!/bin/bash

_env_file='app/etc/env.php';

# Test file
if [[ -f "${env}" ]];then
    echo '# Env file already exists.';
    return 0;
fi;

# Try to find project name
_parentdir="$(cd .. && pwd | rev | cut -f1 -d'/' - | rev)";
_parentdir="${_parentdir//[0-9]/}"
_parentdir="${_parentdir/-/}"

# Vars
_project_name=$(bashutilities_get_user_var "- What is the project name?" "${_parentdir}");
_project_random_key=$(bashutilities_rand_string 32);

# Copy file
cp "${TOOLSDIR}env.php" "${_env_file}";

# Replace vars
bashutilities_sed "s/project_name/${_project_name}/g" "${_env_file}";
bashutilities_sed "s/project_random_key/${_project_random_key}/g" "${_env_file}";

echo '# Env file generated !';
