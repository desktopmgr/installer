#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202207042242-git
# @Author            :  Jason Hempstead
# @Contact           :  jason@casjaysdev.com
# @License           :  WTFPL
# @ReadME            :  ix.io --help
# @Copyright         :  Copyright: (c) 2021 Jason Hempstead, Casjays Developments
# @Created           :  Thursday, Aug 19, 2021 01:17 EDT
# @File              :  ix.io
# @Description       :
# @TODO              :
# @Other             :
# @Resource          :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
APPNAME="$(basename "$0" 2>/dev/null)"
VERSION="202108190117-git"
HOME="${USER_HOME:-$HOME}"
USER="${SUDO_USER:-$USER}"
RUN_USER="${SUDO_USER:-$USER}"
SRC_DIR="${BASH_SOURCE%/*}"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set bash options
if [[ "$1" == "--debug" ]]; then shift 1 && set -xo pipefail && export SCRIPT_OPTS="--debug" && export _DEBUG="on"; fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Import functions
CASJAYSDEVDIR="${CASJAYSDEVDIR:-/usr/local/share/CasjaysDev/scripts}"
SCRIPTSFUNCTDIR="${CASJAYSDEVDIR:-/usr/local/share/CasjaysDev/scripts}/functions"
SCRIPTSFUNCTFILE="${SCRIPTSAPPFUNCTFILE:-testing.bash}"
SCRIPTSFUNCTURL="${SCRIPTSAPPFUNCTURL:-https://github.com/dfmgr/installer/raw/main/functions}"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
if [ -f "$PWD/$SCRIPTSFUNCTFILE" ]; then
  . "$PWD/$SCRIPTSFUNCTFILE"
elif [ -f "$SCRIPTSFUNCTDIR/$SCRIPTSFUNCTFILE" ]; then
  . "$SCRIPTSFUNCTDIR/$SCRIPTSFUNCTFILE"
