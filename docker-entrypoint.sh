#!/bin/sh
set -e

CFG_DIR="/home/pcs/.config/BaiduPCS-Go"

if [ -d "$CFG_DIR" ]; then
  find "$CFG_DIR" -type f -name '*.json' -exec chmod 600 {} \;
fi

if [ $# -eq 0 ]; then
  exec "$@"
fi

case "$1" in
  login|upload|d|run|help|-*)
    exec BaiduPCS-Go "$@"
    ;;
  *)
    exec "$@"
    ;;
esac
