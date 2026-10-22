# OSPF RIP缺省路由的发布

**标签：**

**OSPF**

**RIP**

## 需求

RTA与RTB
建立OSPF邻居，RTB与RTC建立RIP邻居。RTA，RTC分别产生缺省路由向RTB发布。

## 实验步骤：

RTA配置：

\#

ospf 1 router-id 1.1.1.1

import-route static

area 0.0.0.0

network 1.1.1.1 0.0.0.0

network 10.1.1.0 0.0.0.3

\#

ip route-static 0.0.0.0 0 NULL0

\#

RTC配置：

\#

rip 1

undo summary

version 2

network 3.3.3.3 0.0.0.0

network 10.1.2.0 0.0.0.3

import-route static

\#

ip route-static 0.0.0.0 0 NULL0

\#

## 测试结果

在RTB上查看，发现有学到RIP的缺省路由，但不能学习到OSPF的缺省路由。

\[RTB\]dis rip 1 route

Route Flags: R - RIP, T - TRIP

P - Permanent, A - Aging, S - Suppressed, G - Garbage-collect

D - Direct, O - Optimal, F - Flush to RIB

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Peer 10.1.2.1 on GigabitEthernet0/1

Destination/Mask Nexthop Cost Tag Flags Sec

0.0.0.0/0 10.1.2.1 1 0 RAOF 18

Local route

Destination/Mask Nexthop Cost Tag Flags Sec

10.1.2.0/30 0.0.0.0 0 0 RDOF -

\[RTB\]dis ospf 1 ro

OSPF Process 1 with Router ID 2.2.2.2

Routing Table

Routing for network

Destination Cost Type NextHop AdvRouter Area

10.1.1.0/30 1 Stub 0.0.0.0 2.2.2.2 0.0.0.0

1.1.1.1/32 1 Stub 10.1.1.1 1.1.1.1 0.0.0.0

2.2.2.2/32 0 Stub 0.0.0.0 2.2.2.2 0.0.0.0

Total nets: 3

Intra area: 3 Inter area: 0 ASE: 0 NSSA: 0

说明import引入路由时，距离矢量协议可以引入缺省路由；链路状态协议为了防环，不能通过import引入缺省路由。

OSPF可以通过下面的命令产生缺省路由：

default-route-advertise \[always\]

always：如果当前路由器的路由表中没有缺省路由，使用此参数可产生一个描述缺省路由的Type-5
LSA发布出去。如果没有指定该关键字，仅当本地路由器的路由表中存在缺省路由时，才可以产生一个描述缺省路由的Type-5
LSA发布出去。

由于RTA设备本身有缺省路由，只需要配置default-route-advertise命令即可。配置后，RTB收到OSPF的缺省路由。

\[RTB\]dis ospf 1 ro

OSPF Process 1 with Router ID 2.2.2.2

Routing Table

Routing for network

Destination Cost Type NextHop AdvRouter Area

10.1.1.0/30 1 Stub 0.0.0.0 2.2.2.2 0.0.0.0

1.1.1.1/32 1 Stub 10.1.1.1 1.1.1.1 0.0.0.0

2.2.2.2/32 0 Stub 0.0.0.0 2.2.2.2 0.0.0.0

Routing for ASEs

Destination Cost Type Tag NextHop AdvRouter

0.0.0.0/0 1 Type2 1 10.1.1.1 1.1.1.1

Total nets: 4

Intra area: 3 Inter area: 0 ASE: 1 NSSA: 0

## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
