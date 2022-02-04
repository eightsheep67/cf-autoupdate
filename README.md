### 安装CloudflareST到openwrt
* 如果是第一次使用，则建议创建新文件夹（后续更新请跳过该步骤）
```Bash
mkdir CloudflareST
```

* 进入文件夹（后续更新，只需要从这里重复下面的下载、解压命令即可）
```Bash
cd /root/CloudflareST
```

* 下载 CloudflareST 压缩包（自行根据需求替换 URL 中 [版本号] 和 [文件名]）
```Bash
wget https://github.com/XIU2/CloudflareSpeedTest/releases/download/v2.0.2/CloudflareST_linux_amd64.tar.gz
```

* 解压（同名文件直接覆盖，openwrt的tar工具默认为简易版本需要升级）
```Bash
opkg update
opkg upgrade tar
tar -zxf CloudflareST_linux_amd64.tar.gz
```

* 赋予执行权限
```Bash
chmod +x CloudflareST
```



### 下载本项目脚本
```Bash
cd /usr
mkdir dns
cd dns
wget https://raw.githubusercontent.com/eightsheep67/cf-autoupdate/main/cf.sh
```



### 修改cf.sh中的设置
* 你需要push通知的token（可选)
* 更改localport端口号（可选）
* 还有测速的参数（请参考 [CloudflareSpeedTest](https://github.com/XIU2/CloudflareSpeedTest)）
* 测速参数 -dn 为下载测速数量， -sl 为下载测速下限，单位为MBps，-tll 为延迟下限，设置90防止被假墙
* 建议自建测速文件否则可能测速失败（请参考 [CloudflareSpeedTest](https://github.com/XIU2/CloudflareSpeedTest)），通过 -url 添加测速文件地址
* 通过VI工具修改cf.sh脚本
```Bash
vi /usr/dns/cf.sh
```
* 按"i"键进入编辑
* 修改完成后按"ESC"键，再按":"键，输入wq保存退出



### 修改科学节点设置
* 修改你的科学节点服务器地址为192.168.1.1，默认端口号为8443（可自行更改），然后手动执行一次命令后建立端口转发，不然你的节点都暂时用不了：
```Bash
bash /usr/dns/cf.sh
```



### 添加定时任务
* 进入 系统-计划任务添加一下命令
* 0代表分9代表小时，意思是9：00整开始运行脚本
```Bash
0 9 * * * bash /usr/dns/cf.sh
0 20 * * * bash /usr/dns/cf.sh
```



### 本项目修改于CloudflareSpeedTest及cf-autoupdate
* 请参考 [CloudflareSpeedTest](https://github.com/XIU2/CloudflareSpeedTest)
* 请参考 [cf-autoupdate](https://github.com/Lbingyi/cf-autoupdate)

### 特别感谢 ：
* [XIU2](https://github.com/XIU2)
* [Lbingyi](https://github.com/Lbingyi)
* [badafans](https://github.com/badafans/better-cloudflare-ip)
