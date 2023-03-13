#!/usr/bin/env bash

echo "Post-clone script executing..."
echo "CPU architecture: $(uname -m)"
echo "dotnet version: $(dotnet --version)"

# use msbuild from .NET SDK
echo """#!/bin/sh
exec dotnet build \"\$@\"
""" | sudo tee /Library/Frameworks/Mono.framework/Commands/msbuild

# use nuget as dotnet
# echo """#!/bin/sh
# exec dotnet \"\$@\"
# """ | sudo tee /Library/Frameworks/Mono.framework/Commands/nuget