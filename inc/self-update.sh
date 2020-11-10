#!/bin/bash

# Go to plugin install dir
cd "${SOURCEDIR}";

# Purge Cache
echo '# Pull latest version';
git pull;
git submodule update --init --recursive;

echo '# Update dependencies';
rm -rf "${_MAGERUN_FILE}";
rm -rf "${_COMPOSER_FILE}";
magetools2_check_dependencies;

# Back to current dir
cd "${_CURRENT_DIR}";
