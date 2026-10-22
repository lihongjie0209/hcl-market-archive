# RIP快速重路由配置举例

**标签：**

**RIP**

## 需求

Router B上运行两个RIP进程：RIP 100和RIP 200。Router B通过RIP 100和Router
A交换路由信息，通过RIP 200和Router C交换路由信息。

在Router
B上配置RIP进程200引入外部路由，引入直连路由和RIP进程100的路由，使得Router
C能够学习到达10.2.1.0/24和11.1.1.0/24的路由，但Router
A不能学习到达12.3.1.0/24和16.4.1.0/24的路由。

## 实验步骤：

1、配置各路由器接口的IP地址和RIPv2协议

2、配置各路由器之间采用RIPv2协议进行互连，确保Router A、Router B和Router
C之间能够在网络层互通，并且各路由器之间能够借助RIPv2协议实现动态路由更新。

3、配置快速重路由

以RTA设备为例：

\#

rip 1

undo summary

version 2

network 1.1.1.1 0.0.0.0

network 12.12.12.0 0.0.0.255

network 13.13.13.0 0.0.0.255

fast-reroute route-policy frr

\#

route-policy frr permit node 10

if-match ip address prefix-list abc

apply fast-reroute backup-interface GigabitEthernet0/1 backup-nexthop
12.12.12.2

\#

ip prefix-list abc index 10 permit 4.4.4.4 32

\#

## 测试结果：

在Router A上查看4.4.4.4/32路由，可以看到备份下一跳信息：

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
