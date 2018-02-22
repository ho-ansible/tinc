#! /system/bin/sh
## /data/local/udhcpc-script.sh
## udhcpc -s <script>
## https://udhcp.busybox.net/README.udhcpc
## key vars: interface ip subnet mask broadcast router dns domain

[ -n "$1" ] || {
  echo "Error: should be called from udhcpc"
  exit 1
}

case "$1" in
	deconfig)
		echo "Deconfiguring interface: $interface"
		ip link set $interface up
		;;

 bound)
  echo "Setting IP address $ip on $interface"
  ip ad add $ip/$mask dev $interface

	renew)
		echo "DHCP lease renewed for $interface"

		if [ -n "$router" ] ; then
			echo "Deleting routers"
			while route del default gw 0.0.0.0 dev $interface ; do
				:
			done

			metric=0
			for i in $router ; do
				echo "Adding router $i"
				route add default gw $i dev $interface metric $((metric++))
			done
		fi
		;;
esac

exit 0
