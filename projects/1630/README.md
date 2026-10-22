# VPDN 业务配置

**标签：**

**VPDN**

**L2TP**

## 需求

VPDN（Virtual Private Dial
Network，虚拟专有拨号网络）业务是在宽带互联网基础上开放的基于拨号方式的虚拟专有网络业务，利用L2TP或GRE技术为物联网客户构建与公众互联网隔离的虚拟专用网络，满足客户的物联网无线终端访问客户内部网络的需求。

目前大部分VPDN业务都采用L2TP技术实现。

在运营商网络中，VPDN用户通过拨号的方式接入，由AAA服务器根据账号给BRAS下发LNS
IP等参数，BRAS作为LAC和LNS端建立L2TP隧道，实现终端用户访问本企业/封闭站点的虚拟专用网络。

PPP用户通过LAC接入LNS，在LAC和LNS之间建立L2TP隧道，以便用户通过该L2TP隧道访问公司总部。

## 实验步骤：

1、配置各接口的IP地址

2、配置静态或动态路由，公网互通

3、配置LNS

VPDN中，LAC一般是运营商的设备。用户的终端（类似手机）接入运营商LAC后，根据接入点判断向哪个LNS发起连接。用户只需要配置好LNS即可。

配置DHCP地址池，为VPDN用户分配地址，注意export参数需要配置。

\#

dhcp server ip-pool pool1

gateway-list 192.168.0.1 export-route

network 192.168.0.0 mask 255.255.255.0 export-route

dns-list 8.8.8.8

forbidden-ip 192.168.0.1

\#

interface Virtual-Template1

ppp authentication-mode chap domain dm1

\#

域下授权相关属性，一般是AAA来授权。

\#

domain dm1

authorization-attribute ip-pool pool1

authentication ppp local

authorization ppp local

accounting ppp local

\#

domain default enable dm1

\#

local-user user1 class network

password cipher \$c\$3\$nO50DGrdCEbw9AR+HQlUtOH7HudE6y2y

service-type ppp

authorization-attribute user-role network-operator

\#

l2tp-group 1 mode lns

allow l2tp virtual-template 1 remote LAC

tunnel name LNS

tunnel password cipher \$c\$3\$4JGrCnmU7/WPg5Oe9xgBEnEpJwb1/gHVNQ==

\#

l2tp enable

\#

## 测试结果：

用户按需拨号成功。

![](./Media//image1.png)


LNS分配的地址为192.168.0.2。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
