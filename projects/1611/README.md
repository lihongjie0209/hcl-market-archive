# IKE野蛮模式及NAT穿越配置

**标签：**

**IKE**

**IPSec**

## 需求

Device
A在NAT安全网关内网侧，所连接的内网侧用户进过NAT设备后访问外网。要求在Device
A和Device B之间建立一个IPsec隧道，对Host
A所在的子网（10.1.1.0/24）与Host
B所在的子网（10.1.2.0/24）之间的数据流进行安全保护。具体需要求如下：

协商双方使用缺省的IKE提议。

协商模式为野蛮模式协商。

第一阶段协商的认证方法为预共享密钥认证。

## 实验步骤：

两端的算法，密钥保持一致。

RTA设备配置：

\#

sysname RTA

\#

interface LoopBack0

ip address 10.1.1.1 255.255.255.0

\#

interface GigabitEthernet0/0

ip address 1.1.1.1 255.255.255.252

ipsec apply policy policy1

\#

ip route-static 0.0.0.0 0 1.1.1.2

ip route-static 10.1.2.0 24 1.1.1.2

#分支的感兴趣流，单分支情况下总部可以不配置ACL。

acl advanced 3000

rule 0 permit ip source 10.1.1.0 0.0.0.255 destination 10.1.2.0
0.0.0.255

\#

ipsec transform-set transform1

esp encryption-algorithm 3des-cbc

esp authentication-algorithm md5

\#

ipsec policy policy1 1 isakmp

transform-set transform1

security acl 3000

remote-address 2.2.2.2

ike-profile profile1

\#

ike profile profile1

keychain keychain1

exchange-mode aggressive

local-identity fqdn www.devicea.com

match remote identity address 2.2.2.2 255.255.0.0

\#

ike keychain keychain1

pre-shared-key address 2.2.2.2 255.255.0.0 key cipher
\$c\$3\$86D95+ekuxeyP2OdgZ+INE8VNqKTLA==

\#

RTB配置：

\#

sysname RTB

\#

interface LoopBack0

ip address 10.1.2.1 255.255.255.0

\#

interface GigabitEthernet0/0

ip address 2.2.2.2 255.255.255.252

ipsec apply policy policy1

\#

ip route-static 10.1.1.0 24 2.2.2.1

\#

ipsec transform-set transform1

esp encryption-algorithm 3des-cbc

esp authentication-algorithm md5

\#

ipsec policy-template template1 1

transform-set transform1

local-address 2.2.2.2

ike-profile profile1

\#

ipsec policy policy1 1 isakmp template template1

\#

ike profile profile1

keychain keychain1

exchange-mode aggressive

match remote identity fqdn www.devicea.com

\#

ike keychain keychain1

pre-shared-key hostname www.devicea.com key cipher
\$c\$3\$VzY9A+UFnJ1knWMcLjfj2hY/dTUt5g==

\#

## 测试结果：

以上配置完成后，子网10.1.1.0/24若向子网10.1.2.0/24发送报文，将触发IKE协商。

可通过如下显示信息查看到Device A上IKE第一阶段协商成功后生成的IKE SA。

![](./Media//image1.png)


可通过如下显示信息查看到IKE第二阶段协商生成的IPsec SA。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
