#!/bin/bash

# # Modify default IP
# sed -i "/uci commit system/a\uci commit network" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit network/i\uci set network.lan.proto='static'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit network/i\uci set network.lan.type='bridge'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit network/i\uci set network.lan.ifname='eth0'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit network/i\uci set network.lan.netmask='255.255.255.0'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit network/i\uci set network.lan.gateway='10.0.0.1'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit network/i\uci set network.lan.dns='10.0.0.1'" package/lean/default-settings/files/zzz-default-settings

# # Disable DHCP
# sed -i "/uci commit network/a\uci commit dhcp" package/lean/default-settings/files/zzz-default-settings
# sed -i "/uci commit network/a\uci set dhcp.lan.ignore='1'" package/lean/default-settings/files/zzz-default-settings
# sed -i "/uci commit network/a\uci set dhcp.lan.interface='lan'" package/lean/default-settings/files/zzz-default-settings


# Modify default theme
# sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
sed -i "/uci commit system/i\uci set system.@system[0].hostname='KyxieWrt'" package/lean/default-settings/files/zzz-default-settings

# # Modify default language
# sed -i "/uci commit system/a\uci commit luci" package/lean/default-settings/files/zzz-default-settings
# sed -i "/uci commit system/a\uci set luci.main.lang='en'" package/lean/default-settings/files/zzz-default-settings

# Set timezone to Toronto (Eastern Time)
sed -i "s/set system\.@system\[0\]\.timezone='CST-8'/set system.@system[0].timezone='EST5EDT'/" package/lean/default-settings/files/zzz-default-settings
sed -i "s/set system\.@system\[0\]\.zonename='Asia\/Shanghai'/set system.@system[0].zonename='America\/Toronto'/" package/lean/default-settings/files/zzz-default-settings

# Modify NTP Server
sed -i "s/ntp1.aliyun.com/time.google.com/" package/lean/default-settings/files/zzz-default-settings
sed -i "s/ntp.tencent.com/time.windows.com/" package/lean/default-settings/files/zzz-default-settings
sed -i "s/ntp.ntsc.ac.cn/0.ca.pool.ntp.org/" package/lean/default-settings/files/zzz-default-settings
sed -i "s/time.apple.com/1.ca.pool.ntp.org/" package/lean/default-settings/files/zzz-default-settings