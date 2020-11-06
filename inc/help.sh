#!/bin/bash

echo -e "${CLR_YELLOW}## HELP${CLR_DEF}";
echo -e "${CLR_YELLOW}### COPY a template file to the current theme${CLR_DEF}";
echo 'magetools copy [...]/htdocs/vendor/aheadworks/module-giftcard/view/frontend/email/default.html'

echo -e "${CLR_YELLOW}### Clean cache${CLR_DEF}";
echo 'magetools cache'

echo -e "${CLR_YELLOW}### Generate an env file${CLR_DEF}";
echo 'magetools env'
