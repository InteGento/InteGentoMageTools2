#!/bin/bash

# Create path and copy : https://stackoverflow.com/a/1534494
magetools2_bury_copy() { mkdir -p `dirname $2` && cp "$1" "$2"; }
