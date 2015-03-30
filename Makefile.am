AM_CXXFLAGS = -g -pedantic -Wall -std=c++11 -Iinclude -Isrc -Icasablanca/Release/include -I/usr/local/include
AM_LDFLAGS =

all: libalgorithmia.a

lib_LIBRARIES = libalgorithmia.a
libalgorithmia_a_SOURCES = src/algorithmia.cpp

ACLOCAL_AMFLAGS = -I m4 --install
EXTRA_DIST = m4/NOTES
