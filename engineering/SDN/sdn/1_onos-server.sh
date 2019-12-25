#!/bin/sh

#tools/build/onos-buck build onos --show-output

cd $TOOLSPATH/sdn/onos
sudo tools/build/onos-buck run onos-local -- clean debug

