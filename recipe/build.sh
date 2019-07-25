#!/bin/bash

USERNAME=$(id -u -n)
Xvfb :1 -screen 0 1280x1024x24 -auth localhost &
export DISPLAY=:1
$PYTHON -m pip install . --no-deps -vv

unamestr=`uname`
if [ "$unamestr" != 'Darwin' ]; then 
	killall -u $USERNAME Xvfb 
fi
