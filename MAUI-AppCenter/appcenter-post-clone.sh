#!/usr/bin/env bash
export DOTNET_NOLOGO=true
dotnet --info

# printenv

# Set up BASH_ENV; In AppCenter BASH_ENV should be set to ~/AppCenter/bash_env
echo $BASH_ENV
echo "Path is $PATH"

# Log diagnostics information
echo "Build configuration: $APPCENTER_XAMARIN_CONFIGURATION"
echo "Nuget is $(which nuget)"

# Print tasks info
# find $AGENT_ROOTDIRECTORY -name 'xamarinios.js' | xargs cat
# find $AGENT_ROOTDIRECTORY -name 'bash.js' | xargs cat
# find $AGENT_ROOTDIRECTORY -name 'usedotnet.js' | xargs cat

# Disable several redundant AppCenter tasks
# echo -n "" > $(find $AGENT_ROOTDIRECTORY -name 'usedotnet.js')
# echo -n "" > $(find $AGENT_ROOTDIRECTORY -name 'xamarinios.js')

# Install MAUI workloads
dotnet workload restore

# Build the app (iOS Simulator)
# dotnet build --configuration $APPCENTER_XAMARIN_CONFIGURATION

# Create release ipa for devices
dotnet publish -f:net7.0-ios -c:Release /p:ArchiveOnBuild=true /p:RuntimeIdentifier=ios-arm64 /p:CodesignKey="$APPLE_CERTIFICATE_SIGNING_IDENTITY" /p:ApplicationVersion=$APPCENTER_BUILD_ID