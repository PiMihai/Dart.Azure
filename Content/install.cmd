@ECHO OFF

SET DART_SDK="%HOME%\dart-sdk"
SET DART_SDK_TEMP="D:\local\dart-sdk"

REM cleanup old version
IF EXIST %DART_SDK% (
	RMDIR %DART_SDK% /S /Q
)

IF EXIST %DART_SDK_TEMP% (
	RMDIR %DART_SDK_TEMP% /S /Q
)

REM get latest Dart version
ECHO Downloading Dart SDK...
CALL curl -k -o .\dart.zip https://storage.googleapis.com/dart-archive/channels/stable/release/1.19.0/sdk/dartsdk-windows-ia32-release.zip

REM unzip it
ECHO Unzipping Dart SDK...
CALL unzip -o .\dart.zip -d %HOME%\

REM inject the deployment task and web.config
ECHO Configuring extension...
SET DEPLOY_ACTION_LOCATION=%HOME%\site\deployments\tools
MD %DEPLOY_ACTION_LOCATION% 2>nul
MOVE .\deploy.cmd %DEPLOY_ACTION_LOCATION%\deploy.cmd
MOVE .\applicationHost.xdt %HOME%\site\applicationHost.xdt
MOVE .\web.config %HOME%\site\wwwroot\web.config

REM clean up
DEL .\dart.zip