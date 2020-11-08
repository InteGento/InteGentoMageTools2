#!/bin/bash

###################################
## Extract URL details
###################################

_URL="${1}";
if [[ "${_URL}" == '' ]];then
    echo $(bashutilities_message "No URL available" 'error');
    return 0;
fi;

###################################
## Extract file path
###################################

_BASEURL="${_URL/https:\/\//}";
_BASEURL="${_BASEURL/http:\/\//}";
_DOMAIN="$( cut -d '/' -f 1 <<< "${_BASEURL}" )";
_URI="${_BASEURL/${_DOMAIN}/}";
_FILEPATH="pub${_URI}";

###################################
## Download image
###################################

curl "${_URL}" --create-dirs -o "${_FILEPATH}";


