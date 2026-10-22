# OSPFv3 NSSA区域配置

## 需求：

1.  所有的路由器都运行OSPFv3，整个自治系统划分为3个区域。其中Router
    B和Router C作为ABR来转发区域之间的路由。

2.  要求将Area 1配置为NSSA区域，同时将Router
    A配置为ASBR引入外部路由（静态路由），且路由信息可正确的在AS内传播。

## 实验步骤：

1.  配置各接口的IPv6地址

2.  配置OSPFv3基本功能

3.  配置Area 1为NSSA区域

4.  配置Router A引入静态路由

以RTA配置为例：

\#

ospfv3 1

router-id 1.1.1.1

import-route static

area 0.0.0.1

nssa

\#

interface LoopBack0

ospfv3 1 area 0.0.0.1

ipv6 address 2001:3::1/64

\#

interface GigabitEthernet0/0

port link-mode route

combo enable copper

ospfv3 1 area 0.0.0.1

ipv6 address 2001::2/64

\#

ipv6 route-static 1234:: 64 NULL0

\#

## 测试结果：

查看Router B的OSPFv3路由表，可以看到NSSA区域引入的一条AS外部的路由。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
