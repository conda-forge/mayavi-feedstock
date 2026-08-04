#!/bin/bash
set -e -o pipefail

# No Xvfb here on purpose.  Generating tvtk_classes.zip introspects VTK's
# classes but never opens a window, and upstream builds its wheels with no
# display at all (the build job in mayavi's wheel.yml).  The old hardcoded
# "Xvfb :1" was also a trap: on any machine where display 1 is taken it dies
# with "Server is already active for display 1", leaving DISPLAY pointing at a
# server we do not own, and the build hangs instead of failing.  The tests
# below do need one, and use xvfb-run.

$PYTHON -c "import numpy; print('numpy', numpy.__version__)"
$PYTHON -c "import vtk; print('generating against VTK', vtk.vtkVersion().GetVTKVersion())"

# --no-build-isolation is what keeps that promise: mayavi's build-system
# .requires names "vtk>=9.4", so an isolated build would download a VTK wheel
# from PyPI and generate the classes against that instead of the vtk-base in
# host.  Everything it needs is in host requirements for exactly this reason.
$PYTHON -um pip install . --no-deps --no-build-isolation -vv
