#!/bin/bash

docker build --build-context dotfiles=../../ -t debian-install-test .
docker run --name debian-install-test --rm -it debian-install-test bash -c "./install.sh && ./install.sh; exec bash"

