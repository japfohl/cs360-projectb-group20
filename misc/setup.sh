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

mysql-ctl start
service apache2 stop
service apache2 start
echo -en "Serving: ${COL_GREEN}https://$C9_HOSTNAME${COL_RESET}\n"

# if [[ started  ]]; then
#     #statements
# fi