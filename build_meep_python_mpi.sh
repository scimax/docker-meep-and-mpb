#!/bin/bash

set -e

RPATH_FLAGS="-Wl,-rpath,/usr/local/lib:/usr/lib/x86_64-linux-gnu/hdf5/openmpi"
MY_LDFLAGS="-L/usr/local/lib -L/usr/lib/x86_64-linux-gnu/hdf5/openmpi ${RPATH_FLAGS}"
MY_CPPFLAGS="-I/usr/local/include -I/usr/include/hdf5/openmpi"

sudo apt-get update
sudo apt-get -y install libblas-dev liblapack-dev libgmp-dev swig libgsl-dev autoconf pkg-config libpng16-dev git guile-2.0-dev libfftw3-dev libhdf5-openmpi-dev hdf5-tools libpython3.5-dev python3-numpy python3-pip

mkdir -p ~/install

cd ~/install
git clone https://github.com/stevengj/harminv.git
cd harminv/
sh autogen.sh --enable-shared
make && sudo make install

cd ~/install
git clone https://github.com/stevengj/libctl.git
cd libctl/
sh autogen.sh --enable-shared
make && sudo make install

cd ~/install
git clone https://github.com/stevengj/h5utils.git
cd h5utils/
sh autogen.sh CC=mpicc LDFLAGS="${MY_LDFLAGS}" CPPFLAGS="${MY_CPPFLAGS}"
make && sudo make install

cd ~/install
git clone https://github.com/stevengj/mpb.git
cd mpb/
sh autogen.sh --enable-shared CC=mpicc LDFLAGS="${MY_LDFLAGS}" CPPFLAGS="${MY_CPPFLAGS}"
make && make check && sudo make install

sudo pip3 install --upgrade pip
pip3 install --user --no-cache-dir mpi4py
export HDF5_MPI="ON"
pip3 install --user --no-binary=h5py h5py

cd ~/install
git clone https://github.com/stevengj/meep.git
cd meep/
sh autogen.sh --enable-shared --with-mpi PYTHON=python3 CC=mpicc CXX=mpic++ LDFLAGS="${MY_LDFLAGS}" CPPFLAGS="${MY_CPPFLAGS}"
make && make check && sudo make install
