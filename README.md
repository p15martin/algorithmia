This library project is based on the autotools-basic template. The library makes a call to [Algorithmia](https://algorithmia.com/) using Microsoft's C++ REST SDK, [Casablanca](https://casablanca.codeplex.com/). Casablanca is dependant on [Boost](http://www.boost.org/) and [OpenSSL](https://www.openssl.org/). So there's some complexity!

Casablanca has done a good job documenting how to build the library for [iOS](https://casablanca.codeplex.com/wikipage?title=Setup%20and%20Build%20on%20iOS) and [OS X](https://casablanca.codeplex.com/wikipage?title=Setup%20and%20Build%20on%20OSX&referringTitle=Documentation). For your convenience it's all been scripted.

The project demonstrates how the library is built for both OS X and iOS. It's sibling projects AlgoPhone and AlgoClient demonstrate how the library is used.

Autoconf
Copy template
Update configure.ac
Update Makefile.am
Run autoreconf -i
Run automake --i --copy


iOS

./build-ios.sh

Assuming the projects are in the same workspace:


Build Phases (unless otherwise stated they will be under lib/ios)
libiconv.dylib (standard iOS library)
Security.framework (standard iOS framework)
libcpprest.a
boost.framework
libcrypto.a
libssl.a

Build Settings (remove/edit paths if they were automatically added with the absolute path - it won't be portable!)
Framework Search Paths - $(SOURCE_ROOT)/../algorithmia/dependencies/ios
Header Search Paths - $(SOURCE_ROOT)/../algorithmia/lib/include, $(SOURCE_ROOT)/../algorithmia/dependencies/include
Library Search Paths - $(SOURCE_ROOT)/../algorithmia/lib, $(SOURCE_ROOT)/../algorithmia/dependencies/ios


OS X

./build-osx.sh

Build Phases
libalgorithmia.a
libboost_system.dylib
libboost_chrono.dylib
libboost_thread-mt.dylib
libcpprest.2.5.a


Build Settings (remove/edit paths if they were automatically added with the absolute path - it won't be portable!)
Header Search Paths - $(SOURCE_ROOT)/../algorithmia/lib/include, $(SOURCE_ROOT)/../algorithmia/dependencies/include
Library Search Paths - $(SOURCE_ROOT)/../algorithmia/lib, $(SOURCE_ROOT)/../algorithmia/dependencies/osx


