#!/bin/bash

USERNAME=$(id -u -n)
Xvfb :1 -screen 0 1280x1024x24 -auth localhost &
export DISPLAY=:1
# This rm line can be removed once array_ext.c is 3.11-compatible
rm tvtk/src/array_ext.c
cython tvtk/src/array_ext.pyx
$PYTHON -m pip install . --no-deps -vv

unamestr=`uname`
if [ "$unamestr" != 'Darwin' ]; then
	killall -u $USERNAME Xvfb
fi
