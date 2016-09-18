@ECHO OFF

IF EXIST %HOME%\dart-sdk (
	RMDIR %HOME%\dart-sdk /S /Q
)

ECHO Downloading Dart SDK...
CALL curl -k -o .\dart.zip https://storage.googleapis.com/dart-archive/channels/stable/release/1.19.0/sdk/dartsdk-windows-ia32-release.zip

ECHO Unzipping Dart SDK...
CALL unzip -o .\dart.zip -d %HOME%\

ECHO Configuring extension...
SET DEPLOY_ACTION_LOCATION=%HOME%\site\deployments\tools
MD %DEPLOY_ACTION_LOCATION% 2>nul
MOVE .\dart_deploy.cmd %DEPLOY_ACTION_LOCATION%\deploy.cmd
MOVE .\web.config %WEBROOT_PATH%\web.config

ECHO Cleaning up...
DEL .\dart.zip

ECHO Done.