# RIP与BFD联动配置举例（control报文双向检测）

## 需求：

> •     Switch A通过Switch B与Switch C互连。Switch
> A的接口Vlan-interface100和Switch
> C的接口Vlan-interface200上都运行RIP进程1。分别在Switch A和Switch
> C上配置到达对端的静态路由，并在Switch A的接口Vlan-interface100和Switch
> C的接口Vlan-interface200上并使能BFD检测功能。
>
> •     Switch A通过Switch D与Switch C互连。Switch
> A的接口Vlan-interface300运行RIP进程2。Switch
> C的接口Vlan-interface400、Switch
> D的接口Vlan-interface300和Vlan-interface400上运行RIP进程1。
>
> •     为使Switch A与Switch C互有路由发送，在Switch A与Switch
> C上将到达对端的静态路由引入RIP协议中。Switch A与Switch
> C之间建立BFD会话。Switch A上学习到Switch
> C发送的静态路由，出接口为与Switch B连接的接口。
>
> •     在Switch B与Switch
> C之间的链路发生故障后，BFD能够快速检测链路中断并通告RIP协议。RIP协议响应BFD会话down，删除与Switch
> C的邻居，并删除从Switch C学习的路由。Switch A上学习到Switch
> C发送的静态路由，出接口为与Switch D连接的接口。

## 组网 

> RIP与BFD联动配置组网图（control报文双向检测）

![](./Media//image1.png)


##  实验步骤：

\(1\) 配置各接口的IP地址（略）

\(2\) 配置RIP基本功能，并引入静态路由，使Switch A与Switch C互有路由发送

\# 配置Switch A。

\<SwitchA\> system-view

\[SwitchA\] rip 1

\[SwitchA-rip-1\] version 2

\[SwitchA-rip-1\] undo summary

\[SwitchA-rip-1\] network 192.168.1.0

\[SwitchA-rip-1\] network 101.1.1.0

\[SwitchA-rip-1\] peer 192.168.2.2

\[SwitchA-rip-1\] undo validate-source-address

\[SwitchA-rip-1\] import-route static

\[SwitchA-rip-1\] quit

\[SwitchA\] interface vlan-interface 100

\[SwitchA-Vlan-interface100\] rip bfd enable

\[SwitchA-Vlan-interface100\] quit

\[SwitchA\] rip 2

\[SwitchA-rip-2\] version 2

\[SwitchA-rip-2\] undo summary

\[SwitchA-rip-2\] network 192.168.3.0

\[SwitchA-rip-2\] quit

\# 配置Switch C。

\<SwitchC\> system-view

\[SwitchC\] rip 1

\[SwitchC-rip-1\] version 2

\[SwitchC-rip-1\] undo summary

\[SwitchC-rip-1\] network 192.168.2.0

\[SwitchC-rip-1\] network 192.168.4.0

\[SwitchC-rip-1\] network 100.1.1.0

\[SwitchC-rip-1\] peer 192.168.1.1

\[SwitchC-rip-1\] undo validate-source-address

\[SwitchC-rip-1\] import-route static

\[SwitchC-rip-1\] quit

\[SwitchC\] interface vlan-interface 200

\[SwitchC-Vlan-interface200\] rip bfd enable

\[SwitchC-Vlan-interface200\] quit

\# 配置Switch D。

\<SwitchD\> system-view

\[SwitchD\] rip 1

\[SwitchD-rip-1\] version 2

\[SwitchD-rip-1\] undo summary

\[SwitchD-rip-1\] network 192.168.3.0

\[SwitchD-rip-1\] network 192.168.4.0

\(3\) 配置BFD参数

\# 配置Switch A。

\[SwitchA\] bfd session init-mode active

\[SwitchA\] interface vlan-interface 100

\[SwitchA-Vlan-interface100\] bfd min-transmit-interval 500

\[SwitchA-Vlan-interface100\] bfd min-receive-interval 500

\[SwitchA-Vlan-interface100\] bfd detect-multiplier 7

\[SwitchA-Vlan-interface100\] quit

\# 配置Switch C。

\[SwitchC\] bfd session init-mode active

\[SwitchC\] interface vlan-interface 200

\[SwitchC-Vlan-interface200\] bfd min-transmit-interval 500

\[SwitchC-Vlan-interface200\] bfd min-receive-interval 500

\[SwitchC-Vlan-interface200\] bfd detect-multiplier 7

\[SwitchC-Vlan-interface200\] quit

\(4\) 配置静态路由

\# 配置Switch A。

\[SwitchA\] ip route-static 192.168.2.0 24 vlan-interface 100
192.168.1.2

\[SwitchA\] quit

\# 配置Switch C。

\[SwitchC\] ip route-static 192.168.1.0 24 vlan-interface 200
192.168.2.1

## 测试结果：

\# 查看Switch A的BFD信息。

![](./Media//image2.png)


\# 显示Switch A上学到的路由100.1.1.0/24，可以看到Switch A经过Switch
B到达Switch C。

![](./Media//image3.png)


Switch B和Switch C之间的链路发生故障后：

\# 显示Switch A上学到的路由100.1.1.0/24，可以看到Switch A经过Switch
D到达Switch C。

![](./Media//image4.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
