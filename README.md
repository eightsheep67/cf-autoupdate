# 路由器优选IP脚本设置定时更换优选ip
* 用ssh连接软件连接opewrt
```Bash
cd /usr
mkdir dns
cd dns
wget https://raw.githubusercontent.com/eightsheep67/cf-autoupdate/main/cf-openwrt.sh
```
#### 修改cf-openwrt.sh中的两处地方
* bandwidth 处是带宽选择

* 一处是微信/Telegram推送token

<img src="./image/1.png" width=80% alt="显示不了图片，开一下VPN吧🛫">

* 0代表分9代表小时，意思是9：00整开始运行脚本
```Bash

0 9 * * * bash /usr/dns/cf-openwrt.sh
0 20 * * * bash /usr/dns/cf-openwrt.sh
```
* 添加计划任务
* 依次进入 系统-计划任务
* 添加一下命令

<img src="./image/2.png" width=80% alt="显示不了图片，开一下VPN吧🛫">

* 到这里就完成全部操作了，然后就是等待自动执行。
* 当然，我们可以手动来执行一次，执行命令：
```Bash
bash /usr/dns/cf-openwrt.sh
```

## 修改于better-cloudflare-ip
* 请参考 [better-cloudflare-ip](https://github.com/badafans/better-cloudflare-ip)

### 特别感谢 ：
* [wxf2088.xyz](https://wxf2088.xyz)
* [badafans](https://github.com/badafans/better-cloudflare-ip)
