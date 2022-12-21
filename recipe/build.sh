#!/bin/bash
set -e -o pipefail

USERNAME=$(id -u -n)
unamestr=`uname`
if [ "$unamestr" != 'Darwin' ]; then
	Xvfb :1 -screen 0 1280x1024x24 -auth localhost &
	export DISPLAY=:1
fi

# This cythonizing can be removed once tvtk/src/array_ext.c is 3.11-compatible
echo "Running cython"
rm tvtk/src/array_ext.c
cython tvtk/src/array_ext.pyx
$PYTHON -m pip install . --no-deps -vv

if [ "$unamestr" != 'Darwin' ]; then
	killall -u $USERNAME Xvfb
fi
