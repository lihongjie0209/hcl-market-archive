# IPv6 IS-IS基本组网配置举例

## 需求：

Router A、Router B、Router C和Router
D属于同一自治系统，所有路由器已使能了IPv6能力，要求它们之间通过IPv6
IS-IS协议达到IPv6网络互连的目的。

其中Router A和Router B是Level-1路由器，Router D是Level-2路由器，Router
C是Level-1-2路由器。Router A、Router B和Router C属于区域10，而Router
D属于区域20。

## 实验步骤：

1.  配置各接口的IPv6地址

2.  配置IPv6 ISIS基本功能

## 测试结果：

显示路由器的邻居（以Router A为例）：

![](./Media//image2.png)


查看Router A的IPv6 IS-IS路由表。

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
