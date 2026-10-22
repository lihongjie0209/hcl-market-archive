# BGP Public AS Only

**标签：**

**BGP**

## 需求

私有AS号是内部使用的AS号，范围为64512～65535（旧规范）。私有AS号主要用于测试网络，一般情况下不需要在公共网络中传播。对公网EBGP邻居传递时，可以通过public-as-only命令去掉私有AS号。

peer
public-as-only命令用来配置向指定EBGP对等体/对等体组发送BGP更新消息时只携带公有AS号，不携带私有AS号。

## 实验步骤：

1、配置各接口的IP地址

2、配置BGP基本功能

AS 20对外的EBGP邻居配置public-as-only参数。

\#

bgp 20

peer 1.1.1.1 as-number 10

peer 2.2.2.1 as-number 65001

peer 3.3.3.1 as-number 65002

\#

address-family ipv4 unicast

network 1.1.1.0 255.255.255.0

network 2.2.2.0 255.255.255.0

network 3.3.3.0 255.255.255.0

peer 1.1.1.1 enable

peer 1.1.1.1 public-as-only

peer 2.2.2.1 enable

peer 3.3.3.1 enable

\#

## 测试结果：

从私有AS号传递过来的路由，AS PATH中的私有AS号已经过滤。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
