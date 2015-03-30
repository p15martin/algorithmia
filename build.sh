#!/bin/bash
set -e

HEADERS=algorithmia.h,module.map
PROJECT_NAME=algorithmia
echo `xcode-select -print-path`

# make test
make clean

buildIOS()
{
	ARCH=$1

	if [[ "${ARCH}" == "i386" || "${ARCH}" == "x86_64" ]]; then
		SDK=`xcrun --sdk iphonesimulator --show-sdk-path`
	else
		SDK=`xcrun --sdk iphoneos --show-sdk-path`
	fi
   
	echo "Building ${PROJECT_NAME} for ${ARCH} ${SDK}"

	make CXXFLAGS="-isysroot ${SDK} -arch ${ARCH}" LDFLAGS="-syslibroot ${SDK} -arch ${ARCH}" lib${PROJECT_NAME}.a 

	mv lib${PROJECT_NAME}.a tmp/lib${PROJECT_NAME}-${ARCH}.a

	make clean
}

buildOSX()
{
	echo "Building ${PROJECT_NAME} for OS X ${SDK}"

	make

	mv lib${PROJECT_NAME}.a tmp/lib${PROJECT_NAME}.a

	make clean
}

echo "Cleaning up"
rm -fR lib
rm -fR tmp

LIBDIR=`basename "$PWD"`

mkdir -p lib/include/$LIBDIR
mkdir -p tmp

echo "Copying headers"
eval "cp src/{$HEADERS} lib/include/$LIBDIR"

autoreconf -i
automake --i --copy
./configure

buildIOS "arm64"
buildIOS "x86_64"
buildIOS "i386"
buildIOS  "armv7"
buildIOS  "armv7s"
# buildOSX

echo "Building libraries"
lipo tmp/*.a -create -output lib/lib${PROJECT_NAME}.a

echo "Cleaning up"
rm -fR tmp

echo "Done"
