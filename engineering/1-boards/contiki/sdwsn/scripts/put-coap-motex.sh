hex=`echo "ibase=10;obase=16;$1"|bc`
~/libcoap/examples/coap-client -B 5 -m put coap://[fd00::200:0:0:$hex]:5683/sdwsn/$2
