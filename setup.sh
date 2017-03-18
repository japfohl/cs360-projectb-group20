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
DB_PATH="$GOPATH/sql/"

# start database and fill with data
mysql-ctl start
sudo mysql c9 -N -e "source ${DB_PATH}CreateDB.sql;"
sudo mysql c9 -N -e "source ${DB_PATH}LoadDB.sql;"

# start web server
service apache2 stop # not necessary but why not
service apache2 start

# check that apache2 is up
started=$(service apache2 status)
started=$(tr -cd '[:print:]' <<< $started)

if [ "$started" != "* apache2 is running"  ]; then
    echo -en "${COL_RED}There was a problem starting Apache. Please press 'Run Project'${COL_RESET}\n"
fi

# check that page is live
wget -q --spider "${URL}"

if [ $? -eq 0 ]; then
    echo -en "Serving: ${COL_GREEN}${URL}${COL_RESET}\n"
else
    echo -en "${COL_RED}There was a problem serving ${URL}. Please press 'Run Project'${COL_RESET}\n"
fi