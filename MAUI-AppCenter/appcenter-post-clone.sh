#!/usr/bin/env bash

echo "Post-clone script executing..."
echo "CPU architecture: $(uname -m)"
echo "dotnet version: $(dotnet --version)"
echo "dotnet path: $(which dotnet)"
echo "msbuild version: $(msbuild --version)"

# Install MAUI iOS workload
dotnet workload install maui-ios

# Build the app (Debug iOS Simulator)
dotnet build

# Use dummy msbuild
echo """#!/bin/sh
echo $(msbuild --version)
""" | sudo tee /Library/Frameworks/Mono.framework/Commands/msbuild

# Use dummy nuget
echo """#!/bin/sh
echo Dummy Restore
""" | sudo tee /Library/Frameworks/Mono.framework/Commands/nuget