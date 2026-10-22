# IKEv2预共享密钥认证配置举例

**标签：**

**IKEv2**

**IPSec**

## 需求

在Device A和Device B之间建立IPsec隧道，对Host
A所在的子网（10.1.1.0/24）与Host
B所在的子网（10.1.2.0/24）之间的数据流进行安全保护。

Device A和Device B之间采用IKEv2协商方式建立IPsec SA。

使用缺省的IKEv2提议。

使用缺省的IKEv2安全策略。

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

ip address 1.1.1.1 255.255.255.0

ipsec apply policy map1

\#

ip route-static 0.0.0.0 0 1.1.1.2

\#

acl advanced 3101

rule 0 permit ip source 10.1.1.0 0.0.0.255 destination 10.1.2.0
0.0.0.255

\#

ipsec transform-set tran1

esp encryption-algorithm des-cbc

esp authentication-algorithm sha1

\#

ipsec policy map1 10 isakmp

transform-set tran1

security acl 3101

remote-address 1.1.1.2

ikev2-profile profile1

\#

ikev2 keychain keychain1

peer peer1

address 1.1.1.2 255.255.0.0

identity address 1.1.1.2

pre-shared-key ciphertext \$c\$3\$gX48xqnBWORlUJ5ncGKZXd0z6azwZw==

\#

ikev2 profile profile1

authentication-method local pre-share

authentication-method remote pre-share

keychain keychain1

match remote identity address 1.1.1.2 255.255.0.0

\#

RTB设备配置：

\#

sysname RTB

\#

interface LoopBack0

ip address 10.1.2.1 255.255.255.0

\#

interface GigabitEthernet0/0

ip address 1.1.1.2 255.255.255.0

ipsec apply policy use1

\#

ip route-static 0.0.0.0 0 1.1.1.1

\#

acl advanced 3101

rule 0 permit ip source 10.1.2.0 0.0.0.255 destination 10.1.1.0
0.0.0.255

\#

ipsec transform-set tran1

esp encryption-algorithm des-cbc

esp authentication-algorithm sha1

\#

ipsec policy use1 10 isakmp

transform-set tran1

security acl 3101

remote-address 1.1.1.1

ikev2-profile profile1

\#

ikev2 keychain keychain1

peer peer1

address 1.1.1.1 255.255.0.0

identity address 1.1.1.1

pre-shared-key ciphertext \$c\$3\$YuuiptY8I7pNlWB2ylkinYjTqxIXUQ==

\#

ikev2 profile profile1

authentication-method local pre-share

authentication-method remote pre-share

keychain keychain1

match remote identity address 1.1.1.1 255.255.0.0

\#

## 测试结果：

以上配置完成后，子网10.1.1.0/24若向子网10.1.2.0/24发送报文，将触发IKEv2协商。

可通过如下显示信息查看到Device A上IKEv2第一阶段协商成功后生成的IKEv2
SA。

![](./Media//image1.png)


可通过如下显示信息查看到IKEv2第二阶段协商生成的IPsec SA。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
