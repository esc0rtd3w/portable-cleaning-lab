#!/bin/sh

# This script is part of the Portable Cleaning Lab
# portablecleaninglab.com


# Gets current running directory of shell script file
runPath="/"
savePath="$PWD"


# Set permissions and workaround for launching from NTFS media
#chown root:root "$savePath/get_update.sh"
#chmod 0705 "$savePath/get_update.sh"


updateFile="mpam-fe.exe"

linkPath="http://go.microsoft.com/fwlink/?LinkID=87341"


wget -O "$runPath$updateFile" $linkPath


#read pause

echo "Copying New Update to Portable Media...."
echo ""

#echo "$runPath"
#echo "$savePath"

#read pause


cp "$runPath$updateFile" "$savePath"

rm "$runPath$updateFile"

#pause



