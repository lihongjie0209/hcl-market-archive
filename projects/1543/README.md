# EIGRP聚合路由配置

**标签：**

**EIGRP**

## 需求

Router A、Router B运行OSPF，Router D运行EIGRP，Router
C同时运行OSPF和EIGRP。

在Router C上配置EIGRP进程引入OSPF路由，使Router
D有到达10.1.1.0/24、10.2.1.0/24、10.5.1.0/24和10.6.1.0/24网段的路由。

为了减小Router D的路由表规模，在Router
C上配置路由聚合，只发布聚合后的路由10.0.0.0/8。

## 实验步骤：

1、配置各接口的IP地址

2、配置OSPF基本功能

3、配置EIGRP基本功能

4、配置路由聚合

\#

eigrp 1

\#

address-family ipv4

summary automatic

import-route direct

import-route ospf 1

network 11.3.1.0 0.0.0.255

\#

## 测试结果：

查看Router D的拓扑信息，可以看到Router C只发布聚合路由10.0.0.0/8。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
