# OSPFv3 Stub区域配置举例

## 需求：

1.  所有的路由器都运行OSPFv3，整个自治系统划分为3个区域。其中Router
    B和Router C作为ABR来转发区域之间的路由。

2.  要求将Area
    2配置为Stub区域，减少通告到此区域内的LSA数量，但不影响路由的可达性。

## 实验步骤：

1.  配置各接口的IPv6地址

2.  配置OSPFv3基本功能

3.  配置Area 2为Stub区域

以RTC配置为例：

\#

ospfv3 1

router-id 3.3.3.3

area 0.0.0.0

area 0.0.0.2

stub

default-cost 10

\#

## 测试结果：

查看Router
D的OSPFv3路由表信息，可以看到路由表中多了一条缺省路由，它的开销值为直连路由的开销和所配置的开销值之和。

![](./Media//image1.png)


进一步减少Stub区域路由表规模，将Area 2配置为Totally Stub区域

\# 配置Router C，设置Area 2为Totally Stub区域。

\[RouterC-ospfv3-1-area-0.0.0.2\] stub no-summary

\# 查看Router
D的OSPFv3路由表，可以发现路由表项数目减少了，其他非直连路由都被抑制，只有缺省路由被保留。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
