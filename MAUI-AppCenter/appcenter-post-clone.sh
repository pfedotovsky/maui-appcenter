#!/usr/bin/env bash

echo "Post-clone script executing..."

export DOTNET_NOLOGO=true
dotnet --info

echo "Build configuration: $APPCENTER_XAMARIN_CONFIGURATION"
echo "Path is $PATH"

# Print tasks info
# find $AGENT_ROOTDIRECTORY -name 'xamarinios.js' | xargs cat
# find $AGENT_ROOTDIRECTORY -name 'bash.js' | xargs cat
# find $AGENT_ROOTDIRECTORY -name 'usedotnet.js' | xargs cat

# Disable 'change dotnet' task
echo -n "" > $(find $AGENT_ROOTDIRECTORY -name 'usedotnet.js')

# Disable xamarin build
echo -n "" > $(find $AGENT_ROOTDIRECTORY -name 'xamarinios.js')

# Override nuget command
which nuget

# Install MAUI workloads
dotnet workload restore

# Build the app (iOS Simulator)
# dotnet build --configuration $APPCENTER_XAMARIN_CONFIGURATION

# Create release ipa for devices
dotnet publish -f:net7.0-ios -c:Release /p:ArchiveOnBuild=true /p:RuntimeIdentifier=ios-arm64 /p:CodesignKey="$APPLE_CERTIFICATE_SIGNING_IDENTITY" /p:ApplicationVersion=$Build.BuildNumber