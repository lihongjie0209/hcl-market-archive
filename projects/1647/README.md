# OSPFv3快速重路由配置

**标签：**

**OSPFv3**

## 需求

Router A、Router B和Router
C属于同一OSPFv3区域，通过OSPFv3协议实现网络互连。要求当Router A和Router
B之间的链路出现故障时，业务可以快速切换到链路B上。

## 实验步骤：

1、配置各路由器接口的IPv6地址和OSPFv3协议

2、配置OSPFv3快速重路由

\#

ospfv3 1

router-id 1.1.1.1

fast-reroute lfa

area 0.0.0.0

\#

## 测试结果：

在Router A上查看20::1/128的路由信息，可以看到备份下一跳信息。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
