# RIP silent-interface

**标签：**

**RIP**

## 需求

RIP中，部分接口只作为末梢发布路由即可，这时可以配置静默接口。silent-interface命令用来配置接口工作在抑制状态，即接口只接收RIP报文而不发送RIP报文。

## 实验步骤：

1、配置各接口的IP地址

2、配置RIP基本功能

3、配置RIP静默接口

RTA配置：

\#

rip 1

undo summary

version 2

network 1.1.1.0 0.0.0.3

network 2.2.2.9 0.0.0.0

silent-interface LoopBack0

\#

RTB配置：

\#

rip 2

undo summary

version 2

network 1.1.1.0 0.0.0.3

network 3.3.3.9 0.0.0.0

silent-interface GigabitEthernet0/0

\#

## 测试结果：

RTA学习不到RIP路由。

![](./Media//image1.png)


RTB可以学习到路由。

![](./Media//image2.png)


即RIP的静默接口与OSPF的静默存在天然的区别。

## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
