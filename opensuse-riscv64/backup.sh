#!/bin/bash

CURRENT_DIR=`dirname "$0"`
SCRIPT_NAME=`basename "$0"`

. $CURRENT_DIR/../common/libcomm.sh

echo "Working dir is $CURRENT_DIR"

cd $CURRENT_DIR
cp /etc/systemd/system/tmux@.service . 
