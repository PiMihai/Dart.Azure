SET DART_SDK_TEMP=D:\local\dart-sdk

IF EXIST %DART_SDK_TEMP% (
    RMDIR %DART_SDK_TEMP% /S /Q
)

MD %DART_SDK_TEMP% 2>nul
XCOPY %HOME%\dart-sdk\*.* %DART_SDK_TEMP%\ /s /e /f

IF NOT DEFINED DART_SERVER_PROJECT_PATH (
    ECHO DART_SERVER_PROJECT_PATH not defined, skipping server deployment.
) ELSE (
    ECHO Deploying server project...
    CD %DEPLOYMENT_SOURCE%\%DART_SERVER_PROJECT_PATH%
    CALL %DART_SDK_TEMP%\bin\pub get --no-packages-dir
    XCOPY .\*.* %WEBROOT_PATH%\server\ /s /e /f
    ECHO Server deployment completed successfully.
)

IF NOT DEFINED DART_CLIENT_PROJECT_PATH (
    ECHO DART_CLIENT_PROJECT_PATH not defined, skipping client deployment.
) ELSE (
    ECHO Deploying client project...
    cd %DEPLOYMENT_SOURCE%\%DART_CLIENT_PROJECT_PATH%
    CALL %DART_SDK_TEMP%\bin\pub get --no-packages-dir
    CALL %DART_SDK_TEMP%\bin\pub build
    XCOPY .\build\web\*.* %WEBROOT_PATH%\client\ /s /e /f
    ECHO Client deployment completed successfully!
)

ECHO Dart.Azure deployment task finished successfully.