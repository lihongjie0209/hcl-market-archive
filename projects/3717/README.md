# Ospfv3 stub配置（交换）

## 需求：

所有的交换机都运行OSPFv3，整个自治系统划分为3 个区域。其中Switch B
和Switch C 作为ABR 来转发区域之间的路由。

要求将Area 2 配置为Stub 区域，减少通告到此区域内的LSA
数量，但不影响路由的可达性。

##  实验步骤：

(1)  配置各接口的IP地址

\(2\) 配置 OSPFv3 基本功能


## 测试结果：

\# 查看Switch B 的OSPFv3 邻居状态。

![](./Media//image1.png)


\# 查看Switch C 的OSPFv3 邻居状态。

![](./Media//image2.png)


\# 查看Switch D 的OSPFv3 路由表信息。

![](./Media//image3.png)


配置 Stub 区域

\# 配置Switch D 的Stub 区域。

\[SwitchD\] ospfv3

\[SwitchD-ospfv3-1\] area 2

\[SwitchD-ospfv3-1-area-0.0.0.2\] stub

\# 配置Switch C 的Stub 区域，设置发送到Stub 区域的缺省路由的开销为10。

\[SwitchC\] ospfv3

\[SwitchC-ospfv3-1\] area 2

\[SwitchC-ospfv3-1-area-0.0.0.2\] stub

\[SwitchC-ospfv3-1-area-0.0.0.2\] default-cost 10

\# 查看Switch D 的OSPFv3
路由表信息，可以看到路由表中多了一条缺省路由，它的开销值为直连路由的开销和所配置的开销值之和。

![](./Media//image4.png)


![](./Media//image5.png)


配置 Totally Stub 区域

\# 配置Switch C，设置Area 2 为Totally Stub 区域。

\[SwitchC-ospfv3-1-area-0.0.0.2\] stub no-summary

\# 查看Switch D 的OSPFv3
路由表，可以发现路由表项数目减少了，其他非直连路由都被抑制，只有缺省路由被保留。

![](./Media//image6.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
