#!/usr/bin/env bash

set -euxo pipefail

# The v1.2 demo exercises experimental APIs, so the shared library must export them.
cmake -S . -B build -G Ninja ${CMAKE_ARGS} \
    -DCMAKE_BUILD_TYPE=Release \
    -DMESHOPT_BUILD_SHARED_LIBS=ON \
    -DMESHOPT_STABLE_EXPORTS=OFF \
    -DMESHOPT_INSTALL=ON \
    -DMESHOPT_BUILD_DEMO=ON \
    -DMESHOPT_BUILD_GLTFPACK=OFF
cmake --build build --parallel "${CPU_COUNT}"
ctest --test-dir build --output-on-failure
cmake --install build
install -Dm755 build/meshoptdemo "${PREFIX}/bin/meshoptdemo"
