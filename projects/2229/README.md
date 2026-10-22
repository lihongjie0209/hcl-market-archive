# RIP与BFD联动配置举例（echo报文单跳检测）

## 需求：

> •     Switch A、Switch
> C通过二层交换机互连，它们的接口Vlan-interface100都运行RIP进程1。并且Switch
> A的接口Vlan-interface100上还使能了BFD检测功能。
>
> •     Switch A通过Switch B与Switch C互连，Switch
> A的接口Vlan-interface200运行RIP进程2。Switch
> C的接口Vlan-interface300、Switch
> B的接口Vlan-interface200和Vlan-interface300上都运行RIP进程1。
>
> •     Switch C上配置静态路由，并且将静态路由引入在RIP进程中，使Switch
> C有路由发送至Switch A。Switch A上学习到Switch
> C发送的静态路由，出接口为与二层交换机相连的接口。
>
> •     在Switch
> C和二层交换机之间的链路发生故障后，BFD能够快速检测链路中断并通告RIP协议。RIP协议响应BFD会话down，删除与Switch
> C的邻居，并删除从Switch C学习的路由。Switch A上学习到Switch
> C上发送的静态路由，出接口为与Switch B相连的接口。

## 组网 

> RIP与BFD联动配置组网图（echo报文单跳检测）
>
> ![](./Media//image1.png)
> 

##  实验步骤：

\(1\) 配置各接口的IP地址（略）

\(2\) 配置RIP基本功能

\# 配置Switch A。

\<SwitchA\> system-view

\[SwitchA\] rip 1

\[SwitchA-rip-1\] version 2

\[SwitchA-rip-1\] undo summary

\[SwitchA-rip-1\] network 192.168.1.0

\[SwitchA-rip-1\] quit

\[SwitchA\] interface vlan-interface 100

\[SwitchA-Vlan-interface100\] rip bfd enable

\[SwitchA-Vlan-interface100\] quit

\[SwitchA\] rip 2

\[SwitchA-rip-2\] version 2

\[SwitchA-rip-2\] undo summary

\[SwitchA-rip-2\] network 192.168.2.0

\[SwitchA-rip-2\] quit

\# 配置Switch B。

\<SwitchB\> system-view

\[SwitchB\] rip 1

\[SwitchB-rip-1\] version 2

\[SwitchB-rip-1\] undo summary

\[SwitchB-rip-1\] network 192.168.2.0

\[SwitchB-rip-1\] network 192.168.3.0

\[SwitchB-rip-1\] quit

\# 配置Switch C。

\<SwitchC\> system-view

\[SwitchC\] rip 1

\[SwitchC-rip-1\] version 2

\[SwitchC-rip-1\] undo summary

\[SwitchC-rip-1\] network 192.168.1.0

\[SwitchC-rip-1\] network 192.168.3.0

\[SwitchC-rip-1\] import-route static

\[SwitchC-rip-1\] quit

\(3\) 配置BFD参数

\# 配置Switch A。

\[SwitchA\] bfd echo-source-ip 11.11.11.11

\[SwitchA\] interface vlan-interface 100

\[SwitchA-Vlan-interface100\] bfd min-echo-receive-interval 500

\[SwitchA-Vlan-interface100\] bfd detect-multiplier 7

\[SwitchA-Vlan-interface100\] quit

\[SwitchA\] quit

\(4\) Switch C配置静态路由

\[SwitchC\] ip route-static 120.1.1.1 24 null 0

## 测试结果：

\# 查看Switch A的BFD信息。

![](./Media//image2.png)


\# 查看Switch A上学到的路由120.1.1.0/24，可以看到Switch A经过L2
Switch到达Switch C。

![](./Media//image3.png)


当Switch C和二层交换机之间的链路发生故障时：

\# 查看Switch A上学到的路由120.1.1.0/24，可以看到Switch A经过Switch
B到达Switch C。

![](./Media//image4.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
