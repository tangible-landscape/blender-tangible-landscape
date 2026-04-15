#!/bin/bash

# The coupling directory, we assume the development repo is inside
ADDON_NAME="Blender for Tangible Landscape"
TL_COUPLING="$HOME/IGroup/TL_coupling"
REPO_NAME="3D_immersion_TL_Blender4"

# quitting current blender window - make sure to save first
pkill blender

# waiting for blender to die
while pgrep -x "blender" > /dev/null; do
    sleep 1
done

# Path to zip the file to, should be outside
mkdir -p $TL_COUPLING/zip
rm $TL_COUPLING/zip/*.zip
ZIP_PATH="$TL_COUPLING/zip/3D_immersion_TL-master.zip"

cd $TL_COUPLING
zip -r "$ZIP_PATH" $REPO_NAME -x "*/.*" "*/__pycache__/*" "*.pyc" "reload/*" "scratch/*" "Watch/*" "zip/*"

# Installing the addon and configuring
blender --background --python "$TL_COUPLING/$REPO_NAME/reload/reinstall_addon.py" -- --addon_zip_path "$ZIP_PATH" --tl_coupling_path "$TL_COUPLING" --addon_name "$REPO_NAME"

# Reopening blender 5.0, assuming it's sourced correctly
blender