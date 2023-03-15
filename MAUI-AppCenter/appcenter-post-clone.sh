#!/usr/bin/env bash

echo "Post-clone script executing..."

export DOTNET_NOLOGO=true
dotnet --info

echo "Build configuration: $APPCENTER_XAMARIN_CONFIGURATION"

# Use custom dummy nuget
chmod +x ./AppCenter/nuget
echo 'export PATH=./AppCenter:$PATH' >> ~/.bashrc

# Print nuget diagnostics
echo "Nuget check..."
which nuget
echo $PATH

# Print xamarin.ios task
find $AGENT_ROOTDIRECTORY -name 'xamarinios.js' | xargs cat

# Install MAUI workloads
dotnet workload restore

# Build the app (iOS Simulator)
# dotnet build --configuration $APPCENTER_XAMARIN_CONFIGURATION

# Create release ipa for devices
dotnet publish -f:net7.0-ios -c:Release /p:ArchiveOnBuild=true /p:RuntimeIdentifier=ios-arm64 /p:CodesignKey="$APPLE_CERTIFICATE_SIGNING_IDENTITY" /p:ApplicationVersion=$(date +%s)

# Use dummy msbuild
echo """#!/bin/sh
echo $(msbuild /version /nologo)
""" | sudo tee /Library/Frameworks/Mono.framework/Commands/msbuild