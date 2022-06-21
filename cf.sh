#!/bin/bash

# 设置自己的参数，请把节点IP设置为路由器IP，端口默认为8443
localport=8443
remoteport=443
pushplus=自己的TOKEN
corpid='自己的参数'
appsecret='自己的参数'
agentid=自己的参数

# 进入 CloudflareST 目录（目录不一样的话自己改）
cd /root/CloudflareST

# 运行 CloudflareST 测速（自行根据需求修改参数）
./CloudflareST -dn 10 -dt 5 -tll 90

# 获取最快 IP（从 result.csv 结果文件中获取第一个 IP）和测速结果
IP=$(sed -n "2,1p" result.csv | awk -F, '{print $1}')
SP=$(sed -n "2,1p" result.csv | awk -F, '{print $6}')

# 判断一下是否成功获取到了最快 IP（如果没有就退出脚本）：
[[ -z "${IP}" ]] && echo "CloudflareST 测速结果 IP 数量为 0，跳过下面步骤..." && exit 0

# 替换IPTABLES规则
iptables -t nat -D OUTPUT $(iptables -t nat -nL OUTPUT --line-number | grep $localport | awk '{print $1}')
iptables -t nat -A OUTPUT -p tcp --dport $localport -j DNAT --to-destination ${IP}:$remoteport

# pushplus推送加
# curl -s -o /dev/null --data "token=$pushplus&title=Cloudflare IP 更新成功！&content= 优选IP ${IP} 速度为 ${SP} MBps" http://www.pushplus.plus/send

# 企业微信推送
accesstoken=$(/usr/bin/curl https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=${corpid}\&corpsecret=${appsecret} | jq -r '.access_token')
curl -H "Content-Type: application/json;charset=utf-8"  -d "{\"msgtype\": \"text\",\"agentid\": \"${agentid}\",\"touser\": \"@all\",\"text\": {\"content\":\"Cloudflare IP 更新成功！\n&content= 优选IP ${IP} 速度为 ${SP} MBps\"}}" "https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=${accesstoken}"
