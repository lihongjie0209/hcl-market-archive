# IS-IS快速重路由配置举例

## 需求：

Router A、Router B和Router
C属于同一IS-IS区域，通过IS-IS协议实现网络互连。要求当Router A和Router
B之间的链路出现故障时，业务可以快速切换到链路B上。

## 实验步骤：

1.  配置各接口的IP地址

2.  配置ISIS基本功能

3.  配置ISIS快速重路由

IS-IS支持快速重路由配置有两种配置方法，一种是通过LFA（Loop Free
Alternate）算法选取备份下一跳，另一种是在路由策略中指定备份下一跳，两种方法任选一种。

方法一：使能Router A和Router
B的IS-IS协议的自动计算快速重路由能力（以Router A为例）。

\# 配置Router A。

\<RouterA\> system-view

\[RouterA\] isis 1

\[RouterA-isis-1\] address-family ipv4

\[RouterA-isis-1-ipv4\] fast-reroute lfa

\[RouterA-isis-1-ipv4\] quit

\[RouterA-isis-1\] quit

方法二：使能Router A和Router
B的IS-IS协议的指定路由策略快速重路由能力（以Router A为例）。

\# 配置Router A。

\<RouterA\> system-view

\[RouterA\] ip prefix-list abc index 10 permit 4.4.4.4 32

\[RouterA\] route-policy frr permit node 10

\[RouterA-route-policy-frr-10\] if-match ip address prefix-list abc

\[RouterA-route-policy-frr-10\] apply fast-reroute backup-interface
gigabitethernet 0/1 backup-nexthop 12.12.12.2

\[RouterA-route-policy-frr-10\] quit

\[RouterA\] isis 1

\[RouterA-isis-1\] address-family ipv4

\[RouterA-isis-1-ipv4\] fast-reroute route-policy frr

\[RouterA-isis-1-ipv4\] quit

\[RouterA-isis-1\] quit

## 测试结果：

在Router A上查看4.4.4.4/32路由，可以看到备份下一跳信息。

![](./Media//image2.png)


在Router B上查看1.1.1.1/32路由，可以看到备份下一跳信息。

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
