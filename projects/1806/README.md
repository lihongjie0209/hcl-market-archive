# L2TP over IPsec 典型配置举例

**标签：**

**L2TP**

**IPsec**

## 需求

Host通过L2TP隧道访问LNS一侧的网络。具体应用需求如下：

• LAC 与 LNS 自动建立 L2TP 隧道

• LAC 与 LNS 之间采用 IKE 方式建立 IPsec 安全隧道来对 L2TP
流量进行加密。

## 实验步骤：

1、LNS的配置

\# 配置本地用户 1，设置密码为 1234。

\<LNS\> system-view

\[LNS\] local-user 1 class network

\[LNS-luser-network-1\] password simple 1234

\[LNS-luser-network-1\] service-type ppp

\[LNS-luser-network-1\] quit2

\# 配置 ISP 域 system 对 PPP 用户采用本地验证。

\[LNS\] domain system

\[LNS-isp-system\] authentication ppp local

\[LNS-isp-system\] quit

\# 使能 L2TP。

\[LNS\] l2tp enable

\# 配置虚模板 Virtual-Template1 配置接口的 IP 地址为 192.168.0.1/24，
PPP 认证方式为 PAP，并

指定为 PPP 用户分配的 IP 地址为 192.168.0.2。

\[LNS\] interface virtual-template 1

\[LNS-Virtual-Template1\] ip address 192.168.0.1 24

\[LNS-Virtual-Template1\] ppp authentication-mode pap domain system

\[LNS-Virtual-Template1\] remote address 192.168.0.2

\[LNS-Virtual-Template1\] quit

\# 创建 LNS 模式的 L2TP 组 1，配置隧道本端名称为
lns，指定接收呼叫的虚拟模板接口为 VT1，

并配置 L2TP 隧道对端名为 lac。

\[LNS\] l2tp-group 1 mode lns

\[LNS-l2tp1\] tunnel name lns

\[LNS-l2tp1\] undo tunnel authentication

\[LNS-l2tp1\] allow l2tp virtual-template 1 remote lac

\[LNS-l2tp1\] quit

\# 配置访问控制列表。

\[LNS\] acl number 3000

\[LNS-acl-adv-3000\] rule permit ip source 10.0.0.2 0 destination
10.0.0.1 0

\[LNS-acl-adv-3000\] quit

\# 配置 IKE keychain。

\[LNS\] ike keychain l2tp

\# 配置与地址为 10.0.0.1 的对端使用的预共享密钥为明文的 abcd。

\[LNS-ike-keychain-l2tp\] pre-shared-key address 10.0.0.1 key simple
abcd

\[LNS-ike-keychain-l2tp\] quit

#在 IKE profile l2tp 中指定名称为 l2tp 的配置的 IKE keychain。

\[LNS\] ike profile l2tp

\[LNS-ike-profile-l2tp\] keychain l2tp

\# 指定使用 IP 地址 10.0.0.2 标识本端身份。

\[LNS-ike-profile-l2tp\] local-identity address 10.0.0.2

\# 指定需要匹配对端身份类型为 IP 地址，取值为 10.0.0.1。

\[LNS-ike-profile-l2tp\] match remote identity address 10.0.0.1

\[LNS-ike-profile-l2tp\] quit

\# 配置 IPsec 安全协议。

\[LNS\] ipsec transform-set l2tp

\# 配置 IPsec 安全提议采用的 ESP 加密算法为 CBC 模式的 3DES 算法。

\[LNS-ipsec-transform-set-l2tp\] esp encryption-algorithm 3des-cbc

\# 配置 IPsec 安全提议采用的 ESP 认证算法为 MD5。

\[LNS-ipsec-transform-set-l2tp\] esp authentication-algorithm md5

\[LNS-ipsec-transform-set-l2tp\] quit

\# 配置 IPsec 安全策略引用 ACL 3000 和名字为 l2tp 的 IPsec
安全提议，并指定 IPsec 隧道的对端

IPv4 地址为 10.0.0.1。

\[LNS\] ipsec policy l2tp 1 isakmp

\[LNS-ipsec-policy-isakmp-l2tp-1\] security acl 3000

\[LNS-ipsec-policy-isakmp-l2tp-1\] transform-set l2tp

\[LNS-ipsec-policy-isakmp-l2tp-1\] ike-profile l2tp

\[LNS-ipsec-policy-isakmp-l2tp-1\] remote-address 10.0.0.1

\[LNS-ipsec-policy-isakmp-l2tp-1\] quit

\# 配置连接 LAC 的接口 GigabitEthernet0/0 的 IP 地址并使能 IPsec
安全策略。

\# 配置接口 IP 地址并使能 IPsec 安全策略。

\[LNS\] interface gigabitethernet 0/0

\[LNS-GigabitEthernet0/0\] ip address 10.0.0.2 24

\[LNS-GigabitEthernet0/0\] ipsec apply policy l2tp

\[LNS-GigabitEthernet0/0\] quit

\# 配置接口 GigabitEthernet0/1 的 IP 地址。

\[LNS\] interface gigabitethernet 0/1

