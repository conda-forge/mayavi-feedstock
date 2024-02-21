#!/bin/bash
set -e -o pipefail

USERNAME=$(id -u -n)
unamestr=`uname`
if [ "$unamestr" != 'Darwin' ]; then
	Xvfb :1 -screen 0 1280x1024x24 -auth localhost &
	export DISPLAY=:1
fi

$PYTHON -c "import numpy; print(numpy.__version__)"
$PYTHON -um pip install . --no-deps -vv

if [ "$unamestr" != 'Darwin' ]; then
	killall -u $USERNAME Xvfb
fi
