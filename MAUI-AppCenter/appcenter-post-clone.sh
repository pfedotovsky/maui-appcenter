#!/usr/bin/env bash
export DOTNET_NOLOGO=true
dotnet --info

# Log diagnostics information
echo "build configuration: $APPCENTER_XAMARIN_CONFIGURATION"
echo "nuget is $(which nuget)"
echo "msbuild is $(which msbuild)"
echo "BASH_ENV is $BASH_ENV"
echo "PATH is $PATH"

# Set up BASH_ENV to override nuget; In AppCenter BASH_ENV must be set to ~/AppCenter/bash_env
dirName=~/AppCenter
mkdir $dirName
echo "export PATH=$dirName:$PATH" > $dirName/bash_env
echo "echo Dummy Nuget" > $dirName/nuget

cat $BASH_ENV

# Use dummy msbuild; 'echo 15' required to prevent fallback to xbuild as build task check for msbuild version 15 and above
echo """#!/bin/sh
echo 15
""" | sudo tee /Library/Frameworks/Mono.framework/Commands/msbuild

# Disable several redundant AppCenter tasks
# echo -n "" > $(find $AGENT_ROOTDIRECTORY -name 'usedotnet.js')
# echo -n "" > $(find $AGENT_ROOTDIRECTORY -name 'xamarinios.js')
# echo -n "" > $(find $AGENT_ROOTDIRECTORY -name 'cmdlinetask.js')

# Install MAUI workloads
dotnet workload restore

# Build the app (iOS Simulator)
# dotnet build --configuration $APPCENTER_XAMARIN_CONFIGURATION

# Create release ipa for devices
dotnet publish -f:net7.0-ios -c:Release /p:ArchiveOnBuild=true /p:RuntimeIdentifier=ios-arm64 /p:CodesignKey="$APPLE_CERTIFICATE_SIGNING_IDENTITY" /p:ApplicationVersion=$APPCENTER_BUILD_ID