num_motes=6
for ((i=2;i<=$num_motes;i++)); do 
    num_rotas=`~/libcoap/examples/coap-client -B 5 -m get coap://[fd00::200:0:0:$i]:5683/sdwsn/routes | tail -1` 
   echo "numero de rotas no mote cooja$i = $num_rotas " 
   for ((j=0;j<$num_rotas;j++)); do
      ~/libcoap/examples/coap-client -B5 -m get coap://[fd00::200:0:0:$i]:5683/sdwsn/routes?index=$j | tail -1 
   done
done
