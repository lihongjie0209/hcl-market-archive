# RIP与BFD联动配置举例（指定目的地址的echo报文单跳检测）

## 需求：

> •     Switch A和Switch B互连，Switch A的接口Vlan-interface100和Switch
> B的接口Vlan-interface100都运行RIP进程1。Switch
> A的接口Vlan-interface100上使能了BFD检测功能，指定目的地址为Switch
> B的接口Vlan-interface100的地址。
>
> •     Switch B与Switch
> C互连，它们的接口Vlan-interface200都运行RIP进程1。
>
> •     Switch A和Switch
> C上配置静态路由，并都将静态路由引入RIP进程中，其中Switch
> A引入路由的cost值比Switch C引入的cost值小，这样，当Switch
> B上学习到Switch A和Switch C发送的路由后，会优选Switch
> A的路由，出接口为与Switch A连接的接口。
>
> •     在Switch A和Switch B之间的链路发生单通故障（从Switch A到Switch
> B方向报文是通的，但是从Switch B到Switch A方向的链路不通）后，Switch
> A上BFD能够快速检测链路故障并通告RIP协议。Switch
> A上的RIP协议响应BFD会话down，删除从接口Vlan-interface100学习到的邻居和路由，并不再从该接口接收和发送RIP报文。Switch
> B上在学自Switch A的路由老化后，会优选Switch
> C发送的静态路由，出接口为与Switch C连接的接口。

## 组网 

> RIP与BFD联动配置组网图（指定目的地址的echo报文单跳检测）
>
> ![https://resource.h3c.com/cn/202207/06/20220706_7458130_x\_Img_x\_png_9\_1644578_30005_0.png](./Media//image1.png)
> 

##  实验步骤：

\(1\) 配置各接口的IP地址（略）

\(2\) 配置RIP基本功能并且在接口上使能BFD

\# 配置Switch A。

\<SwitchA\> system-view

\[SwitchA\] rip 1

\[SwitchA-rip-1\] network 192.168.2.0

\[SwitchA-rip-1\] import-route static

\[SwitchA-rip-1\] quit

\[SwitchA\] interface vlan-interface 100

\[SwitchA-Vlan-interface100\] rip bfd enable destination 192.168.2.2

\[SwitchA-Vlan-interface100\] quit

\# 配置Switch B。

\<SwitchB\> system-view

\[SwitchB\] rip 1

\[SwitchB-rip-1\] network 192.168.2.0

\[SwitchB-rip-1\] network 192.168.3.0

\[SwitchB-rip-1\] quit

\# 配置Switch C。

\<SwitchC\> system-view

\[SwitchC\] rip 1

\[SwitchC-rip-1\] network 192.168.3.0

\[SwitchC-rip-1\] import-route static cost 3

\[SwitchC-rip-1\] quit

\(3\) 配置接口BFD参数

\# 配置Switch A。

\[SwitchA\] bfd echo-source-ip 11.11.11.11

\[SwitchA\] interface vlan-interface 100

\[SwitchA-Vlan-interface100\] bfd min-echo-receive-interval 500

\[SwitchA-Vlan-interface100\] return

\(4\) 配置静态路由

\# 配置Switch A。

\[SwitchA\] ip route-static 100.1.1.0 24 null 0

\# 配置Switch C。

\[SwitchC\] ip route-static 100.1.1.0 24 null 0

## 测试结果：

\# 查看Switch A的BFD信息。

![](./Media//image2.png)


\# 显示Switch B上学到的路由100.1.1.0/24。

![](./Media//image3.png)


当 Switch A和Switch B之间的链路发生故障时：

\# 显示Switch B上学到的路由100.1.1.0/24。

![](./Media//image4.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
