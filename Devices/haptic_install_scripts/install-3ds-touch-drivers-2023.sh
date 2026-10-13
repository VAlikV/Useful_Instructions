#!/bin/bash -e

# Simple script to install 3DS touch drives

# Use at your own risk!

CUR_DIR=`pwd`

echo "--- Downloading package"
mkdir -p tmp
curl https://s3.amazonaws.com/dl.3dsystems.com/binaries/Sensable/Linux/TouchDriver_2023_11_15.tgz --output tmp/TouchDriver_2023_11_15.tgz

echo "--- Extracting package"
cd tmp && tar xf TouchDriver_2023_11_15.tgz

echo "--- Installing"
sudo cp TouchDriver_2023_11_15/bin/Touch* /usr/bin
sudo cp TouchDriver_2023_11_15/usr/lib/libPhantomIOLib42.so /usr/lib

echo "--- Removing temporary files"
cd $CUR_DIR
rm -rf tmp

echo "--- Done"
