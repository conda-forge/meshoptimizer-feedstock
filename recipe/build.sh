#!/usr/bin/env bash

set -euxo pipefail

cmake -S . -B build-shared -G Ninja ${CMAKE_ARGS} \
    -DCMAKE_BUILD_TYPE=Release \
    -DMESHOPT_BUILD_SHARED_LIBS=ON \
    -DMESHOPT_STABLE_EXPORTS=ON \
    -DMESHOPT_INSTALL=ON \
    -DMESHOPT_BUILD_DEMO=OFF \
    -DMESHOPT_BUILD_GLTFPACK=OFF
cmake --build build-shared --parallel "${CPU_COUNT}"
cmake --install build-shared

# Build the demo against a static library because v1.2's demo exercises
# experimental APIs that are intentionally hidden from the shared library.
cmake -S . -B build-demo -G Ninja ${CMAKE_ARGS} \
    -DCMAKE_BUILD_TYPE=Release \
    -DMESHOPT_BUILD_SHARED_LIBS=OFF \
    -DMESHOPT_INSTALL=OFF \
    -DMESHOPT_BUILD_DEMO=ON \
    -DMESHOPT_BUILD_GLTFPACK=OFF
cmake --build build-demo --target demo --parallel "${CPU_COUNT}"
install -Dm755 build-demo/meshoptdemo "${PREFIX}/bin/meshoptdemo"
