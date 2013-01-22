#!/bin/bash

#
# Script to extract proprietary blobs from a device via adb or from
# an expanded ROM on local disk. It also creates the necessary makefile
# fragments for building and 
#
# This reads a list of blobs to extract from device-proprietary-files.txt
# and ../$COMMON_DIR/common-proprietary-files.txt.
#
# Given no options, this script extracts blobs from a device using adb.
# Given one or more paths as options, the script will copy blobs from
# those source paths. A blob will be copied from the first source path
# that it is found in.
#
# Blobs list file format:
#   - Comments lines start with a hash (#) character and will be
#     ignore.
#   - Blobs should be listed with their path relative to /system
#     on the device. 
#   - Options for a particular blob are specified in a comment
#     after the blob path.
#
# Blob options:
#   - needed_for_build: the blob will also be copied into the obj
#     directory for use in the build of other open source files.
#   - optional: if the blob is not found, extraction will not abort.
#     directory for use in the build of other open source files.
#

# Halt on any error
set -e

# Verify that this script is being run from the device tree
if [ ! -f cm.mk ]; then
  echo "$0: cm.mk was not found in the current directory. Run this tool from your device tree."
  exit 1
fi

# Determine the device and vendor name
DEVICE=`basename $PWD`
VENDOR=`basename \`dirname $PWD\``
echo "Found DEVICE=$DEVICE VENDOR=$VENDOR"

# Validate the command line options
if [ $# -eq 0 ]; then
  # If no arguments given, extract from a real device using adb
  SRC=adb
else
  # Validate that the specified paths exist
  SRC_PATHS=$*
  for TEST_PATH in $SRC_PATHS; do
    if [ ! -d $TEST_PATH ]; then
      echo "$0: path '$TEST_PATH' not found."
      echo ""
      echo "usage: $0 [PATH_TO_EXPANDED_ROM ...]"
      echo ""
      echo "If PATH_TO_EXPANDED_ROM is not specified, blobs will be extracted from"
      echo "the device using adb pull."
      echo ""
      echo "If multiple paths are specified, each blob will be copied from the first"
      echo "path that it is found in."
      exit 1
    fi
  done
fi

# Function to perform the extraction from either adb or paths
function perform_extract_files {
  # Iterate over all files specified in the list
  for FILE_WITH_OPTIONS in `egrep -v '(^#|^$)' $1 | sed -e 's/\([^\s]\)\s*#\s*\([^\s]*\)/\1#\2/'`; do
    # Split the file from the options (format is file:options)
    OLDIFS=$IFS IFS="#" FILE_WITH_OPTIONS_ARRAY=($FILE_WITH_OPTIONS) IFS=$OLDIFS
    FILE=${FILE_WITH_OPTIONS_ARRAY[0]}
    OPTIONS=${FILE_WITH_OPTIONS_ARRAY[1]}

    # If the file is optional, then don't error out if it isn't found
    OPTIONAL=0
    if [ "$OPTIONS" == "optional" ]; then
      OPTIONAL=1
    fi

    # Prepare the destination directory
    DIR=`dirname $FILE`
    if [ ! -d $FULL_PROP_PATH/$DIR ]; then
      mkdir -p $FULL_PROP_PATH/$DIR
    fi

    # Extract or copy the file
    if [ "$SRC" = "adb" ]; then
      # Extract from the device using adb
      echo "Extracting from adb: /system/$FILE"
      if ! adb pull /system/$FILE $FULL_PROP_PATH/$FILE; then
        if [ $OPTIONAL -eq 1 ]; then
          echo "WARNING: Could not extract '$FILE' from the device."
          continue
        else
          echo "ERROR: Could not extract '$FILE' from the device."
          exit 1;
        fi
      fi
      set -e
    else
      # Search the paths for the file
      FOUNDIT=0
      for TEST_PATH in $SRC_PATHS; do
        FULLPATH=$TEST_PATH/system/$FILE
        if [ -f $TEST_PATH/system/$FILE ]; then
          SRCNAME=`basename $TEST_PATH`
          echo "Copying from $SRCNAME: /system/$FILE"
          cp $FULLPATH $FULL_PROP_PATH/$FILE
          FOUNDIT=1
          break
        fi
      done

      # Error out if the file could not be found in any source
      if [ $FOUNDIT -eq 0 ]; then
        if [ $OPTIONAL -eq 1 ]; then
          echo "WARNING: Could not find '$FILE' in any of the specified paths."
          continue
        else
          echo "ERROR: Could not find '$FILE' in any of the specified paths."
          exit 1;
        fi
      fi
    fi

    # Add the file to the full list of blobs
    FILE_LIST=("${FILE_LIST[@]}" "$FILE")

    # If the file is needed for the build, add it to a list for later
    if [ "$OPTIONS" == "needed_for_build" ]; then
      FILE_LIST_FOR_BUILD=("${FILE_LIST_FOR_BUILD[@]}" "$FILE")
    fi
  done
}

function write_header {
  (cat << EOF) > $1
# Copyright (C) 2011-2012 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/$VENDOR/$DEVICE/extract-files.sh

EOF
}

# Clean up from previous runs
OUTDIR=vendor/$VENDOR/$DEVICE
FULL_PROP_PATH=../../../$OUTDIR/proprietary
rm -rf $FULL_PROP_PATH/*

# Extract the device specific files
perform_extract_files proprietary-files.txt


#
# Create the vendor blobs makefile
#
MAKEFILE=../../../$OUTDIR/$DEVICE-vendor-blobs.mk
echo "Generating $MAKEFILE ..."
write_header $MAKEFILE
(cat << EOF) >> $MAKEFILE
# Prebuilt libraries that are needed to build open-source libraries
PRODUCT_COPY_FILES += \\
EOF

# Write out the PRODUCT_COPY_FILES list for obj
LINEEND=" \\"
INDEX=0
while [ $INDEX -lt ${#FILE_LIST_FOR_BUILD[@]} ]; do
  FILE=${FILE_LIST_FOR_BUILD[$INDEX]}
  INDEX=`expr $INDEX + 1`
  if [ $INDEX -eq ${#FILE_LIST_FOR_BUILD[@]} ]; then
    LINEEND=""
  fi
  echo "	$OUTDIR/proprietary/$FILE:obj/$FILE$LINEEND" >> $MAKEFILE
done

(cat << EOF) >> $MAKEFILE

# Proprietary files
PRODUCT_COPY_FILES += \\
EOF

# Write out the PRODUCT_COPY_FILES list
LINEEND=" \\"
INDEX=0
while [ $INDEX -lt ${#FILE_LIST[@]} ]; do
  FILE=${FILE_LIST[$INDEX]}
  INDEX=`expr $INDEX + 1`
  if [ $INDEX -eq ${#FILE_LIST[@]} ]; then
    LINEEND=""
  fi
  echo "	$OUTDIR/proprietary/$FILE:system/$FILE$LINEEND" >> $MAKEFILE
done


#
# Create the vendor makefile
#
MAKEFILE=../../../$OUTDIR/$DEVICE-vendor.mk
echo "Generating $MAKEFILE ..."
write_header $MAKEFILE
(cat << EOF) >> $MAKEFILE
# Pick up overlay for features that depend on non-open-source files

\$(call inherit-product, vendor/$VENDOR/$DEVICE/$DEVICE-vendor-blobs.mk)
EOF


#
# Create empty board config vendor makefile
#
MAKEFILE=../../../$OUTDIR/BoardConfigVendor.mk
echo "Generating $MAKEFILE ..."
write_header $MAKEFILE
