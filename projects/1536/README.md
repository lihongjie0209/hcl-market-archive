# RIP基本功能配置举例

**标签：**

**RIP**

## 需求

在Router A和Router B的所有接口上使能RIP，以RIP进行路由学习。

## 实验步骤：

1、配置各接口的IP地址

2、使能RIP功能

配置Router A，在指定网段上使能RIP。

\#

rip 1

network 1.0.0.0

network 2.0.0.0

network 3.0.0.0

\#

配置Router B，在指定接口上使能RIP。

\#

rip 1

\#

interface LoopBack0

ip address 10.1.1.1 255.255.255.0

rip 1 enable

\#

interface LoopBack1

ip address 10.2.1.1 255.255.255.0

rip 1 enable

\#

interface GigabitEthernet0/0

ip address 1.1.1.2 255.255.255.0

rip 1 enable

\#

## 测试结果：

查看Router A的RIP路由表。

![](./Media//image1.png)


从路由表中可以看出，RIP-1发布的路由信息使用的是自然掩码。

## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