else
  echo "Can not load the functions file: $SCRIPTSFUNCTDIR/$SCRIPTSFUNCTFILE" 1>&2
  exit 90
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# user system devenv dfmgr dockermgr fontmgr iconmgr pkmgr systemmgr thememgr wallpapermgr
user_install && __options "$@"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set functions
__list_options() { printf_custom "$1" "$2: $(echo ${3:-$ARRAY} | __sed 's|:||g;s|'$4'| '$5'|g')" 2>/dev/null; }
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
__gen_config() {
  [[ "$INIT_CONFIG" = "TRUE" ]] || printf_green "Generating the config file in"
  [[ "$INIT_CONFIG" = "TRUE" ]] || printf_green "$IX_IO_CONFIG_DIR/$IX_IO_CONFIG_FILE"
  [ -d "$IX_IO_CONFIG_DIR" ] || mkdir -p "$IX_IO_CONFIG_DIR"
  [ -d "$IX_IO_CONFIG_BACKUP_DIR" ] || mkdir -p "$IX_IO_CONFIG_BACKUP_DIR"
  [ -f "$IX_IO_CONFIG_DIR/$IX_IO_CONFIG_FILE" ] &&
    cp -Rf "$IX_IO_CONFIG_DIR/$IX_IO_CONFIG_FILE" "$IX_IO_CONFIG_BACKUP_DIR/$IX_IO_CONFIG_FILE.$$"
  cat <<EOF >"$IX_IO_CONFIG_DIR/$IX_IO_CONFIG_FILE"
# Settings for ix.io
IX_IO_SERVER_HOST="${IX_IO_SERVER_HOST:-http://ix.io}"

# Notification settings
IX_IO_GOOD_MESSAGE="${IX_IO_GOOD_MESSAGE:-Everything Went OK}"
IX_IO_ERROR_MESSAGE="${IX_IO_ERROR_MESSAGE:-Well something seems to have gone wrong}"
IX_IO_NOTIFY_ENABLED="${IX_IO_NOTIFY_ENABLED:-yes}"
IX_IO_NOTIFY_CLIENT_NAME="${NOTIFY_CLIENT_NAME:-$APPNAME}"
IX_IO_NOTIFY_CLIENT_ICON="${NOTIFY_CLIENT_ICON:-$IX_IO_NOTIFY_CLIENT_ICON}"

# Colorization settings
IX_IO_OUTPUT_COLOR="${IX_IO_OUTPUT_COLOR:-5}"
IX_IO_OUTPUT_COLOR_GOOD="${IX_IO_OUTPUT_COLOR_GOOD:-2}"
IX_IO_OUTPUT_COLOR_ERROR="${IX_IO_OUTPUT_COLOR_ERROR:-1}"

EOF
  if [ -f "$IX_IO_CONFIG_DIR/$IX_IO_CONFIG_FILE" ]; then
    [[ "$INIT_CONFIG" = "TRUE" ]] || printf_green "Your config file for $APPNAME has been created"
    exitCode=0
  else
    printf_red "Failed to create the config file"
    exitCode=1
  fi
  return ${exitCode:-$?}
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Additional functions

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Default variables
exitCode="0"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Application Folders
IX_IO_LOG_DIR="${IX_IO_LOG_DIR:-$HOME/.local/log/ix.io}"
IX_IO_CACHE_DIR="${IX_IO_CACHE_DIR:-$HOME/.cache/ix.io}"
IX_IO_CONFIG_DIR="${IX_IO_CONFIG_DIR:-$HOME/.config/myscripts/ix.io}"
IX_IO_CONFIG_BACKUP_DIR="${IX_IO_CONFIG_BACKUP_DIR:-$HOME/.local/share/myscripts/ix.io/backups}"
IX_IO_TEMP_DIR="${IX_IO_TEMP_DIR:-$HOME/.local/tmp/system_scripts/ix.io}"
IX_IO_OPTIONS_DIR="${IX_IO_OPTIONS_DIR:-$HOME/.local/share/myscripts/ix.io/options}"
IX_IO_CONFIG_FILE="${IX_IO_CONFIG_FILE:-settings.conf}"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Color Settings
IX_IO_OUTPUT_COLOR="${IX_IO_OUTPUT_COLOR:-4}"
IX_IO_OUTPUT_COLOR_2="${IX_IO_OUTPUT_COLOR:-6}"
IX_IO_OUTPUT_COLOR_GOOD="${IX_IO_OUTPUT_COLOR_GOOD:-2}"
IX_IO_OUTPUT_COLOR_ERROR="${IX_IO_OUTPUT_COLOR_ERROR:-1}"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Notification Settings
IX_IO_GOOD_MESSAGE="${IX_IO_GOOD_MESSAGE:-Everything Went OK}"
IX_IO_ERROR_MESSAGE="${IX_IO_ERROR_MESSAGE:-Well something seems to have gone wrong}"
IX_IO_NOTIFY_ENABLED="${IX_IO_NOTIFY_ENABLED:-yes}"
IX_IO_NOTIFY_CLIENT_NAME="${NOTIFY_CLIENT_NAME:-$APPNAME}"
IX_IO_NOTIFY_CLIENT_ICON="${NOTIFY_CLIENT_ICON:-$IX_IO_NOTIFY_CLIENT_ICON}"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Additional Variables
IX_IO_SERVER_HOST="${IX_IO_SERVER_HOST:-http://ix.io}"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Generate non-existing config files
[ -f "$IX_IO_CONFIG_DIR/$IX_IO_CONFIG_FILE" ] || [[ "$*" = *config ]] || INIT_CONFIG="${INIT_CONFIG:-TRUE}" __gen_config ${SETARGS:-$@}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Import config
[ -f "$IX_IO_CONFIG_DIR/$IX_IO_CONFIG_FILE" ] && . "$IX_IO_CONFIG_DIR/$IX_IO_CONFIG_FILE"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Ensure Directories and files exist
[ -d "$IX_IO_LOG_DIR" ] || mkdir -p "$IX_IO_LOG_DIR" &>/dev/null
[ -d "$IX_IO_TEMP_DIR" ] || mkdir -p "$IX_IO_TEMP_DIR" &>/dev/null
[ -d "$IX_IO_CACHE_DIR" ] || mkdir -p "$IX_IO_CACHE_DIR" &>/dev/null
IX_IO_TEMP_FILE="${IX_IO_TEMP_FILE:-$(mktemp $IX_IO_TEMP_DIR/XXXXXX 2>/dev/null)}"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Setup trap to remove temp file
trap 'exitCode=${exitCode:-$?};[ -n "$IX_IO_TEMP_FILE" ] && [ -f "$IX_IO_TEMP_FILE" ] && rm -Rf "$IX_IO_TEMP_FILE" &>/dev/null' EXIT
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Setup notification function
if [ "$IX_IO_NOTIFY_ENABLED" = "yes" ]; then
  __notifications() {
    export NOTIFY_GOOD_MESSAGE="${IX_IO_GOOD_MESSAGE}"
    export NOTIFY_ERROR_MESSAGE="${IX_IO_ERROR_MESSAGE}"
    export NOTIFY_CLIENT_NAME="${IX_IO_NOTIFY_CLIENT_NAME}"
    export NOTIFY_CLIENT_ICON="${IX_IO_NOTIFY_CLIENT_ICON}"
    notifications "$@" || return 1
  }
else
  __notifications() { false; }
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Show warn message if variables are missing

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set additional variables/Argument/Option settings
SETARGS="$*"
SHORTOPTS="d:,i:,n:"
LONGOPTS="options,config,version,help,dir:"
ARRAY=""
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
setopts=$(getopt -o "$SHORTOPTS" --long "$LONGOPTS" -a -n "$(basename "$0" 2>/dev/null)" -- "$@" 2>/dev/null)
eval set -- "${setopts[@]}" 2>/dev/null
while :; do
  case $1 in
  --options)
    shift 1
    [ -n "$1" ] || printf_blue "Current options for ${PROG:-$APPNAME}"
    [ -z "$SHORTOPTS" ] || __list_options "5" "Short Options" "-$SHORTOPTS" ',' '-'
    [ -z "$LONGOPTS" ] || __list_options "5" "Long Options" "--$LONGOPTS" ',' '--'
    [ -z "$ARRAY" ] || __list_options "5" "Base Options" "$ARRAY" ',' ''
    exit $?
    ;;
  --version)
    shift 1
    __version
    exit $?
    ;;
  --help)
    shift 1
    __help
    exit $?
    ;;
  --config)
    shift 1
    __gen_config
    exit $?
    ;;
  --dir)
    IX_IO_CWD="$2"
    shift 2
    ;;
  -d)
    IX_IO_SERVER_HOST="http://ix.io/$2"
    shift 2
    ;;

  -i)
    opts="$opts -X PUT"
    IX_IO_SERVER_HOST="http://ix.io/$2"
    shift 2
    ;;

  -n)
    opts="$opts -F read:1=$2"
    shift 2
    ;;
  --)
    shift 1
    break
    ;;
  esac
