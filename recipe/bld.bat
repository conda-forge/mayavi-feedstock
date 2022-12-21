echo Running cython
del tvtk\src\array_ext.c
cython -3 tvtk\src\array_ext.pyx
%PYTHON% -m pip install . --no-deps -vv
if errorlevel 1 exit 1
