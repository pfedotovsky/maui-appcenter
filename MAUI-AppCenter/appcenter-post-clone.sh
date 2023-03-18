#!/usr/bin/env bash
export DOTNET_NOLOGO=true
dotnet --info

# Log diagnostics information
echo "build configuration: $APPCENTER_XAMARIN_CONFIGURATION"
echo "PATH is $PATH"

# Disable AppCenter build tasks
echo -n "" > $(find $AGENT_ROOTDIRECTORY -name 'usedotnet.js')
echo -n "" > $(find $AGENT_ROOTDIRECTORY -name 'xamarinios.js')
echo -n "" > $(find $AGENT_ROOTDIRECTORY -name 'cmdlinetask.js')

# Install MAUI workloads
dotnet workload restore

# Build the app (iOS Simulator)
# dotnet build --configuration $APPCENTER_XAMARIN_CONFIGURATION

# Create release ipa for devices
dotnet publish -f:net7.0-ios -c:Release /p:ArchiveOnBuild=true /p:RuntimeIdentifier=ios-arm64 /p:CodesignKey="$APPLE_CERTIFICATE_SIGNING_IDENTITY" /p:ApplicationVersion=$APPCENTER_BUILD_ID

mkdir $(build.artifactstagingdirectory)/build
mkdir $(build.artifactstagingdirectory)/symbols

find . ! -path '*/obj/*' -type f -name '*.ipa' -print0 \
| xargs -0 stat -f \"%m %N\" | sort -rn | head -1 | cut -f2- -d\" \" \
| xargs -L 1 -I{} cp -R -v {} $(build.artifactstagingdirectory)/build

find . -type d -name "*.dSYM" -exec cp -v -R {} $(build.artifactstagingdirectory)/symbols