#!/bin/sh

CURRENT_DIR=`dirname "$0"`
SCRIPT_NAME=`basename "$0"`

. $CURRENT_DIR/../common/libarch.sh
. $CURRENT_DIR/../common/libcomm.sh

echo "Recover packages..."
echo "Working dir is $CURRENT_DIR"
cd $CURRENT_DIR
recover_packages

echo "Configuring basic system setting..."
set_locale
set_timezone
set_hostname
