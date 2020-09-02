#!/bin/bash

# Purge Cache
echo '# Flushing cache';
php bin/magento cache:flush;

# Cache Warming
echo '# Cache Warming';
wget -O/dev/null -q $(php bin/magento config:show web/secure/base_url);

echo '# Cache flushed !';
