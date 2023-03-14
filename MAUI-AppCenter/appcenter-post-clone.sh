#!/usr/bin/env bash

echo "Post-clone script executing..."

export DOTNET_NOLOGO=true
dotnet --info

echo "Build configuration: $APPCENTER_XAMARIN_CONFIGURATION"

# Print environment variables
# printenv

# Install MAUI workloads
dotnet workload restore

# Build the app (iOS Simulator)
dotnet build --configuration $APPCENTER_XAMARIN_CONFIGURATION

# Use dummy msbuild
echo """#!/bin/sh
echo $(msbuild /version /nologo)
""" | sudo tee /Library/Frameworks/Mono.framework/Commands/msbuild

# Use dummy nuget
echo """#!/bin/sh
echo Dummy Restore
""" | sudo tee /Library/Frameworks/Mono.framework/Commands/nuget