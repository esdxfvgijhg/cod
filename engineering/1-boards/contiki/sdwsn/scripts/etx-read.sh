num_motes=6

while [ 1 ]; do
for ((i=2;i<=$num_motes;i++)); do 	
         echo "{\"date\"="`date +%Y%m%d%H%M%S`"}" >> mote$i.txt;
	~/libcoap/examples/coap-client -B 3 -m get coap://[fd00::200:0:0:$i]:5683/sdwsn/nbr-etx | grep neigh >> mote$i.txt;
done
sleep 60;
done
