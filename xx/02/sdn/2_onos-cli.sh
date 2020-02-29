#!/bin/bash

ssh-keygen -f "/home/aghiles/.ssh/known_hosts" -R [localhost]:8101
ssh -p 8101 onos@localhost

#app activate org.onosproject.sdnwise
#rocks
