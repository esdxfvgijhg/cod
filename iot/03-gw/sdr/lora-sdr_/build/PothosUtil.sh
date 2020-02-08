#!/bin/sh
export LD_LIBRARY_PATH=/usr/local/lib:${LD_LIBRARY_PATH}
export DYLD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${DYLD_LIBRARY_PATH}
"/usr/local/bin/PothosUtil" $@
