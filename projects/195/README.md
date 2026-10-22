# IS-IS基本功能配置举例

## 需求：

Router A、Router B、Router C和Router
D属于同一自治系统，要求它们之间通过IS-IS协议达到IP网络互连的目的。

Router A和Router B为Level-1路由器，Router D为Level-2路由器，Router
C作为Level-1-2路由器将两个区域相连。Router A、Router B和Router
C的区域号为10，Router D的区域号为20。

## 实验步骤：

1.  配置各接口的IP地址

2.  配置ISIS基本功能

## 测试结果：

显示路由器的邻居（以RTC为例）：

![](./Media//image1.png)


显示各路由器的IS-IS LSDB信息（以RTA为例）。

![](./Media//image2.png)


显示各路由器的IS-IS路由信息。Level-1路由器的路由表中应该有一条缺省路由，且下一跳为Level-1-2路由器，Level-2路由器的路由表中应该有所有Level-1和Level-2的路由。

![](./Media//image3.png)


![](./Media//image4.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
