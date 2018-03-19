#!/bin/bash

set -e

RPATH_FLAGS="-Wl,-rpath,/usr/local/lib:/usr/lib/x86_64-linux-gnu/hdf5/serial"
MY_LDFLAGS="-L/usr/local/lib -L/usr/lib/x86_64-linux-gnu/hdf5/serial ${RPATH_FLAGS}"
MY_CPPFLAGS="-I/usr/local/include -I/usr/include/hdf5/serial"

apt-get update
apt-get -y install libblas-dev liblapack-dev libgmp-dev swig libgsl-dev autoconf pkg-config libpng16-dev git guile-2.0-dev libhdf5-dev hdf5-tools libfftw3-dev libpython3.5-dev python3-numpy python3-h5py

mkdir -p ~/install

cd ~/install
git clone https://github.com/stevengj/harminv.git
cd harminv/
sh autogen.sh --enable-shared
make && make install

cd ~/install
git clone https://github.com/stevengj/libctl.git
cd libctl/
sh autogen.sh --enable-shared
make && make install

cd ~/install
git clone https://github.com/stevengj/h5utils.git
cd h5utils/
sh autogen.sh LDFLAGS="${MY_LDFLAGS}" CPPFLAGS="${MY_CPPFLAGS}"
make && make install

cd ~/install
git clone https://github.com/stevengj/mpb.git
cd mpb/
sh autogen.sh --enable-shared LDFLAGS="${MY_LDFLAGS}" CPPFLAGS="${MY_CPPFLAGS}"
make && make check && make install

cd ~/install
git clone https://github.com/stevengj/meep.git
cd meep/
sh autogen.sh --enable-shared PYTHON=python3 LDFLAGS="${MY_LDFLAGS}" CPPFLAGS="${MY_CPPFLAGS}"
make && make check && make install
