##################
# Code # Color   #
##################
#  00  # Off     #
#  30  # Black   #
#  31  # Red     #
#  32  # Green   #
#  33  # Yellow  #
#  34  # Blue    #
#  35  # Magenta #
#  36  # Cyan    #
#  37  # White   #
##################

function msg_install { echo -e "\033[1;40m==> $1\033[0m"; }
function msg_install_item { echo -e "\033[1;35m[installing] $1\033[0m"; }
function msg_checking { echo -e "\033[1;32m[checking] $1\033[0m"; }
function msg_update { echo -e "\033[1;34m[updating] $1\033[0m"; }
function msg_ok { echo -e "\033[1;32m[installed] $1\033[0m"; }
function msg_alert { echo -e "\033[1;31m[alert] $1\033[0m"; }
function msg_info { echo -e "\033[1;36m[info] $1\033[0m"; }
function msg_prompt { echo -e "\033[1;37m[prompt] $1\033[0m"; }
function msg_skip { echo -e "\033[1;34m[skipped] $1\033[0m"; }
function msg_config { echo -e "\033[1;33m[configuring] $1\033[0m"; }
function msg { echo -e "\033[0;36m$1\033[0m"; }
