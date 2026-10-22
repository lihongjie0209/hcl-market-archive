# IPv6 IS-IS与BFD联动配置

**标签：**

**ISIS**

## 需求

Router A、Router
B通过二层交换机互连，并且在双方接口上使能BFD应用，之间运行IPv6
IS-IS，网络层相互可达。

当Router B和二层交换机之间的链路发生故障后，BFD能够快速检测并通告IPv6
IS-IS协议。

## 实验步骤：

1、配置各接口的IPv6地址

2、配置IPv6 ISIS

以RTA为例：

\#

isis 1

is-level level-1

network-entity 10.0000.0000.0001.00

\#

address-family ipv6 unicast

\#

3、配置BFD功能

以RTA为例：

\#

interface GigabitEthernet0/0

isis ipv6 enable 1

isis ipv6 bfd enable

ipv6 address 2001::1/64

bfd min-transmit-interval 500

bfd min-receive-interval 500

bfd detect-multiplier 7

\#

## 测试结果：

显示Router A的BFD信息。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
