#!/bin/bash

echo '# PULL';
git pull;
git submodule update --init --recursive;

echo '# CLEAN';
rm -rf generated/;
rm -rf var/cache;
rm -rf var/di;
rm -rf var/generated;
rm -rf var/generation;
rm -rf var/page_cache;
rm -rf var/view_preprocessed;
rm -rf pub/static/frontend/*;
rm -rf pub/static/backend/*;

echo '# COMPOSER';
composer install;

echo '# DEVELOPER MODE';
php bin/magento deploy:mode:set developer;

echo '# SETUP UPGRADE';
php bin/magento setup:upgrade;

echo '# REINDEX';
php bin/magento indexer:reindex;

echo '# CACHE CONFIG';
php bin/magento cache:enable;
php bin/magento cache:disable layout;
php bin/magento cache:disable block_html;
php bin/magento cache:disable full_page;

echo '# FRONT-END CONFIG';
php "${_MAGERUN_FILE}" config:store:set dev/js/merge_files 0
php "${_MAGERUN_FILE}" config:store:set dev/js/enable_js_bundling 0
php "${_MAGERUN_FILE}" config:store:set dev/js/minify_files 0
php "${_MAGERUN_FILE}" config:store:set dev/css/merge_css_files 0
php "${_MAGERUN_FILE}" config:store:set dev/css/minify_files 0

echo '# FLUSH CACHE';
php bin/magento cache:flush;
