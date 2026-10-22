# 基于报文协议类型的IPv6转发策略路由配置

**标签：**

**策略路由**

## 需求

Router A分别与Router B和Router C直连（保证Router B和Router
C之间路由完全不可达）。通过策略路由控制从Router
A的以太网接口GigabitEthernet0/2接收的报文：

指定所有TCP报文的下一跳为1::2；

其它IPv6报文仍然按照查找路由表的方式进行转发。

## 实验步骤：

1、配置各接口的IPv6地址与路由

2、配置策略路由

\#

ipv6 policy-based-route aaa permit node 5

if-match acl 3001

apply next-hop 1::2

\#

interface GigabitEthernet0/2

ipv6 policy-based-route aaa

ipv6 address 10::2/64

\#

acl ipv6 advanced 3001

rule 0 permit tcp

\#

## 测试结果：

从Host B上通过Telnet方式登录Router B，结果成功。

从Host B上通过Telnet方式登录Router C，结果失败。

从Host B上ping Router C，结果成功。

由于Telnet使用的是TCP协议，ping使用的是ICMP协议，所以由以上结果可证明：从Router
A的以太网接口GigabitEthernet0/2接收的TCP报文的下一跳为1::2，接口GigabitEthernet1/0/3不转发TCP报文，但可以转发非TCP报文，策略路由设置成功。

## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
