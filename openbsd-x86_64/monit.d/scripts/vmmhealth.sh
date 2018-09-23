#!/bin/sh

VMM_STATUS=$(vmctl status | awk '{if ($2 == "-" && $5 == "-") {print 101}}')

exit $VMM_STATUS