done
#set -- "$SETARGS"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Actions based on env

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Check for required applications/Network check
cmd_exists --error --ask bash || exit 1 # exit 1 if not found
#am_i_online --error || exit 1     # exit 1 if no internet
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# APP Variables overrides

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# begin main app
case "$1" in
last)
  shift 1
  lynx "$IX_IO_SERVER_HOST/user/"
  ;;

user)
  shift 1
  lynx "$IX_IO_SERVER_HOST/user/$1/"
  ;;

id)
  shift 1
  lynx "$IX_IO_SERVER_HOST/$1+"
  ;;

raw)
  shift 1
  lynx "$IX_IO_SERVER_HOST/$1"
  ;;

*)
  if [ ${#} -eq 0 ]; then
    if [ -p "/dev/stdin" ]; then
      file="$(</dev/stdin)"
    fi
  else
    file="$(<"$@")"
  fi
  if [ -f "$file" ]; then
    post="$(curl -q -LSs -F 'f:1=<-' $IX_IO_SERVER_HOST <"$file" 2>/dev/null)"
    echo "$post" | printf_readline $IX_IO_OUTPUT_COLOR
  elif [[ -n "$file" ]]; then
    post="$(echo "$file" | curl -q -LSs -F 'f:1=<-' $IX_IO_SERVER_HOST 2>/dev/null)"
    echo "$post" | printf_readline $IX_IO_OUTPUT_COLOR
  else
    printf_red "Something went wrong. No input received"
  fi
  ;;
esac
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# End application
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# lets exit with code
exit ${exitCode:-$?}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# end
