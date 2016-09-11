@echo OFF

if EXIST %HOME%\dart-sdk (
	rmdir %HOME%\dart-sdk /S /Q
)

echo Downloading Dart SDK...
curl -k -o .\dart.zip https://storage.googleapis.com/dart-archive/channels/stable/release/1.19.0/sdk/dartsdk-windows-ia32-release.zip

echo Unzipping Dart SDK...
unzip -o .\dart.zip -d %HOME%\

echo Configuring extension...
set POST_DEPLOY_ACTION_LOCATION=%HOME%\site\deployments\tools\PostDeploymentActions
md %POST_DEPLOY_ACTION_LOCATION% 2>nul
move .\deploy.cmd %POST_DEPLOY_ACTION_LOCATION%\deploy.cmd

set %DART_SERVER_PATH%=%WEBROOT_PATH%\server
set %DART_CLIENT_PATH%=%WEBROOT_PATH%\client

md %DART_SERVER_PATH% 2>nul
md %DART_CLIENT_PATH% 2>nul

move .\web.config %DART_CLIENT_PATH%\web.config

echo Cleaning up...
del .\dart.zip

echo Done.