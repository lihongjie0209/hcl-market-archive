# RIP引入外部路由配置举例交换机

## 需求：

> •     Switch B上运行两个RIP进程：RIP 100和RIP 200。Switch B通过RIP
> 100和Switch A交换路由信息，通过RIP 200和Switch C交换路由信息。
>
> •     在Switch
> B上配置RIP进程200引入外部路由，引入直连路由和RIP进程100的路由，使得Switch
> C能够学习到达10.2.1.0/24和11.1.1.0/24的路由，但Switch
> A不能学习到达12.3.1.0/24和16.4.1.0/24的路由。

## 组网

> RIP引入外部路由配置组网图
>
> ![https://resource.h3c.com/cn/202207/06/20220706_7458124_x\_Img_x\_png_3\_1644578_30005_0.png](./Media//image1.png)
> 

##  实验步骤：

\(1\) 配置各接口的IP地址（略）

\(2\) 配置RIP基本功能

\# 在Switch A上启动RIP进程100，并配置RIP版本号为2。

\<SwitchA\> system-view

\[SwitchA\] rip 100

\[SwitchA-rip-100\] network 10.0.0.0

\[SwitchA-rip-100\] network 11.0.0.0

\[SwitchA-rip-100\] version 2

\[SwitchA-rip-100\] undo summary

\[SwitchA-rip-100\] quit

\# 在Switch
B上启动两个RIP进程，进程号分别为100和200，并配置RIP版本号为2。

\<SwitchB\> system-view

\[SwitchB\] rip 100

\[SwitchB-rip-100\] network 11.0.0.0

\[SwitchB-rip-100\] version 2

\[SwitchB-rip-100\] undo summary

\[SwitchB-rip-100\] quit

\[SwitchB\] rip 200

\[SwitchB-rip-200\] network 12.0.0.0

\[SwitchB-rip-200\] version 2

\[SwitchB-rip-200\] undo summary

\[SwitchB-rip-200\] quit

\# 在Switch C上启动RIP进程200，并配置RIP版本号为2。

\<SwitchC\> system-view

\[SwitchC\] rip 200

\[SwitchC-rip-200\] network 12.0.0.0

\[SwitchC-rip-200\] network 16.0.0.0

\[SwitchC-rip-200\] version 2

\[SwitchC-rip-200\] undo summary

\[SwitchC-rip-200\] quit

\(3\) 配置RIP引入外部路由

\# 在Switch
B配置RIP进程200引入外部路由，引入直连路由和RIP进程100的路由。

\[SwitchB\] rip 200

\[SwitchB-rip-200\] import-route rip 100

\[SwitchB-rip-200\] import-route direct

\[SwitchB-rip-200\] quit

## 测试结果：

SwitchB配置RIP引入外部路由前：

![](./Media//image2.png)


SwitchB配置RIP引入外部路由后：

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
