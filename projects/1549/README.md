# NetStream普通流的统计信息输出配置

**标签：**

**NetStream**

## 需求

在RTA上启动NetStream功能。要求在GigabitEthernet0/0上配置NetStream的入方向与出方向的统计功能，并将NetStream普通流的统计信息输出到NetStream服务器。NetStream服务器的IP地址为192.168.56.1/24，UDP端口号为5000。

## 实验步骤：

1、配置各接口的IP地址

2、配置NetStream

\#

ip netstream export host 192.168.56.1 5000

\#

interface GigabitEthernet0/0

ip address 1.1.1.1 255.255.255.252

ip netstream inbound

ip netstream outbound

\#

## 测试结果：

设备运行一段时间后，查看NetStream普通流的统计信息。

![](./Media//image1.png)


IP地址224.0.0.5即为OSPF报文。

查看NetStream统计输出报文的各种信息。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
