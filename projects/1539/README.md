# RIPng快速重路由配置

**标签：**

**RIPng**

## 需求

Router A、Router B和Router C通过RIPng协议实现网络互连。要求当Router
A和Router B之间的链路出现单通故障时，业务可以快速切换到链路B上。

## 实验步骤：

1、配置各路由器接口的IPv6地址和RIPng协议配置各路由器之间采用RIPng协议进行互连，确保Router
A、Router B和Router
C之间能够在网络层互通，并且各路由器之间能够借助RIPng协议实现动态路由更新。

2、配置RIPng快速重路由

配置Router A。

\#

route-policy frr permit node 10

if-match ipv6 address acl 3000

apply ipv6 fast-reroute backup-interface GigabitEthernet0/1
backup-nexthop 1::2

\#

acl ipv6 advanced 3000

rule 5 permit ipv6 source 20::/64

\#

ripng 1

fast-reroute route-policy frr

\#

配置Router B。

\#

route-policy frr permit node 10

if-match ipv6 address prefix-list abc

apply ipv6 fast-reroute backup-interface GigabitEthernet0/1
backup-nexthop 3::2

\#

ipv6 prefix-list abc index 10 permit 10::1 128

\#

ripng 1

fast-reroute route-policy frr

\#

## 测试结果：

在Router A上查看20::1/128的路由信息，可以看到备份下一跳信息。

![](./Media//image1.png)


在Router B上查看10::1/128的路由信息，可以看到备份下一跳信息。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
