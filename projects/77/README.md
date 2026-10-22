# OSPF NSSA区域配置举例

## 需求：

1.  所有的路由器都运行OSPF，整个自治系统划分为3个区域。

2.  其中Router A和Router B作为ABR来转发区域之间的路由。

3.  要求将Area1配置为NSSA区域，同时将Router
    C配置为ASBR引入外部路由（静态路由），且路由信息可正确的在AS内传播。

## 实验步骤：

1.  配置各接口的IP地址

2.  配置OSPF基本功能

3.  配置特殊区域

## 测试结果：

配置Router C引入静态路由。

\#

ip route-static 3.1.2.0 24 NULL0

\#

ospf 1

import-route static

area 0.0.0.1

network 10.2.1.0 0.0.0.255

network 10.4.1.0 0.0.0.255

nssa

\#

查看Router A的OSPF路由表，可以看到NSSA区域引入了一条AS外部路由。

![](./Media//image2.png)


查看Router B的OSPF路由表，可以看到存在一条AS外部路由，即Router
A完成了LSA 7转5。

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
