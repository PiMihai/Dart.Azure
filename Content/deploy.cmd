REM ========== SETUP ==========

@echo off

REM check if sdk is on the fast drive - if not, copy it
IF NOT EXIST %DART_SDK_TEMP% (
    MD %DART_SDK_TEMP% 2>nul
    XCOPY %HOME%\dart-sdk\*.* %DART_SDK_TEMP%\ /s /e /f
)

REM ========== SERVER ==========

REM check if a custom server source path is set, or if the default one exists
SET SERVER_SOURCE="%DEPLOYMENT_SOURCE%\%DART_SERVER_SOURCE_PATH%"

IF NOT EXIST %SERVER_SOURCE% (
    ECHO Server source not found - looked in %SERVER_SOURCE%
    ECHO You can define the DART_SERVER_SOURCE_PATH variable and point it
    ECHO to a custom location relative to your repository.
    ECHO Skipping server deployment.

    SET SERVER_SOURCE=
)

REM if we have found a server to deploy
IF DEFINED SERVER_SOURCE (
    ECHO Deploying server project...
    CD %SERVER_SOURCE%

    REM restore packages
    CALL %DART_SDK_TEMP%\bin\pub get --no-packages-dir

    REM deploy server to DART_APP
    IF EXIST %DART_APP% (
        RMDIR %DART_APP% /S /Q
    )
    MD %DART_APP% 2>nul
    XCOPY %DEPLOYMENT_SOURCE%\*.* %DART_APP%\ /S /E /F
)

REM ========== CLIENT ==========

REM check if a custom client source path is set, or if the default one exists
SET CLIENT_SOURCE="%DEPLOYMENT_SOURCE%\%DART_CLIENT_SOURCE_PATH%"

IF NOT EXIST %CLIENT_SOURCE% (
    ECHO Client source not found - looked in %CLIENT_SOURCE%
    ECHO You can define the DART_CLIENT_SOURCE_PATH variable and point it
    ECHO to a custom location relative to your repository.
    ECHO skipping client deployment.

    SET CLIENT_SOURCE=
)

REM if we have found a client to deploy
IF DEFINED CLIENT_SOURCE (
    ECHO Deploying client project...
    CD %CLIENT_SOURCE%

    REM restore packages
    CALL %DART_SDK_TEMP%\bin\pub get --no-packages-dir

    REM compile client into JS
    CALL %DART_SDK_TEMP%\bin\pub build

    REM deploy client to wwwroot
    MOVE %WEBROOT_PATH%\web.config %DEPLOYMENT_TEMP%\web.config
    RMDIR %WEBROOT_PATH% /S /Q
    MD %WEBROOT_PATH% 2>nul
    MOVE %DEPLOYMENT_TEMP%\web.config %WEBROOT_PATH%\web.config
    XCOPY %CLIENT_SOURCE%\build\web\*.* %WEBROOT_PATH%\ /S /E /F
)

echo Dart deployment finished.