# Ospfv3 nssa配置（交换）

## 需求：

所有的交换机都运行OSPFv3，整个自治系统划分为3 个区域。其中Switch B
和Switch C 作为ABR 来转发区域之间的路由。

要求将Area 1 配置为NSSA 区域，同时将Switch A 配置为ASBR
引入外部路由（静态路由），且路由信息可正确的在AS 内传播。

##  实验步骤：

(1)  配置各接口的IP地址

\(2\) 配置 OSPFv3 基本功能


## 测试结果：

配置 Area 1 为NSSA 区域

\# 配置Switch A 的NSSA 区域。

\[SwitchA\] ospfv3

\[SwitchA-ospfv3-1\] area 1

\[SwitchA-ospfv3-1-area-0.0.0.1\] nssa

\[SwitchA-ospfv3-1-area-0.0.0.1\] quit

\[SwitchA-ospfv3-1\] quit

\# 配置Switch B 的NSSA 区域。

\[SwitchB\] ospfv3

\[SwitchB-ospfv3-1\] area 1

\[SwitchB-ospfv3-1-area-0.0.0.1\] nssa

\[SwitchB-ospfv3-1-area-0.0.0.1\] quit

\[SwitchB-ospfv3-1\] quit

\# 查看Switch D 的OSPFv3 路由表信息。

![](./Media//image1.png)


配置 Switch A 引入静态路由

\# 配置Switch A 上的静态路由，并配置OSPFv3 引入静态路由。

\[SwitchA\] ipv6 route-static 1234:: 64 null 0

\[SwitchA\] ospfv3 1

\[SwitchA-ospfv3-1\] import-route static

\[SwitchA-ospfv3-1\] quit

\# 查看Switch D 的OSPFv3 路由表，可以看到NSSA 区域引入的一条AS
外部的路由。

![](./Media//image2.png)


![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
