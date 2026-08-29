@echo on

cmake -S . -B build-shared -G Ninja %CMAKE_ARGS% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DMESHOPT_BUILD_SHARED_LIBS=ON ^
    -DMESHOPT_STABLE_EXPORTS=ON ^
    -DMESHOPT_INSTALL=ON ^
    -DMESHOPT_BUILD_DEMO=OFF ^
    -DMESHOPT_BUILD_GLTFPACK=OFF
if errorlevel 1 exit 1

cmake --build build-shared --parallel %CPU_COUNT%
if errorlevel 1 exit 1

cmake --install build-shared
if errorlevel 1 exit 1

rem Build the demo against a static library because v1.2's demo exercises
rem experimental APIs that are intentionally hidden from the shared library.
cmake -S . -B build-demo -G Ninja %CMAKE_ARGS% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DMESHOPT_BUILD_SHARED_LIBS=OFF ^
    -DMESHOPT_INSTALL=OFF ^
    -DMESHOPT_BUILD_DEMO=ON ^
    -DMESHOPT_BUILD_GLTFPACK=OFF
if errorlevel 1 exit 1

cmake --build build-demo --target demo --parallel %CPU_COUNT%
if errorlevel 1 exit 1

if not exist "%LIBRARY_BIN%" mkdir "%LIBRARY_BIN%"
copy /Y build-demo\meshoptdemo.exe "%LIBRARY_BIN%\meshoptdemo.exe"
if errorlevel 1 exit 1
