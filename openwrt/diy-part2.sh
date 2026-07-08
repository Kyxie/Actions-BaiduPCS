#!/bin/bash

# NOTE: package/lean/default-settings/files/zzz-default-settings only contains
# a single "uci commit system" anchor (no "uci commit network"/"uci commit dhcp"
# lines exist upstream). All network/dhcp customizations below are inserted
# before that one real anchor, and each block explicitly commits itself.

# Modify default IP and network architecture for main router
sed -i "/uci commit system/i\uci set network.lan.proto='static'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i\uci set network.lan.ipaddr='192.168.1.1'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i\uci set network.lan.netmask='255.255.255.0'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i\uci commit network" package/lean/default-settings/files/zzz-default-settings

# Configure dynamic allocation parameters and shift port for AdGuard Home
sed -i "/uci commit system/i\uci set dhcp.lan.interface='lan'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i\uci set dhcp.lan.start='100'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i\uci set dhcp.lan.limit='150'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i\uci set dhcp.lan.leasetime='12h'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i\uci set dhcp.@dnsmasq[0].port='5353'" package/lean/default-settings/files/zzz-default-settings

# Bind static IP and custom hostname for miniPC
sed -i "/uci commit system/i\uci add dhcp host" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i\uci set dhcp.@host[-1].name='miniPC'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i\uci set dhcp.@host[-1].mac='68:1d:ef:41:17:5b'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i\uci set dhcp.@host[-1].ip='192.168.1.2'" package/lean/default-settings/files/zzz-default-settings

# Bind static IP and custom hostname for windows
sed -i "/uci commit system/i\uci add dhcp host" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i\uci set dhcp.@host[-1].name='windows'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i\uci set dhcp.@host[-1].mac='04:7c:16:c6:44:3c'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i\uci set dhcp.@host[-1].ip='192.168.1.3'" package/lean/default-settings/files/zzz-default-settings

# Bind static IP and custom hostname for rpi
sed -i "/uci commit system/i\uci add dhcp host" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i\uci set dhcp.@host[-1].name='rpi'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i\uci set dhcp.@host[-1].mac='AA:BB:CC:DD:EE:04'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i\uci set dhcp.@host[-1].ip='192.168.1.4'" package/lean/default-settings/files/zzz-default-settings

# Bind static IP and custom hostname for macmini
sed -i "/uci commit system/i\uci add dhcp host" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i\uci set dhcp.@host[-1].name='macmini'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i\uci set dhcp.@host[-1].mac='AA:BB:CC:DD:EE:05'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i\uci set dhcp.@host[-1].ip='192.168.1.5'" package/lean/default-settings/files/zzz-default-settings

# Bind static IP and custom hostname for macbookair
sed -i "/uci commit system/i\uci add dhcp host" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i\uci set dhcp.@host[-1].name='macbookair'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i\uci set dhcp.@host[-1].mac='ba:03:9e:e8:d8:a9'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i\uci set dhcp.@host[-1].ip='192.168.1.6'" package/lean/default-settings/files/zzz-default-settings

sed -i "/uci commit system/i\uci commit dhcp" package/lean/default-settings/files/zzz-default-settings

# Modify hostname and timezone settings to Toronto Eastern Time
sed -i "/uci commit system/i\uci set system.@system[0].hostname='KyxieWrt'" package/lean/default-settings/files/zzz-default-settings
sed -i "s/set system\.@system\[0\]\.timezone='CST-8'/set system.@system[0].timezone='EST5EDT'/" package/lean/default-settings/files/zzz-default-settings
sed -i "s/set system\.@system\[0\]\.zonename='Asia\/Shanghai'/set system.@system[0].zonename='America\/Toronto'/" package/lean/default-settings/files/zzz-default-settings

# Rebuild NTP servers to completely utilize Canada pool and mainstream sources
sed -i '/uci commit system/i\uci delete system.ntp.server' package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i\uci add_list system.ntp.server='0.ca.pool.ntp.org'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i\uci add_list system.ntp.server='1.ca.pool.ntp.org'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i\uci add_list system.ntp.server='time.google.com'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i\uci add_list system.ntp.server='time.cloudflare.com'" package/lean/default-settings/files/zzz-default-settings

# Optimize system file descriptors and TCP reuse limits
sed -i '/customized in this file/a fs.file-max=102400\nnet.ipv4.tcp_tw_reuse=1' package/base-files/files/etc/sysctl.conf

# Set Argon as default theme
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
