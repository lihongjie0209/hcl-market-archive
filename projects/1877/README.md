# 6PE配置

**标签：**

**6PE**

## 需求

通过配置6PE实现利用MPLS技术跨越运营商的IPv4网络连接隔离的两个IPv6用户网络。其中：

运营商网络内部采用OSPF作为IGP路由协议。

PE 1和PE 2为运营商网络的边缘设备，PE 1和PE 2之间建立IPv4 IBGP连接。

CE 1和CE 2为IPv6用户网络的边缘设备，用户网络通过该设备接入运营商网络。

CE与PE之间配置IPv6静态路由，以指导IPv6报文的转发。

## 实验步骤：

1、配置各接口的IPv6地址及IPv4地址

2、配置PE设备，以PE-1设备为例：

全局使能LDP能力，并配置LSP触发策略。

\#

mpls lsr-id 2.2.2.2

\#

mpls ldp

lsp-trigger all

\#

在接口GigabitEtherne0/1上使能MPLS和LDP能力。

\#

interface GigabitEthernet0/1

ip address 1.1.1.1 255.255.255.252

mpls enable

mpls ldp enable

\#

配置IBGP，使能对等体的6PE能力，并引入IPv6的直连和静态路由。

\#

bgp 65100

router-id 2.2.2.2

peer 3.3.3.3 as-number 65100

peer 3.3.3.3 connect-interface LoopBack0

\#

address-family ipv6 unicast

import-route direct

import-route static

peer 3.3.3.3 enable

peer 3.3.3.3 label-route-capability

\#

配置到CE 1的静态路由。

\#

ipv6 route-static 1::1 128 10::1

\#

配置OSPF，实现运营商网络内部互通。

\#

ospf 1

area 0.0.0.0

network 1.1.1.0 0.0.0.3

network 2.2.2.2 0.0.0.0

\#

## 测试结果

显示PE-1上的IPv6
BGP路由信息。可以看到PE-1上存在到达两个IPv6用户网络的路由。

![](./Media//image1.png)


CE 1可以ping通CE 2的IPv6地址（Loopback接口地址4::4）。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
