# GRE运行动态路由

**标签：**

**GRE**

## 需求

RTA与RTC之间建立GRE隧道，后续需要在RTA，RTC上部署业务，路由希望通过OSPF或ISIS宣告出去。

## 实验步骤：

1、配置各接口的IP地址

2、配置GRE基本功能

3、配置ISIS宣告路由

以RTA为例：

\#

isis 1

is-level level-2

network-entity 10.0000.0000.0001.00

\#

interface LoopBack0

ip address 1.1.1.9 255.255.255.255

isis enable 1

\#

interface Tunnel0 mode gre

ip address 192.168.0.1 255.255.255.252

isis enable 1

source 1.1.1.1

destination 2.2.2.1

\#

## 测试结果：

RTC可以学习到相关路由：

![](./Media//image1.png)


可见GRE可以直接封装ISIS报文：

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
