#!/bin/bash
num_motes=10

for ((i=2;i<=$num_motes-1;i++)); do
    ihex=`echo "ibase=10;obase=16;$i"|bc`
    routes=`~/libcoap/examples/coap-client -B 5 -m get coap://[fd00::200:0:0:$ihex]:5683/sdwsn/routes | grep -v CON`
    echo $routes
done


