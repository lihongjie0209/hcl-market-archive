# EIGRP引入外部路由配置

**标签：**

**EIGRP**

## 需求

Router B上运行两个EIGRP进程：EIGRP 10和EIGRP 20。Router B通过EIGRP
10和Router A交换路由信息，通过EIGRP 20和Router C交换路由信息。

在Router B上配置EIGRP进程20引入直连路由和EIGRP进程10的路由，使得Router
C能够学习到达10.2.1.0/24和11.1.1.0/24的路由，但Router
A不能学习到达12.3.1.0/24和16.4.1.0/24的路由。

## 实验步骤：

1、配置各接口的IP地址

2、配置EIGRP基本功能

3、配置EIGRP引入外部路由

在Router B配置EIGRP进程20引入直连路由和EIGRP进程10的路由。

\#

eigrp 20

\#

address-family ipv4

import-route direct

import-route eigrp 10

network 12.1.1.0 0.0.0.3

\#

## 测试结果：

查看路由引入后Router C的拓扑表信息。

![](./Media//image1.png)


可以看到，Router C学习到了Router
B上EIGRP进程10的10.2.1.0/24和11.1.1.0/24这两条路由。

## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
