#!/usr/bin/env bash
export DOTNET_NOLOGO=true
dotnet --info

# Log diagnostics information
echo "build configuration: $APPCENTER_XAMARIN_CONFIGURATION"
echo "nuget is $(which nuget)"
echo "msbuild is $(which msbuild)"
echo "BASH_ENV is $BASH_ENV"
echo "PATH is $PATH"

# Use dummy nuget to disable AppCenter 'nuget restore' step
echo """#!/bin/sh
echo Dummy Restore
""" | sudo tee /Library/Frameworks/Mono.framework/Commands/nuget

# Use dummy msbuild to disable AppCenter 'build' step 
# 'echo 15' is required to prevent fallback to xbuild as build task check for msbuild version 15 and above
echo """#!/bin/sh
echo 15
""" | sudo tee /Library/Frameworks/Mono.framework/Commands/msbuild

# Install MAUI workloads
dotnet workload restore

# Build the app (iOS Simulator)
# dotnet build --configuration $APPCENTER_XAMARIN_CONFIGURATION

# Create release ipa for devices
dotnet publish -f:net7.0-ios -c:Release /p:ArchiveOnBuild=true /p:RuntimeIdentifier=ios-arm64 /p:CodesignKey="$APPLE_CERTIFICATE_SIGNING_IDENTITY" /p:ApplicationVersion=$APPCENTER_BUILD_ID