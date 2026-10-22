# 配置NTP组播模式

**标签：**

**NTP**

## 需求

为了实现Router
C作为不同网段中多个设备的时间服务器，同时同步多个设备的时间，要求：

在Router C上设置本地时钟作为参考时钟，层数为2；

Router
C工作在组播服务器模式，从接口GigabitEthernet0/0向外组播发送NTP报文；

Router A和Router
D工作在组播客户端模式，分别从各自的接口GigabitEthernet0/0监听NTP组播报文。

## 实验步骤：

1、配置各接口的IP地址与路由

2、配置NTP

配置Router A

\[RouterA\] ntp-service enable

\[RouterA\] clock protocol ntp

\[RouterA\] interface gigabitethernet 0/0

\[RouterA-GigabitEthernet1/0/1\] ntp-service multicast-client

配置Router B

由于Router A与Router C不在同一网段，所以Router
B上需要配置组播功能，否则Router A收不到Router C发出的组播报文。

\[RouterB\] multicast routing

\[RouterB\] interface gigabitethernet 0/0

\[RouterB-GigabitEthernet1/0/1\] igmp enable

\[RouterB-GigabitEthernet1/0/1\] igmp static-group 224.0.1.1

\[RouterB-GigabitEthernet1/0/1\] quit

\[RouterB\] interface gigabitethernet 0/1

\[RouterB-GigabitEthernet1/0/2\] pim dm

配置Router C

\[RouterC\] ntp-service enable

\[RouterC\] clock protocol ntp

\[RouterC\] ntp-service refclock-master 2

\[RouterC\] interface gigabitethernet 0/0

\[RouterC-GigabitEthernet1/0/1\] ntp-service multicast-server

配置Router D

\[RouterD\] ntp-service enable

\[RouterD\] clock protocol ntp

\[RouterD\] interface gigabitethernet 0/0

\[RouterD-GigabitEthernet1/0/1\] ntp-service multicast-client

## 测试结果：

由于Router D和Router C在同一个网段，不需要配置组播功能，Router
D就可以收到Router C发出的组播报文，并与其同步。同步后查看Router
D的状态。可以看出，Router D已经与Router C同步，层数比Router
C的层数大1，为3。

![](./Media//image1.png)


查看Router D的NTP服务的所有IPv4会话信息，可以看到Router D与Router
C建立了会话。

![](./Media//image2.png)


同步后查看Router A的状态。可以看出，Router A已经与Router
C同步，层数比Router C的层数大1，为3。

![](./Media//image3.png)


查看Router A的NTP服务的所有IPv4会话信息，可以看到Router A与Router
C建立了会话。

![](./Media//image4.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
