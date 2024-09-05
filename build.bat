
@echo off

::first parameter must be either 'y' (yes) or 'n' (no)
::this either bypasses or doesn't bypass the final check
::at the end of this script to wait for user input before exiting

::if first parameter is empty
if "%~1" == "" (
    echo ---- No bypass parameter provided! You must either set first parameter as 'y' or 'n'.
    exit /b 1
)

::if first parameter is not a valid input
if not "%~1" == "y" if not "%~1" == "n" (
    echo ---- Parameter 1 '%~1' is not a valid bypass state! Either pick 'y' or 'n'. Defaulting to 'n'.
    exit /b 1
) else (
    echo ---- Chosen bypass state is '%~1'.
    set "bypassState=%~1"
)

::second parameter must be either Debug or Release
::if left empty or if invalid variable is chosen then Debug is chosen
::this sets the build type for the executable

::if second parameter is empty
if "%~2" == "" (
    echo ---- No build type provided. Defaulting to 'Debug'.
    set "buildType=Debug"
) else if "%~2" == "Debug" (
    echo ---- Chosen build type is 'Debug'.
    set "buildType=Debug"
) else if "%~2" == "Release" (
    echo ---- Chosen build type is 'Release'.
    set "buildType=Release"
) else (
    echo ---- Parameter 2 '%~2' is not a valid build type! Either pick 'Debug' or 'Release'.
    exit /b 1
)

::configure exe
echo ---- Started CMake configuration...
cmake -S . -B build -DCMAKE_BUILD_TYPE=%buildType%
if errorlevel 1 (
    echo ---- CMake configuration failed.
    exit /b 1
)

::build exe
echo ---- Started CMake build
cmake --build build
if errorlevel 1 (
    echo ---- CMake build failed.
    exit /b 1
)

::final check to wait for user input
::before closing batch file if first parameter was 'y'
if "%bypassState%" == "y" (
    pause
)