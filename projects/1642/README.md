# RIP引入外部路由配置举例

**标签：**

**RIP**

## 需求

Router B上运行两个RIP进程：RIP 100和RIP 200。Router B通过RIP 100和Router
A交换路由信息，通过RIP 200和Router C交换路由信息。

在Router
B上配置RIP进程200引入外部路由，引入直连路由和RIP进程100的路由，使得Router
C能够学习到达10.2.1.0/24和11.1.1.0/24的路由，但Router
A不能学习到达12.3.1.0/24和16.4.1.0/24的路由。

## 实验步骤：

1、配置各接口的IP地址

2、配置RIP基本功能

3、配置RIP引入外部路由

\#

rip 200

undo summary

version 2

network 12.0.0.0

import-route direct

import-route rip 100

\#

## 测试结果：

查看路由引入后Router C的路由表信息。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
