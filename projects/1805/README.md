# L2TP多实例配置举例

**标签：**

**L2TP**

## 需求

多个企业共用Router C作为LNS，不同的企业用户分别连接Router A和Router
B与各自的总部site1 和site2 进行通讯。现要求：在Router
C上配置L2TP多实例功能，使其能够为Router A和Router
B同时提供L2TP接入服务，实现不同企业的用户能够远程访问企业内部网络。

## 实验步骤：

1、配置各接口的IP地址

2、配置L2TP

Router C的配置

\# 全局开启 L2TP 功能。

\<RouterC\> system-view

\[RouterC\] l2tp enable

\# 配置本地用户，并设置密码。

\[RouterC\] local-user 1 class network

\[RouterC-luser-network-1\] password simple 1234

\[RouterC-luser-network-1\] service-type ppp

\[RouterC-luser-network-1\] quit

\[RouterC\] local-user 2 class network

\[RouterC-luser-network-2\] password simple 1234

\[RouterC-luser-network-2\] service-type ppp

\[RouterC-luser-network-2\] quit

\# 配置 VPN 实例 vpn1 和 vpn2。

\[RouterC\] ip vpn-instance vpn1

\[RouterC-vpn-instance-vpn1\] route-distinguisher 100:1

\[RouterC-vpn-instance-vpn1\] vpn-target 100:1 import-extcommunity

\[RouterC-vpn-instance-vpn1\] vpn-target 100:1 export-extcommunity

\[RouterC-vpn-instance-vpn1\] quit

\[\[RouterC\] ip vpn-instance vpn2

\[RouterC-vpn-instance-vpn2\] route-distinguisher 200:1

\[RouterC-vpn-instance-vpn2\] vpn-target 200:1 import-extcommunity

\[RouterC-vpn-instance-vpn2\] vpn-target 200:1 export-extcommunity

\[RouterC-vpn-instance-vpn2\] quit

\# 配置地址池。

\[RouterC\] ip pool 1 100.0.0.2 100.0.0.100

\[RouterC\] ip pool 2 101.0.0.2 101.0.0.100

\# 创建虚拟模板接口 1。

\[RouterC\] interface virtual-template 1

\# 在虚拟模板接口上采用 PAP 方式认证对端设备。

\[RouterC-Virtual-Template1\] ppp authentication-mode pap

\# 接口使用地址池 1 为客户端分配地址。

\[RouterC-Virtual-Template1\] remote address pool 1

\# 配置虚拟模板接口绑定 vpn1。

\[RouterC-Virtual-Template1\] ip binding vpn-instance vpn1

\[RouterC-Virtual-Template1\] ip address 100.0.0.1 8

\[RouterC-Virtual-Template1\] quit

\# 创建虚拟模板接口 2。

\[RouterC\] interface virtual-template 2

\# 在虚拟模板接口上采用 PAP 方式认证对端设备。

\[RouterC-Virtual-Template2\] ppp authentication-mode pap

\# 接口使用地址池 2 为客户端分配地址。

\[RouterC-Virtual-Template2\] remote address pool 2

\# 配置虚拟模板接口绑定 vpn1。

\[RouterC-Virtual-Template2\] ip binding vpn-instance vpn2

\[RouterC-Virtual-Template2\] ip address 101.0.0.1 8

\[RouterC-Virtual-Template2\] quit

\# 创建 LNS 模式的 L2TP 组 1。

\[RouterC\] l2tp-group 1 mode lns

\# 配置 LNS 侧本端名称为 lns-A，指定接收呼叫的虚拟模板接口为
VT1，并配置隧道对端名称为 lac-A。

\[RouterC-l2tp1\] tunnel name lns-A

\[RouterC-l2tp1\] undo tunnel authentication

\[RouterC-l2tp1\] allow l2tp virtual-template 1 remote lac-A

\[RouterC-l2tp1\] quit

\# 创建 LNS 模式的 L2TP 组 1。

\[RouterC\] l2tp-group 2 mode lns

\# 配置 LNS 侧本端名称为 lns-B，指定接收呼叫的虚拟模板接口为
VT2，并配置隧道对端名称为 lac-B。

\[RouterC-l2tp2\] tunnel name lns-B

\[RouterC-l2tp2\] undo tunnel authentication

\[RouterC-l2tp2\] allow l2tp virtual-template 2 remote lac-B

\[RouterC-l2tp2\] quit

\# 配置接口地址并关联 VPN 实例。

\[RouterC\] interface gigabitethernet 0/0

\[RouterC-GigabitEthernet0/0\] ip address 1.1.1.3 24

\[RouterC-GigabitEthernet0/0\] quit

\[RouterC\] interface gigabitethernet 0/1

\[RouterC-GigabitEthernet0/1\] ip binding vpn-instance vpn1

\[RouterC-GigabitEthernet0/1\] ip address 5.0.0.1 8

\[RouterC-GigabitEthernet0/1\] quit

\[RouterC\] interface gigabitethernet 0/2

\[RouterC-GigabitEthernet0/2\] ip binding vpn-instance vpn2

\[RouterC-GigabitEthernet0/2\] ip address 6.0.0.1 8

\[RouterC-GigabitEthernet0/2\] quit

Router A与Router B的配置类似，以Router A为例：

Router A的配置

\# 全局开启 L2TP 功能。

\<RouterA\> system-view

\[RouterA\] l2tp enable

\# 配置 L2TP 组。

\[RouterA\] l2tp-group 1 mode lac

\# 配置 LAC 侧本端名称为 lac-A，并指定 LNS 的 IP 地址为 1.1.1.3。

\[RouterA-l2tp1\] tunnel name lac-A

\[RouterA-l2tp1\] undo tunnel authentication

\[RouterA-l2tp1\] lns-ip 1.1.1.3

\[RouterA-l2tp1\] quit

\# 创建和配置虚拟 PPP 接口，配置 PPP 用户的用户名为 1、密码为
1234，并配置 PPP 验证方式

为 PAP。。

\[RouterA\] interface virtual-PPP 1

\[RouterA-Virtual-PPP1\] ip address ppp-negotiate

\[RouterA-Virtual-PPP1\] ppp pap local-user 1 password simple 1234

\[RouterA-Virtual-PPP1\] quit

\# 配置接口 GigabitEthernet0/0 的 IP 地址

\[RouterA\] interface gigabitethernet 0/0

\[RouterA-GigabitEthernet0/0\] ip address 1.1.1.1 24

\[RouterA-GigabitEthernet0/0\] quit

\# 配置私网路由，访问公司总部的报文将通过 L2TP 隧道转发。

\[RouterA\] ip route-static 5.0.0.0 8 Virtual-PPP 1

\# 配置触发 LAC 发起 L2TP 隧道建立请求。

\[RouterA\] interface virtual-PPP 1

\[RouterA-Virtual-PPP1\] l2tp-auto-client l2tp-group 1

\[RouterA-Virtual-PPP1\] quit

## 测试结果：

在Router C上查看，两个用户都已经接入：

![](./Media//image1.png)


Router A可以ping通Router C的5.0.0.1，Router B可以ping通Router
C的6.0.0.1，以Router A测试为例：

![](./Media//image2.png)


说明L2TP隧道建立成功。

## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
