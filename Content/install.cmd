@echo OFF

IF EXIST %HOME%\dart-sdk (
	rmdir %HOME%\dart-sdk /S /Q
)
IF EXIST %HOME%\dart.zip (
	del %HOME%\dart.zip
)

echo Downloading Dart SDK...
curl -k -o %HOME%\dart.zip https://storage.googleapis.com/dart-archive/channels/stable/release/1.19.0/sdk/dartsdk-windows-ia32-release.zip

echo Unzipping Dart SDK...
unzip -o %HOME%\dart.zip -d %HOME%\

echo Setting up web.config...
move .\web.config %WEBROOT_PATH%\web.config

echo Cleaning up...
del %HOME%\dart.zip

echo Done.