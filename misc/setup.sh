#!/bin/bash

# Colors
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m" # reset color
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"

URL="https://$C9_HOSTNAME"

mysql-ctl start
service apache2 stop
service apache2 start

started=$(service apache2 status)
started=$(tr -cd '[:print:]' <<< $started)

if [ "$started" != "* apache2 is running"  ]; then
    echo -en "${COL_RED}There was a problem starting Apache. Please press 'Run Project'${COL_RESET}\n"
fi

wget -q --spider "${URL}"

if [ $? -eq 0 ]; then
    echo -en "Serving: ${COL_GREEN}${URL}${COL_RESET}\n"
else
    echo -en "${COL_RED}There was a problem serving ${URL}. Please press 'Run Project'${COL_RESET}\n"
fi