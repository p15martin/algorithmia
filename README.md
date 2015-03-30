# Welcome!

This library demonstrates how to use Autotools and how it's built for iOS. The code itself make a call to [Algorithmia](https://algorithmia.com/) using Microsoft's C++ REST SDK, [Casablanca](https://casablanca.codeplex.com/). Casablanca is dependent on [Boost](http://www.boost.org/) and [OpenSSL](https://www.openssl.org/). So there's some complexity!

Its sibling projects AlgoPhone and AlgoClient demonstrate how the library can be used.

The project was initialized for Autotools using this [script](https://gist.github.com/p15martin/30ca4669d8bb7c3947f7).

All you need to do is the following:

# ./build-dependencies.sh
# ./build.sh

Assuming all your projects are under the same folder, you can use the library under XCode as follows...

## iOS

Add all the libraries under **dependencies/ios** to **Link Binary With Libraries** under **Build Phases**. You will also need to add everyhting under **lib**.

Add the following to **Framework Search Paths** under **Build Settings** (tip: when you added the libraries above it probably already the paths, delete them as they won't be portable!):

* $(SOURCE_ROOT)/../algorithmia/dependencies/ios

Add the following to **Header Search Paths** under **Build Settings**:

* $(SOURCE_ROOT)/../algorithmia/lib/include
* $(SOURCE_ROOT)/../algorithmia/dependencies/include

Add the following to **Library Search Paths** under **Build Settings** (tip: when you added the libraries above it probably already the paths, delete them as they won't be portable!):

* $(SOURCE_ROOT)/../algorithmia/lib
* $(SOURCE_ROOT)/../algorithmia/dependencies/ios

## OS X

Add all the libraries under **dependencies/osx** to **Link Binary With Libraries** under **Build Phases**. You will also need to add everyhting under **lib**.

Add the following to **Header Search Paths** under **Build Settings**:

* $(SOURCE_ROOT)/../algorithmia/lib/include
* $(SOURCE_ROOT)/../algorithmia/dependencies/include

Add the following to **Library Search Paths** under **Build Settings** (tip: when you added the libraries above it probably already the paths, delete them as they won't be portable!):

* $(SOURCE_ROOT)/../algorithmia/lib
* $(SOURCE_ROOT)/../algorithmia/dependencies/osx
