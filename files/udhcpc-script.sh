#! /system/bin/sh
## /data/local/udhcpc-script.sh
## udhcpc -s <script>
## https://udhcp.busybox.net/README.udhcpc
## key vars: interface ip subnet mask broadcast router dns domain

pri=4000
tid=200

[ -n "$1" ] || {
  echo "Error: should be called from udhcpc"
  exit 1
}

case "$1" in
 deconfig)
  echo "Deconfiguring interface: $interface"
  ip link set $interface up
  ip ru del pri $pri lookup $tidy
  ip ro flush table $tid
  iptables -t nat -D OUTPUT -j out_dns 2>&-
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

redirectDNS() {
  echo "Redirecting DNS traffic to $1"

  chain="out_dns"
  nat="iptables -t nat"
  rule="--dport 53 -j DNAT --to $1"

  $nat -N $chain 2>&-
  $nat -F $chain
  $nat -A $chain -p udp $rule
  $nat -A $chain -p tcp $rule
  $nat -C OUTPUT -j $chain 2>&- || \
  $nat -I OUTPUT -j $chain
}

		;;
esac

exit 0
