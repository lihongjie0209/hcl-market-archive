# 配置NTP广播模式

**标签：**

**NTP**

## 需求

为了实现Router
C作为同一网段中多个设备的时间服务器，同时同步多个设备的时间，要求：

在Router C上设置本地时钟作为参考时钟，层数为2；

Router
C工作在广播服务器模式，从接口GigabitEthernet1/0/1向外广播发送NTP报文；

Router A和Router
B工作在广播客户端模式，分别从各自的接口GigabitEthernet1/0/1监听NTP广播报文。

## 实验步骤：

1、配置各接口的IP地址

2、配置NTP

配置Router A

\#

ntp-service enable

clock protocol ntp

\#

interface gigabitethernet 0/0

ntp-service broadcast-client

\#

配置Router B

\#

ntp-service enable

clock protocol ntp

\#

interface gigabitethernet 0/0

ntp-service broadcast-client

\#

配置Router C

\#

ntp-service enable

clock protocol ntp

ntp-service refclock-master 2

\#

interface gigabitethernet 0/0

ntp-service broadcast-server

\#

## 测试结果：

Router A和Router B接收到Router C发出的广播报文后，与其同步。以Router
A为例，同步后查看Router A的状态。可以看出，Router A已经与Router
C同步，层数比Router C的层数大1，为3。

![](./Media//image1.png)


查看Router A的NTP服务的所有IPv4会话信息，可以看到Router A与Router
C建立了会话。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
