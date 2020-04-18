#!/bin/bash

sudo apt-get install build-essential
echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> /home/david/.zprofile
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
