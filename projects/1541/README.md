# EIGRP基本功能配置

**标签：**

**EIGRP**

## 需求

Router A和Router B之间通过EIGRP交互路由信息，实现网络互连。

## 实验步骤：

1、配置各接口的IP地址

2、配置EIGRP

配置Router A，创建EIGRP进程1，在指定网段上开启EIGRP。

\#

eigrp 1

\#

address-family ipv4

network 1.1.1.0 0.0.0.3

network 2.1.1.0 0.0.0.255

\#

配置Router B，创建EIGRP进程1，在指定网段上开启EIGRP。

\#

eigrp 1

\#

address-family ipv4

network 1.1.1.0 0.0.0.3

network 3.1.1.0 0.0.0.255

\#

## 测试结果：

查看Router A的EIGRP 1邻居信息。

![](./Media//image1.png)


查看Router A的EIGRP 1的拓扑信息。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
