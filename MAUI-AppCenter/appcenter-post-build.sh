#!/usr/bin/env bash

echo "Output directory is $APPCENTER_OUTPUT_DIRECTORY"
# only works with successful build, otherwise $APPCENTER_OUTPUT_DIRECTORY is not created
# tar -zcvf $APPCENTER_OUTPUT_DIRECTORY/tasks.tar.gz $AGENT_ROOTDIRECTORY/_tasks