cat <<EOF | tee
# Application Folders
GEN_SCRIPT_REPLACE_ENV_CONFIG_FILE="\${GEN_SCRIPT_REPLACE_ENV_CONFIG_FILE:-settings.conf}"
GEN_SCRIPT_REPLACE_ENV_CONFIG_DIR="\${GEN_SCRIPT_REPLACE_ENV_CONFIG_DIR:-\$HOME/.config/myscripts/GEN_SCRIPT_REPLACE_FILENAME}"
GEN_SCRIPT_REPLACE_ENV_CONFIG_BACKUP_DIR="\${GEN_SCRIPT_REPLACE_ENV_CONFIG_BACKUP_DIR:-\$HOME/.local/share/myscripts/GEN_SCRIPT_REPLACE_FILENAME/backups}"
GEN_SCRIPT_REPLACE_ENV_LOG_DIR="\${GEN_SCRIPT_REPLACE_ENV_LOG_DIR:-\$HOME/.local/log/GEN_SCRIPT_REPLACE_FILENAME}"
GEN_SCRIPT_REPLACE_ENV_TEMP_DIR="\${GEN_SCRIPT_REPLACE_ENV_TEMP_DIR:-\$HOME/.local/tmp/system_scripts/GEN_SCRIPT_REPLACE_FILENAME}"
GEN_SCRIPT_REPLACE_ENV_CACHE_DIR="\${GEN_SCRIPT_REPLACE_ENV_CACHE_DIR:-\$HOME/.cache/GEN_SCRIPT_REPLACE_FILENAME}"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Color Settings
GEN_SCRIPT_REPLACE_ENV_OUTPUT_COLOR="\${GEN_SCRIPT_REPLACE_ENV_OUTPUT_COLOR:-4}"
GEN_SCRIPT_REPLACE_ENV_OUTPUT_COLOR_2="\${GEN_SCRIPT_REPLACE_ENV_OUTPUT_COLOR:-6}"
GEN_SCRIPT_REPLACE_ENV_OUTPUT_COLOR_GOOD="\${GEN_SCRIPT_REPLACE_ENV_OUTPUT_COLOR_GOOD:-2}"
GEN_SCRIPT_REPLACE_ENV_OUTPUT_COLOR_ERROR="\${GEN_SCRIPT_REPLACE_ENV_OUTPUT_COLOR_ERROR:-1}"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Notification Settings
GEN_SCRIPT_REPLACE_ENV_REMOTE_NOTIFY_ENABLED="\${GEN_SCRIPT_REPLACE_ENV_REMOTE_NOTIFY_ENABLED:-yes}"
GEN_SCRIPT_REPLACE_ENV_REMOTE_NOTIFY_COMMAND="\${GEN_SCRIPT_REPLACE_ENV_REMOTE_NOTIFY_COMMAND:-web-notify telegram}"
# System
GEN_SCRIPT_REPLACE_ENV_SYSTEM_NOTIFY_ENABLED="\${GEN_SCRIPT_REPLACE_ENV_SYSTEM_NOTIFY_ENABLED:-yes}"
GEN_SCRIPT_REPLACE_ENV_GOOD_NAME="\${GEN_SCRIPT_REPLACE_ENV_GOOD_NAME:-Great:}"
GEN_SCRIPT_REPLACE_ENV_ERROR_NAME="\${GEN_SCRIPT_REPLACE_ENV_ERROR_NAME:-Error:}"
GEN_SCRIPT_REPLACE_ENV_GOOD_MESSAGE="\${GEN_SCRIPT_REPLACE_ENV_GOOD_MESSAGE:-No errors reported}"
GEN_SCRIPT_REPLACE_ENV_ERROR_MESSAGE="\${GEN_SCRIPT_REPLACE_ENV_ERROR_MESSAGE:-Error reported}"
GEN_SCRIPT_REPLACE_ENV_NOTIFY_CLIENT_NAME="\${GEN_SCRIPT_REPLACE_ENV_NOTIFY_CLIENT_NAME:-\$APPNAME}"
GEN_SCRIPT_REPLACE_ENV_NOTIFY_CLIENT_ICON="\${NOTIFY_CLIENT_ICON:-\$GEN_SCRIPT_REPLACE_ENV_NOTIFY_CLIENT_ICON}"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Additional Variables

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Generate config files
[ -f "\$GEN_SCRIPT_REPLACE_ENV_CONFIG_DIR/\$GEN_SCRIPT_REPLACE_ENV_CONFIG_FILE" ] || [[ "\$*" = *config ]] || INIT_CONFIG="\${INIT_CONFIG:-TRUE}" __gen_config \${SETARGS:-\$@}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Import config
[ -f "\$GEN_SCRIPT_REPLACE_ENV_CONFIG_DIR/\$GEN_SCRIPT_REPLACE_ENV_CONFIG_FILE" ] && . "\$GEN_SCRIPT_REPLACE_ENV_CONFIG_DIR/\$GEN_SCRIPT_REPLACE_ENV_CONFIG_FILE"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Ensure Directories and files exist
[ -d "\$GEN_SCRIPT_REPLACE_ENV_LOG_DIR" ] || mkdir -p "\$GEN_SCRIPT_REPLACE_ENV_LOG_DIR" &>/dev/null
[ -d "\$GEN_SCRIPT_REPLACE_ENV_TEMP_DIR" ] || mkdir -p "\$GEN_SCRIPT_REPLACE_ENV_TEMP_DIR" &>/dev/null
[ -d "\$GEN_SCRIPT_REPLACE_ENV_CACHE_DIR" ] || mkdir -p "\$GEN_SCRIPT_REPLACE_ENV_CACHE_DIR" &>/dev/null
GEN_SCRIPT_REPLACE_ENV_TEMP_FILE="\${GEN_SCRIPT_REPLACE_ENV_TEMP_FILE:-\$(mktemp \$GEN_SCRIPT_REPLACE_ENV_TEMP_DIR/XXXXXX 2>/dev/null)}"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Setup trap to remove temp file
trap 'exitCode=\${exitCode:-\$?};[ -n "\$GEN_SCRIPT_REPLACE_ENV_TEMP_FILE" ] && [ -f "\$GEN_SCRIPT_REPLACE_ENV_TEMP_FILE" ] && rm -Rf "\$GEN_SCRIPT_REPLACE_ENV_TEMP_FILE" &>/dev/null' EXIT
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
EOF
