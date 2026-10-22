# EIGRP接口开销值配置

**标签：**

**EIGRP**

## 需求

Router A、Router B、Router C、Router D和Router E使用EIGRP进行网络互连。

Router A有两条链路可以到达Router D，其中，通过Router B到达Router
D的链路与通过Router C到达Router
D的链路有相同的带宽值1000000kbps和延时值100微秒。

在Router A的GigabitEthernet0/0上配置接口的EIGRP度量值，使得Router
A优选从Router C学到的1.1.5.0/24网段的路由。

## 实验步骤：

1、配置各接口的IP地址

2、配置EIGRP，以Router A为例：

\#

eigrp 1

\#

address-family ipv4

network 1.1.1.0 0.0.0.3

network 2.1.1.0 0.0.0.255

\#

3、配置EIGRP接口度量值

在Router A上配置接口GigabitEthernet0/1的EIGRP延时为500微秒。

\#

interface GigabitEthernet0/0

ip address 1.1.2.1 255.255.255.0

eigrp 1 metric delay 50

\#

## 测试结果：

在Router A上查看EIGRP拓扑的所有激活路由。

![](./Media//image1.png)


可以看到，配置接口度量值之后，Router A优选Router C作为后继路由器。

## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
