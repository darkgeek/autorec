#!/data/data/com.termux/files/usr/bin/bash

CURRENT_DIR=`dirname "$0"`
SCRIPT_NAME=`basename "$0"`

. $CURRENT_DIR/../common/libdeb.sh
. $CURRENT_DIR/../common/libcomm.sh

echo "Working dir is $CURRENT_DIR"

cd $CURRENT_DIR
backup_package_list
cp $HOME/bin/rc .
cp $HOME/bin/termux-file-editor .
cp $HOME/bin/termux-url-opener .
cp $HOME/bin/bad-apps-detect-wrapper.sh .
cp $HOME/bin/bad-apps-detect.sh .
cp $HOME/.mpdconf .