\[LNS-GigabitEthernet0/1\] ip address 15.0.0.1 24

\[LNS-GigabitEthernet0/1\] quit

2、LAC的配置

\# 开启 L2TP 功能。

\<LAC\> system-view

\[LAC\] l2tp enable

\# 创建 LAC 模式的 L2TP 组 1。

\[LAC\] l2tp-group 1 mode lac

\# 配置 LAC 侧本端名称为 LAC，并指定 LNS 的 IP 地址为 10.0.0.2。

\[LAC-l2tp1\] tunnel name lac

\[LAC-l2tp1\] lns-ip 10.0.0.2

\[LAC-l2tp1\] undo tunnel authentication

\[LAC-l2tp1\] quit

\# 配置访问控制列表。

\[LAC\] acl number 3000

\# 配置 ACL 的规则。

\[LAC-acl-adv-3000\] rule permit ip source 10.0.0.1 0 destination
10.0.0.2 0

\[LAC-acl-adv-3000\] quit

\# 配置 Virtual-ppp 口，配置 PPP 用户的用户名为 1，密码为 1234，并配置
PPP 验证方式为 PAP。

\[LAC\] interface virtual-PPP 1

\[LAC-Virtual-PPP1\] ip address ppp-negotiate

\[LAC-Virtual-PPP1\] ppp pap local-user 1 password simple 1234

\[LAC-Virtual-PPP1\] quit

\# 配置私网路由，访问公司总部的报文将通过 L2TP 隧道转发。

\[LAC\] ip route-static 15.0.0.1 24 Virtual-PPP 1

\# 配置 IKE keychain。

\[LAC\] ike keychain l2tp

\# 配置与地址为 10.0.0.2 的对端使用的预共享密钥为明文的 abcd。

\[LAC-ike-keychain-l2tp\] pre-shared-key address 10.0.0.2 key simple
abcd

\[LAC-ike-keychain-l2tp\] quit

\# 在 IKE profile l2tp 中指定名称为 l2tp 的配置的 IKE keychain。

\[LAC\] ike profile l2tp

\[LAC-ike-profile-l2tp\] keychain l2tp

\# 指定使用 IP 地址 10.0.0.1 标识本端身份。

\[LAC-ike-profile-l2tp\] local-identity address 10.0.0.1

\# 指定需要匹配对端身份类型为 IP 地址，取值为 10.0.0.2。

\[LAC-ike-profile-l2tp\] match remote identity address 10.0.0.2

\[LAC-ike-profile-l2tp\] quit

\# 配置 Ipsec 安全协议。

\[LAC\] ipsec transform-set l2tp

\# 配置 IPsec 安全提议采用的 ESP 加密算法为 CBC 模式的 3DES 算法。

\[LAC-ipsec-transform-set-l2tp\] esp encryption-algorithm 3des-cbc

\# 配置 IPsec 安全提议采用的 ESP 认证算法为 MD5。

\[LAC-ipsec-transform-set-l2tp\] esp authentication-algorithm md5

\[LAC-ipsec-transform-set-l2tp\] quit

\# 配置 IPsec 安全策略引用 ACL 3000 和名字为 l2tp 的 IPsec
安全提议，并指定 IPsec 隧道的对端

IPv4 地址为 10.0.0.2。

\[LAC\] ipsec policy l2tp 1 isakmp

\[LAC-ipsec-policy-isakmp-l2tp-1\] security acl 3000

\[LAC-ipsec-policy-isakmp-l2tp-1\] transform-set l2tp

\[LAC-ipsec-policy-isakmp-l2tp-1\] ike-profile l2tp

\[LAC-ipsec-policy-isakmp-l2tp-1\] remote-address 10.0.0.2

\[LAC-ipsec-policy-isakmp-l2tp-1\] quit

\# 配置接口 GigabitEthernet0/1 的 IP 地址。

\[LAC\] interface gigabitethernet 0/1

\[LAC-GigabitEthernet0/1\] ip address 14.0.0.1 24

\[LAC-GigabitEthernet0/1\] quit

\# 配置连接 LNS 的接口 GigabitEthernet0/0 的 IP 地址并使能 IPsec
安全策略。

\[LAC\] interface gigabitethernet 0/0

\[LAC-GigabitEthernet0/0\] ip address 10.0.0.1 24

\[LAC-GigabitEthernet0/0\] ipsec apply policy l2tp

\[LAC-GigabitEthernet0/0\] quit

\# 执行 l2tp-auto-client 命令触发 LAC 建立 L2TP 隧道。

\[LAC\] interface virtual-PPP 1

\[LAC-Virtual-PPP1\] l2tp-auto-client l2tp-group 1

## 测试结果：

在 LNS 侧，通过命令 display l2tp tunnel 查看建立的 L2TP 隧道。

![](./Media//image1.png)


在 LNS 侧，通过命令 display l2tp session 可查看已建立的 L2TP 会话。

![](./Media//image2.png)


IPsec已经建立成功，L2TP流量在保护流中。

![](./Media//image3.png)


Host可以通过L2TP隧道访问内网。

![](./Media//image4.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
