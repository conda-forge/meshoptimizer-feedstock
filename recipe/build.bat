@echo on

rem The v1.2 demo exercises experimental APIs, so the shared library must export them.
cmake -S . -B build -G Ninja %CMAKE_ARGS% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DMESHOPT_BUILD_SHARED_LIBS=ON ^
    -DMESHOPT_STABLE_EXPORTS=OFF ^
    -DMESHOPT_INSTALL=ON ^
    -DMESHOPT_BUILD_DEMO=ON ^
    -DMESHOPT_BUILD_GLTFPACK=OFF
if errorlevel 1 exit 1

cmake --build build --parallel %CPU_COUNT%
if errorlevel 1 exit 1

ctest --test-dir build --output-on-failure
if errorlevel 1 exit 1

cmake --install build
if errorlevel 1 exit 1

if not exist "%LIBRARY_BIN%" mkdir "%LIBRARY_BIN%"
copy /Y build\meshoptdemo.exe "%LIBRARY_BIN%\meshoptdemo.exe"
if errorlevel 1 exit 1
