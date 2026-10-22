# IPSec Over Gre配置

**标签：**

**GRE**

**IPSec**

## 需求

两台VPN设备之间建立GRE隧道，两台设备下挂网段间流量走GRE，在GRE中对流量进行加密。

## 实验步骤：

1、配置各接口的IP地址与路由

2、配置GRE基本功能

3、配置IPsec保护GRE私网地址

以VPN1设备为例：

模拟内网设备：

\#

interface LoopBack10

description PC1

ip address 1.1.1.1 255.255.255.255

\#

interface LoopBack20

description PC2

ip address 3.3.3.3 255.255.255.255

\#

配置Gre，接口下调用IPsec：

\#

interface Tunnel0 mode gre

ip address 10.0.0.1 255.255.255.252

source GigabitEthernet0/0

destination 203.0.0.1

keepalive 10 3

gre key 123

ipsec apply policy vpn

\#

保护流是两端的内网设备：

\#

acl advanced 3000

description pc1-pc2

rule 0 permit ip source 1.1.1.1 0 destination 2.2.2.2 0

rule 5 permit ip source 3.3.3.3 0 destination 4.4.4.4 0

\#

配置IPsec：

\#

ipsec transform-set tran1

esp encryption-algorithm 3des-cbc

esp authentication-algorithm sha1

\#

ipsec policy vpn 1 isakmp

transform-set tran1

security acl 3000

remote-address 10.0.0.2

ike-profile profile1

\#

ike profile profile1

keychain keychain1

local-identity address 10.0.0.1

match remote identity address 10.0.0.2 255.255.255.252

\#

ike proposal 1

encryption-algorithm aes-cbc-192

dh group2

\#

ike keychain keychain1

pre-shared-key address 10.0.0.2 255.255.255.252 key cipher
\$c\$3\$jcWI3Nft+pxlucU8FItcsaKfbx3H7Q==

\#

## 测试结果

流量触发后，IPSec隧道已经建立：

![](./Media//image1.png)


两端内网设备可以正常通信：

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
