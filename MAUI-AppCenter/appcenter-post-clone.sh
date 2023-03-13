#!/usr/bin/env bash

echo "Post-clone script executing..."
echo "CPU architecture: $(uname -m)"
echo "dotnet version: $(dotnet --version)"
echo "dotnet path: $(which dotnet)"

# Restore NuGet packages
dotnet restore ./MAUI-AppCenter.sln

# Install MAUI iOS workload
dotnet workload install maui-ios

# Use msbuild from .NET SDK
echo """#!/bin/sh
exec dotnet build \"\$@\"
""" | sudo tee /Library/Frameworks/Mono.framework/Commands/msbuild

# Use dotnet as nuget
echo """#!/bin/sh
echo Dummy Restore
""" | sudo tee /Library/Frameworks/Mono.framework/Commands/nuget