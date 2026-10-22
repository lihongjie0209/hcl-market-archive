# BGP LS配置举例

**标签：**

**BGP LS**

## 需求

所有路由器运行BGP协议，Router A与Router B建立IBGP连接，Router
B分别与Router C和Router D建立IBGP连接。

Router B作为路由反射器，Router A为Router B的客户机。

Router A能够通过Router B学到Router C和Router D发布的LS信息。

## 实验步骤：

1、配置各接口的IP地址，在RTB、RTC和RTD上配置OSPF

2、配置BGP连接

以RTA为例，BGP LS配置如下：

\#

bgp 100

peer 192.1.1.2 as-number 100

\#

address-family link-state

peer 192.1.1.2 enable

\#

在RTC与RTD上配置，将OSPF链路状态分发到BGP。

\#

ospf 1

distribute bgp-ls

area 0.0.0.0

network 0.0.0.0 255.255.255.255

\#

## 测试结果：

查看Router A的LS信息。

![](./Media//image1.png)


可以看出，Router A从Router C和Router D 学到了LS信息。

## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
