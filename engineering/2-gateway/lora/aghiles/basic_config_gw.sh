#!/bin/bash
#
# example: ./basic_config_gw.sh

if [ $# == 1 ]
then
	echo "Taking provided address: $1"
	gwid="$1"
else	

	#get the eth0 MAC addr
	gwid=`ifconfig | grep 'eth0' | awk '{print $NF}' | sed 's/://g' | awk '{ print toupper($1) }'`

	#get the wlan0 MAC addr
	if [ "$gwid" = "" ]
		then
			gwid=`ifconfig | grep 'wlan0' | awk '{print $NF}' | sed 's/://g' | awk '{ print toupper($1) }'`
			
			#it means that the wlan0 interface works in access point mode or has no IP address assigned
			#so get the address from the ether field
			if [ "$gwid" = "00" ]
			then
				gwid=`ifconfig | grep 'ether' | awk '{print $2}' | sed 's/://g' | awk '{ print toupper($1) }'`
			fi
	fi

	#set a default value
	if [ "$gwid" = "" ]
		then
			gwid="XXXXXXXXDEF0"
	fi
fi

echo "Keep a copy of /home/pi/lora_gateway/scripts/update_gw.sh"
mkdir /home/pi/scripts
cp /home/pi/lora_gateway/scripts/update_gw.sh /home/pi/scripts
sudo chown -R pi:pi /home/pi/scripts 
echo "Done"

echo "Creating /home/pi/lora_gateway/gateway_id.txt file"
echo "Writing 0000$gwid"
echo "0000$gwid" > /home/pi/lora_gateway/gateway_id.txt
echo "Done"

echo "Creating /home/pi/lora_gateway/gateway_id.md5 file"
tr -d '\n' < /home/pi/lora_gateway/gateway_id.txt | md5sum - | cut -d ' ' --field=1 > /home/pi/lora_gateway/gateway_id.md5
#the version below actually takes the \n at the end of the gw id which is not what we want, thus the version above
#md5sum /home/pi/lora_gateway/gateway_id.txt | cut -d ' ' --field=1 > /home/pi/lora_gateway/gateway_id.md5
echo "Done"

echo "Replacing gw id in /home/pi/lora_gateway/gateway_conf.json"
sed -i -- 's/gateway_ID".*"0000.*"/gateway_ID": "0000'"$gwid"'"/g' /home/pi/lora_gateway/gateway_conf.json
echo "Done"

echo "Creating /home/pi/Dropbox/LoRa-test"
mkdir -p /home/pi/Dropbox/LoRa-test
sudo chown -R pi:pi /home/pi/Dropbox
echo "Done"

rm /home/pi/lora_gateway/log
echo "Creating log -> /home/pi/Dropbox/LoRa-test"
ln -s /home/pi/Dropbox/LoRa-test /home/pi/lora_gateway/log
echo "Done"

if [ -f /etc/hostapd/custom_ssid.txt ];
then
	echo "customized hot-spot ssid detected"
	echo "keep customized hot-spot ssid and password"
else	
	echo "Replacing hot-spot ssid in /etc/hostapd/hostapd.conf"
	sudo sed -i 's/^ssid.*/ssid=WAZIUP_PI_GW_'"$gwid"'/g' /etc/hostapd/hostapd.conf
	echo "Done"
	echo "Gateway WiFi ssid is WAZIUP_PI_GW_$gwid"
		
	echo "Setting wpa_passphrase in /etc/hostapd/hostapd.conf"
	sudo sed -i 's/^wpa_passphrase.*/wpa_passphrase=loragateway/g' /etc/hostapd/hostapd.conf
	echo "Done"
	echo "Gateway WiFi wpa_passphrase is loragateway"		
fi

if grep start_upl /etc/rc.local || grep start_lpf /etc/rc.local ; then
	echo "util_pkt_logger or lora_pkt_fwd is currently used as low-level gateway"
	echo "preserving this setting"
else
	echo "Setting gateway to run at boot"
	# we always remove so that there will be no duplicate lines
	echo "Removing /home/pi/lora_gateway/scripts/start_gw.sh in /etc/rc.local if any"
	sudo sed -i '\/home\/pi\/lora_gateway\/scripts\/start_gw.sh/d' /etc/rc.local
	echo "Done"

	echo "Add /home/pi/lora_gateway/scripts/start_gw.sh in /etc/rc.local"
	sudo sed -i 's/^exit 0/\/home\/pi\/lora_gateway\/scripts\/start_gw.sh\nexit 0/g' /etc/rc.local
	echo "Done"
fi

echo "Compile lora_gateway executable"

pushd /home/pi/lora_gateway/

#remove old binaries
make clean

board=`cat /proc/cpuinfo | grep "Revision" | cut -d ':' -f 2 | tr -d " \t\n\r"`

downlink=`jq ".gateway_conf.downlink" gateway_conf.json`
 
if [ "$downlink" != "0" ]
then
	echo "Detecting downlink timer, will compile with downlink support"
fi	
		
if [ "$board" = "a01041" ] || [ "$board" = "a21041" ] || [ "$board" = "a22042" ]
	then
		echo "You have a Raspberry 2"
		echo "Compiling for Raspberry 2 and 3"
		if [ "$downlink" = "0" ]
			then 
				make lora_gateway_pi2
			else
				make lora_gateway_pi2_downlink 
		fi		
elif [ "$board" = "a02082" ] || [ "$board" = "a22082" ]
	then
		echo "You have a Raspberry 3B"
		echo "Compiling for Raspberry 2 and 3"
		if [ "$downlink" = "0" ]
			then 
				make lora_gateway_pi2
			else
				make lora_gateway_pi2_downlink 
		fi	
elif [ "$board" = "a020d3" ]
	then
		echo "You have a Raspberry 3B+"
		echo "Compiling for Raspberry 2 and 3"
		if [ "$downlink" = "0" ]
			then 
				make lora_gateway_pi2
			else
				make lora_gateway_pi2_downlink 
		fi			
elif [ "$board" = "900092" ] || [ "$board" = "900093" ]
	then
		echo "You have a Raspberry Zero"
		echo "Compiling for Raspberry Zero (same as Raspberry 1)"
		if [ "$downlink" = "0" ]
			then 
				make lora_gateway
			else
				make lora_gateway_downlink 
		fi	
elif [ "$board" = "9000c1" ]
	then
		echo "You have a Raspberry Zero W"
		echo "Compiling for Raspberry Zero W (same as Raspberry 1)"
		if [ "$downlink" = "0" ]
			then 
				make lora_gateway
			else
				make lora_gateway_downlink 
		fi	
else
	echo "You have a Raspberry 1"		
	echo "Compiling for Raspberry 1"
	if [ "$downlink" = "0" ]
		then 
			make lora_gateway
		else
			make lora_gateway_downlink 
	fi	
fi
		
sudo chown -R pi:pi /home/pi/lora_gateway/
		
popd

echo "You should reboot your Raspberry"
echo "Bye."
