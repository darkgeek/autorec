#!/bin/sh
su justin -c 'vncserver :2'

while [[ true ]]; do
    sleep 3600
done
