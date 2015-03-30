#!/bin/bash
set -e

#
# Based on:
# 	https://casablanca.codeplex.com/wikipage?title=Setup%20and%20Build%20on%20iOS
#	https://casablanca.codeplex.com/wikipage?title=Setup%20and%20Build%20on%20OSX
#

buildOSX()
{
	mkdir -p build.release
	pushd build.release
	cmake ../Release -DCMAKE_BUILD_TYPE=Release
	make cpprest
	popd
}

buildOpenSSLForIOS()
{
	git clone --depth=1 https://github.com/x2on/OpenSSL-for-iPhone.git openssl
	pushd openssl
	./build-libssl.sh
	popd
}

buildBoostForIOS()
{
	git clone https://gist.github.com/c629ae4c7168216a9856.git boostoniphone
	pushd boostoniphone
	
	git apply ../../../update-boost-libs-for-casablanca.patch
	chmod 755 boost.sh
	./boost.sh
	popd
}

buildCasablancaForIOS()
{
	git clone https://github.com/cristeab/ios-cmake.git
	pushd ios-cmake
	git apply ../fix_ios_cmake_compiler.patch
	popd

	(cd ..; git apply -v ../update-casablanca-build.patch)

	mkdir -p build.ios
	pushd build.ios
	cmake .. -DCMAKE_BUILD_TYPE=Release
	make cpprest
	popd
}

buildIOS()
{
	pushd Build_iOS

	buildOpenSSLForIOS
	buildBoostForIOS
	buildCasablancaForIOS

	popd
}

brew install cmake git openssl boost
git clone https://git.codeplex.com/casablanca

pushd casablanca
buildOSX
buildIOS
popd
