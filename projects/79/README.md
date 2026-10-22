# OSPF快速重路由配置举例

## 需求：

Router A、Router B和Router
C属于同一OSPF区域，通过OSPF协议实现网络互连。要求当Router A和Router
B之间的链路出现故障时，业务可以快速切换到链路B上。

## 实验步骤：

1.  配置各接口的IP地址

2.  配置OSPF基本功能

3.  配置OSPF快速重路由

OSPF支持快速重路由配置有两种配置方法，可以任选一种。

方法一：使能Router A和Router
B的OSPF快速重路由功能（通过LFA算法选取备份下一跳信息）

\# 配置Router A。

\<RouterA\> system-view

\[RouterA\] ospf 1

\[RouterA-ospf-1\] fast-reroute lfa

\[RouterA-ospf-1\] quit

\# 配置Router B。

\<RouterB\> system-view

\[RouterB\] ospf 1

\[RouterB-ospf-1\] fast-reroute lfa

\[RouterB-ospf-1\] quit

方法二：使能Router A和Router
B的OSPF快速重路由功能（通过路由策略指定备份下一跳）

\# 配置Router A。

\<RouterA\> system-view

\[RouterA\] ip prefix-list abc index 10 permit 4.4.4.4 32

\[RouterA\] route-policy frr permit node 10

\[RouterA-route-policy-frr-10\] if-match ip address prefix-list abc

\[RouterA-route-policy-frr-10\] apply fast-reroute backup-interface
gigabitethernet 0/1 backup-nexthop 12.12.12.2

\[RouterA-route-policy-frr-10\] quit

\[RouterA\] ospf 1

\[RouterA-ospf-1\] fast-reroute route-policy frr

\[RouterA-ospf-1\] quit

\# 配置Router B。

\<RouterB\> system-view

\[RouterB\] ip prefix-list abc index 10 permit 1.1.1.1 32

\[RouterB\] route-policy frr permit node 10

\[RouterB-route-policy-frr-10\] if-match ip address prefix-list abc

\[RouterB-route-policy-frr-10\] apply fast-reroute backup-interface
gigabitethernet 0/1 backup-nexthop 24.24.24.2

\[RouterB-route-policy-frr-10\] quit

\[RouterB\] ospf 1

\[RouterB-ospf-1\] fast-reroute route-policy frr

\[RouterB-ospf-1\] quit

## 测试结果：

以Router A为例，查看4.4.4.4/32路由，可以看到备份下一跳信息。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
