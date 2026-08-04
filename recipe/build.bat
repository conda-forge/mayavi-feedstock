%PYTHON% -c "import vtk; print('generating against VTK', vtk.vtkVersion().GetVTKVersion())"
if errorlevel 1 exit 1

:: --no-build-isolation: see the comment in build.sh
%PYTHON% -um pip install . --no-deps --no-build-isolation -vv
if errorlevel 1 exit 1
