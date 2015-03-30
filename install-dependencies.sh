#!/bin/bash
set -e

./build-casablanca.sh

mkdir -p dependencies
mkdir -p dependencies/include
mkdir -p dependencies/ios
mkdir -p dependencies/osx

pushd dependencies
pushd include
ln -Fs ../../casablanca/Release/include/cpprest
ln -Fs ../../casablanca/Release/include/pplx
ln -Fs ../../casablanca/Build_iOS/openssl/include/openssl
popd

pushd ios
ln -Fs ../../casablanca/Build_iOS/build.ios/libcpprest.a
ln -Fs ../../casablanca/Build_iOS/boostoniphone/ios/framework/boost.framework
ln -Fs ../../casablanca/Build_iOS/openssl/lib/libcrypto.a
ln -Fs ../../casablanca/Build_iOS/openssl/lib/libssl.a
popd

pushd osx
ln -Fs /usr/local/lib/libboost_system.dylib
ln -Fs /usr/local/lib/libboost_thread-mt.dylib
ln -Fs /usr/local/lib/libboost_chrono.dylib
ln -Fs ../../casablanca/build.release/Binaries/libcpprest.2.5.dylib
popd

popd