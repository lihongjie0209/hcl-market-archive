# 配置在OSPF中引入IS-IS路由时应用路由策略配置举例

## 需求：

Router B与Router A之间通过OSPF协议交换路由信息，与Router
C之间通过IS-IS协议交换路由信息。

要求在Router
B上配置路由引入，将IS-IS路由引入到OSPF中去，并同时使用路由策略设置路由的属性。其中，设置172.17.1.0/24的路由的开销为100，设置172.17.2.0/24的路由的Tag属性为20。

## 实验步骤：

1.  配置各接口的IP地址

2.  配置IS-IS路由协议

3.  配置OSPF路由协议以及路由引入，在路由引入时应用路由策略。

\#

acl basic 2002

rule 0 permit source 172.17.2.0 0.0.0.255

\#

route-policy isis2ospf permit node 10

if-match ip address prefix-list prefix-a

apply cost 100

\#

route-policy isis2ospf permit node 20

if-match ip address acl 2002

apply tag 20

\#

route-policy isis2ospf permit node 30

\#

ip prefix-list prefix-a index 10 permit 172.17.1.0 24

\#

ospf 1

import-route isis 1 route-policy isis2ospf

area 0.0.0.0

network 192.168.1.0 0.0.0.255

\#

## 测试结果：

查看Router
A的OSPF路由表，可以看到目的地址为172.17.1.0/24的路由的开销为100，目的地址为172.17.2.0/24的路由的标记域（Tag）为20，而其他外部路由没有变化。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
