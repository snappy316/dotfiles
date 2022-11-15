#!/bin/zsh

# Installation instructions from https://github.com/thoughtbot/gitsh/blob/master/INSTALL

echo 'Downloading gitsh'
cd ~
curl -OL https://github.com/thoughtbot/gitsh/releases/download/v0.14/gitsh-0.14.tar.gz
echo 'Extracting gitsh'
tar -zxvf gitsh-0.14.tar.gz
cd gitsh-0.14
echo 'Configuring gitsh'
./configure
echo 'Building gitsh'
make
echo 'Installing gitsh'
sudo make install
