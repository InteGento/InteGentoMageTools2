#!/bin/bash

echo '# PULL';
git pull --recurse-submodules;

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
php -d memory_limit=-1 "${_COMPOSER_FILE}" install;

echo '# DEVELOPER MODE';
php -d memory_limit=-1 bin/magento deploy:mode:set developer;

echo '# SETUP UPGRADE';
php -d memory_limit=-1 bin/magento setup:upgrade;

echo '# REINDEX';
if [[ -z "${_INTEGENTO_NO_REINDEX}" ]];then
    php -d memory_limit=-1 bin/magento indexer:reindex;
fi;

echo '# CACHE CONFIG';
php -d memory_limit=-1 bin/magento cache:enable;
php -d memory_limit=-1 bin/magento cache:disable layout block_html full_page;

echo '# FRONT-END CONFIG';
php -d memory_limit=-1 "${_MAGERUN_FILE}" config:store:set dev/js/merge_files 0
php -d memory_limit=-1 "${_MAGERUN_FILE}" config:store:set dev/js/enable_js_bundling 0
php -d memory_limit=-1 "${_MAGERUN_FILE}" config:store:set dev/js/minify_files 0
php -d memory_limit=-1 "${_MAGERUN_FILE}" config:store:set dev/css/merge_css_files 0
php -d memory_limit=-1 "${_MAGERUN_FILE}" config:store:set dev/css/minify_files 0

echo '# FLUSH CACHE';
php -d memory_limit=-1 bin/magento cache:flush;
