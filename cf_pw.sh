#!/bin/bash

# 设置自己的参数
pushplus=你自己的TOKEN

# 进入 CloudflareST 目录（脚本示例中的 CloudflareST 位于 /usr/dns 目录下，不一样的话自己改这里）
cd /usr/dns

# 运行 CloudflareST 测速（自行根据需求修改参数）
./CloudflareST  -dn 30 -dt 3 -tll 40 -n 1000

# 获取最快 IP的3个IP（从 result.csv 结果文件中获取IP）
IP1=$(sed -n "2,1p" result.csv | awk -F, '{print $1}')
IP2=$(sed -n "3,1p" result.csv | awk -F, '{print $1}')
IP3=$(sed -n "4,1p" result.csv | awk -F, '{print $1}')
SP1=$(sed -n "2,1p" result.csv | awk -F, '{print $6}')
SP2=$(sed -n "3,1p" result.csv | awk -F, '{print $6}')
SP3=$(sed -n "4,1p" result.csv | awk -F, '{print $6}')

# 修改 passwall 里对应节点的 IP（XXXXXX 就是节点 ID，查看/etc/config/passwall文件的node ID）
uci set passwall.XXXXXXXXXX.address="${IP1}"
uci set passwall.XXXXXXXXXX.address="${IP2}"
uci set passwall.XXXXXXXXXX.address="${IP3}"

# 微信推送最新查找的IP-pushplus推送加
curl -s -o /dev/null --data "token=$pushplus&title=HAProxy Cloudflare IP 更新成功！&content=H01:${IP1}  速度${SP1}MBps<br/>H02:${IP2}  速度${SP2}MBps<br/>H03:${IP3}  速度${SP3}MBps" http://www.pushplus.plus/send

# 最后再重启一下 passwall
uci commit passwall
/etc/init.d/haproxy restart
/etc/init.d/passwall restart
