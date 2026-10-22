# IPv6 NetStream普通流的统计信息输出配置举例

**标签：**

**NetStream**

## 需求

在RTB上启动IPv6 NetStream功能。要求在GigabitEthernet0/1上配置IPv6
NetStream，对接收的报文进行入方向和出方向统计，并将IPv6
NetStream普通流的统计信息输出到IPv6 NetStream服务器。IPv6
NetStream服务器的IP地址为1::1/64，UDP端口号为5000。

## 实验步骤：

1、配置各接口的IP地址

2、配置IPv6 NetStream

\#

ipv6 netstream export host 1::1 5000

\#

interface GigabitEthernet0/1

ospfv3 1 area 0.0.0.0

ipv6 netstream inbound

ipv6 netstream outbound

ipv6 address 2::2/64

\#

## 测试结果：

设备运行一段时间后，查看IPv6 NetStream普通流的统计信息。

![](./Media//image1.png)


IPv6地址FF02::.5即为OSPFv3报文。

查看IPv6 NetStream统计输出报文的各种信息。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
