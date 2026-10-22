# OSPFv3与BFD联动配置

**标签：**

**OSPFv3**

## 需求

Router A、Router B和Router C上运行OSPFv3，网络层相互可达。

当Router A和Router B通过L2
Switch通信的链路出现故障时BFD能够快速感知通告OSPFv3协议，并且切换到Router
C进行通信。

## 实验步骤：

1、配置各路由器接口的IPv6地址和OSPFv3协议

2、配置BFD功能

\#

interface GigabitEthernet0/0

ospfv3 1 area 0.0.0.0

ospfv3 bfd enable

ipv6 address 2001::1/64

bfd min-transmit-interval 500

bfd min-receive-interval 500

bfd detect-multiplier 7

\#

## 测试结果：

显示Router A的BFD信息。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
