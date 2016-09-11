@echo off

set %DART_SDK_TEMP%=D:\local\dart-sdk

set %DART_SERVER_PATH%=%DEPLOYMENT_TARGET%\server
set %DART_CLIENT_PATH%=%DEPLOYMENT_TARGET%\client

if EXIST %DART_SDK_TEMP% (
    rmdir %DART_SDK_TEMP% /S /Q
)

md %DART_SDK_TEMP% 2>nul
xcopy %HOME%\dart-sdk\*.* %DART_SDK_TEMP%\ /s /e /f

IF NOT %DART_SERVER_PROJECT_PATH% == [] (
    echo DART_SERVER_PROJECT_PATH not defined, skipping server deployment.
) else (
    echo Deploying server project...
    cd %DEPLOYMENT_SOURCE%\%DART_SERVER_PROJECT_PATH%
    %DART_SDK_TEMP%\bin\pub get --no-packages-dir
    xcopy .\*.* %DART_SERVER_PATH% /s /e /f
    echo Server deployment completed successfully!
)

IF %DART_CLIENT_PROJECT_PATH% == [] {
    echo DART_CLIENT_PROJECT_PATH not defined, skipping client deployment.
} else (
    echo Deploying client project...
    cd %DEPLOYMENT_SOURCE%\%DART_CLIENT_PROJECT_PATH%
    %DART_SDK_TEMP%\bin\pub get --no-packages-dir
    %DART_SDK_TEMP%\bin\pub build
    xcopy .\build\*.* %DART_CLIENT_PATH% /s /e /f
    echo Client deployment completed successfully!
)

echo Dart.Azure deployment task finished successfully!