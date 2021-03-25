# 路由器优选IP脚本设置定时更换优选ip
* ttyd或ssh连接openwrt
```Bash
cd /usr
mkdir dns
cd dns
wget https://raw.githubusercontent.com/eightsheep67/cf-autoupdate/main/cf.sh
```
#### 修改cf.sh中的两处地方
* bandwidth 处是带宽选择

* 一处你需要push通知的token（可选)

<img src="./image/1.png" width=80% alt="显示不了图片，开一下VPN吧🛫">

* 进入 系统-计划任务添加一下命令
* 0代表分9代表小时，意思是9：00整开始运行脚本
```Bash

0 9 * * * bash /usr/dns/cf.sh
0 20 * * * bash /usr/dns/cf.sh
```

* 修改你的节点服务器地址为192.168.1.1，然后端口号为8443，然后手动执行一次命令后建立端口端口转发，不然你的节点都暂时用不了：
```Bash
bash /usr/dns/cf.sh
```

## 修改于better-cloudflare-ip
* 请参考 [better-cloudflare-ip](https://github.com/badafans/better-cloudflare-ip)

### 特别感谢 ：
* [wxf2088.xyz](https://wxf2088.xyz)
* [badafans](https://github.com/badafans/better-cloudflare-ip)
