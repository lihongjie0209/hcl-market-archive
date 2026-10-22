# 配置OSPF伪连接

**标签：**

**MPLS L3VPN**

**Sham-link**

## 需求

CE 1和CE 2都属于VPN 1，它们分别接入PE 1和PE 2；

CE 1和CE 2在同一个OSPF区域中；

CE 1与CE 2之间的VPN流量通过MPLS骨干网转发，不使用OSPF的区域内路由。

## 实验步骤：

1、配置用户网络上的OSPF

在CE 1、Router A、CE 2上配置普通OSPF，发布接口的网段地址，并配置CE
1和Router A、CE 2和Router A之间的链路开销值为2。

2、在骨干网上配置MPLS L3VPN

3、配置PE接入CE，以PE-1为例：

\#

ip vpn-instance vpn1

route-distinguisher 100:1

vpn-target 1:1 import-extcommunity

vpn-target 1:1 export-extcommunity

\#

ospf 100 vpn-instance vpn1

domain-id 0.0.0.10

area 0.0.0.1

network 100.1.1.0 0.0.0.255

\#

interface GigabitEthernet0/1

port link-mode route

combo enable copper

ip binding vpn-instance vpn1

ip address 100.1.1.2 255.255.255.0

\#

bgp 100

peer 2.2.2.9 as-number 100

peer 2.2.2.9 connect-interface LoopBack0

\#

address-family vpnv4

peer 2.2.2.9 enable

\#

ip vpn-instance vpn1

\#

address-family ipv4 unicast

import-route direct

import-route ospf 100

\#

4、配置Sham-link，以PE-1为例：

\#

interface LoopBack1

ip binding vpn-instance vpn1

ip address 3.3.3.3 255.255.255.255

\#

ospf 100 vpn-instance vpn1

area 0.0.0.1

sham-link 3.3.3.3 5.5.5.5

\#

## 测试结果：

完成上述配置后，在PE设备上再次执行display ip routing-table
vpn-instance命令，可以看到去往对端CE的路由变成了通过骨干网的BGP路由，并且有去往Sham-link目的地址的路由。

在CE设备上执行display ip
routing-table命令，可以看到去往对端CE的OSPF路由下一跳变为接入PE的GigabitEthernet接口，即去往对端的VPN流量将通过骨干网转发。

在PE上执行display ospf sham-link命令可以看到Sham-link的建立情况。

以PE 1为例：

![](./Media//image1.png)


执行display ospf sham-link area命令可以看到对端状态为Full。\
![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
