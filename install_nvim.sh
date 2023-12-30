#!/bin/sh

sudo apt -y install git ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
git clone https://github.com/neovim/neovim nvim_install
cd nvim_install
git checkout stable
make CMAKE_BUILD_TYPE=Release
sudo make install
cd ..
rm -rf nvim_install
