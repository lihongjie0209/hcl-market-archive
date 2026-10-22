# VRRP虚地址建立IPsec配置

**标签：**

**IPsec**

**VRRP**

## 需求

Router1、Router2、Router3都连接在一台交换机上，Router2和Router3组VRRP，虚地址为10.1.1.254，Router3作为VRRP
master,Router2作为backup;Router1和VRRP虚地址之间建立基于IKE的IPSEC，实际应用中，Router2和Router3的内网口也建议使用VRRP，对内提供统一网关

## 实验步骤：

1、Router1配置

配置环回接口，模拟内网用户

interface LoopBack0

ip address 1.1.1.1 255.255.255.255

\#

接口GigabitEthernet0/0调用IPSEC策略123

interface GigabitEthernet0/0

port link-mode route

combo enable copper

ip address 10.1.1.1 255.255.255.0

ipsec apply policy 123

\#

配置静态路由，下一跳指向VRRP虚地址

ip route-static 2.2.2.2 32 10.1.1.254

\#

配置安全ACL，保护内网地址

acl number 3000

rule 0 permit ip source 1.1.1.1 0 destination 2.2.2.2 0

配置IPSEC提议，使用的加密算法为3des-cbc,认证算法为MD5

ipsec transform-set 123

esp encryption-algorithm 3des-cbc

esp authentication-algorithm md5

\#

配置IPSEC策略，调用安全ACL，指定对端地址为VRRP虚地址

ipsec policy 123 1 isakmp

transform-set 123

security acl 3000

remote-address 10.1.1.254

\#

配置ike钥匙链，使用密码为123

ike keychain 1

pre-shared-key address 10.1.1.254 255.255.255.255 key simple 123

2、Router2配置

接口GigabitEthernet0/0调用IPSEC策略并在接口配置VRRP组，虚地址为10.1.1.254

\#

interface GigabitEthernet0/0

port link-mode route

ip address 10.1.1.2 255.255.255.0

vrrp vrid 1 virtual-ip 10.1.1.254

ipsec apply policy 123

\#

配置静态路由，下一跳地址为10.1.1.1

ip route-static 1.1.1.1 32 10.1.1.1

\#

配置安全ACL，保护两侧内网地址

acl number 3000

rule 0 permit ip source 2.2.2.2 0 destination 1.1.1.1 0

\#

配置IPSEC提议，使用加密算法为3des-cbc，认证算法为MD5

ipsec transform-set 123

esp encryption-algorithm 3des-cbc

esp authentication-algorithm md5

\#

配置IPSEC策略，调用安全ACL，IPSEC提议，指定对端地址为10.1.1.1，本端地址为VRRP虚地址10.1.1.254

ipsec policy 123 1 isakmp

transform-set 123

security acl 3000

local-address 10.1.1.254

remote-address 10.1.1.1

\#

配置ike钥匙链，指定PSK为123

ike keychain 1

pre-shared-key address 10.1.1.1 255.255.255.255 key simple 123

\#

3、Router3配置

在接口GigabitEthernet0/0调用IPSEC策略并在接口配置VRRP组，虚地址为10.1.1.254

interface GigabitEthernet0/0

port link-mode route

ip address 10.1.1.3 255.255.255.0

vrrp vrid 1 virtual-ip 10.1.1.254

ipsec apply policy 123

\#

配置静态路由，下一跳指向10.1.1.1

ip route-static 1.1.1.1 32 10.1.1.1

\#

配置安全ACL，保护两侧内网地址

acl number 3000

rule 0 permit ip source 2.2.2.2 0 destination 1.1.1.1 0

\#

配置IPSEC提议，使用加密算法为3des-cbc，认证算法是MD5

ipsec transform-set 123

esp encryption-algorithm 3des-cbc

esp authentication-algorithm md5

\#

配置IPSEC策略，调用安全ACL，IPSEC提议，并制定对端地址为10.1.1.1,本端地址为VRRP虚地址10.1.1.254

ipsec policy 123 1 isakmp

transform-set 123

security acl 3000

local-address 10.1.1.254

remote-address 10.1.1.1

\#

配置ike钥匙链，PSK密码为123

ike keychain 1

pre-shared-key address 10.1.1.1 255.255.255.255 key simple 123

\#

## 测试结果：

Router1触发建立IPsec：

![](./Media//image1.png)


查看已经建立成功：

![](./Media//image2.png)


此时过程中发现Router2是master，Router3作为backup不会参与数据转发。

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
