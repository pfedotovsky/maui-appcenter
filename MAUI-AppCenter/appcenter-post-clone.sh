#!/usr/bin/env bash

echo "Post-clone script executing..."
echo "CPU architecture: $(uname -m)"
echo "dotnet version: $(dotnet --version)"
echo "dotnet path: $(which dotnet)"

# Install MAUI iOS workload
dotnet workload install maui-ios

# use msbuild from .NET SDK
# echo """#!/bin/sh
# exec dotnet build \"\$@\"
# """ | sudo tee /Library/Frameworks/Mono.framework/Commands/msbuild

# use dotnet as nuget
echo """#!/bin/sh
which dotnet
PATH="/usr/local/share/dotnet:$PATH"
which dotnet
exec dotnet restore 'MAUI-AppCenter/MAUI-AppCenter.sln'
""" | sudo tee /Library/Frameworks/Mono.framework/Commands/nuget