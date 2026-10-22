# OSPF Stub区域配置举例

## 需求：

1.  所有的路由器都运行OSPF，整个自治系统划分为3个区域。

2.  其中Router A和Router B作为ABR来转发区域之间的路由，Router
    D作为ASBR引入了外部路由（静态路由）。

3.  要求将Area1配置为Stub区域，减少通告到此区域内的LSA数量，但不影响路由的可达性。

## 实验步骤：

1.  配置各接口的IP地址

2.  配置OSPF基本功能

3.  配置特殊区域

## 测试结果：

RTA上存在外部路由。

![](./Media//image1.png)


区域1配置成stub区域后，查看Router
C的OSPF路由表,已经看不到AS外部的路由，取而代之的是一条缺省路由。

![](./Media//image2.png)


配置Area1为Totally Stub区域。

\#

ospf 1

area 0.0.0.0

network 10.1.1.0 0.0.0.255

area 0.0.0.1

network 10.2.1.0 0.0.0.255

stub no-summary

\#

查看Router
C的OSPF路由表，可以看到路由表项进一步减少，只保留了一条通往区域外部的缺省路由。

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
