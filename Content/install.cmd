@echo OFF

IF EXIST %HOME%\dart-sdk (
	rmdir %HOME%\dart-sdk /S /Q
)

echo Downloading Dart SDK...
curl -k -o .\dart.zip https://storage.googleapis.com/dart-archive/channels/stable/release/1.19.0/sdk/dartsdk-windows-ia32-release.zip

echo Unzipping Dart SDK...
unzip -o .\dart.zip -d %HOME%\

echo Setting up web.config...
move .\web.config %WEBROOT_PATH%\web.config

echo Cleaning up...
del .\dart.zip

echo Done.