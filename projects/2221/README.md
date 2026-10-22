# RIP发布聚合路由配置举例

## 需求：

> •     Switch A、Switch B运行OSPF，Switch D运行RIP，Switch
> C同时运行OSPF和RIP。
>
> •     在Switch C上配置RIP进程引入OSPF路由，使Switch
> D有到达10.1.1.0/24、10.2.1.0/24、10.5.1.0/24和10.6.1.0/24网段的路由。
>
> •     为了减小Switch D的路由表规模，在Switch
> C上配置路由聚合，只发布聚合后的路由10.0.0.0/8。

## 组网

> RIP发布聚合路由配置组网图
>
> ![](./Media//image1.png)
> 

##  实验步骤：

\(1\) 配置各接口的地址（略）

\(2\) 配置OSPF基本功能

\# 配置Switch A。

\<SwitchA\> system-view

\[SwitchA\] ospf

\[SwitchA-ospf-1\] area 0

\[SwitchA-ospf-1-area-0.0.0.0\] network 10.5.1.0 0.0.0.255

\[SwitchA-ospf-1-area-0.0.0.0\] network 10.2.1.0 0.0.0.255

\[SwitchA-ospf-1-area-0.0.0.0\] quit

\# 配置Switch B。

\<SwitchB\> system-view

\[SwitchB\] ospf

\[SwitchB-ospf-1\] area 0

\[SwitchB-ospf-1-area-0.0.0.0\] network 10.1.1.0 0.0.0.255

\[SwitchB-ospf-1-area-0.0.0.0\] network 10.6.1.0 0.0.0.255

\[SwitchB-ospf-1-area-0.0.0.0\] quit

\# 配置Switch C。

\<SwitchC\> system-view

\[SwitchC\] ospf

\[SwitchC-ospf-1\] area 0

\[SwitchC-ospf-1-area-0.0.0.0\] network 10.1.1.0 0.0.0.255

\[SwitchC-ospf-1-area-0.0.0.0\] network 10.2.1.0 0.0.0.255

\[SwitchC-ospf-1-area-0.0.0.0\] quit

\[SwitchC-ospf-1\] quit

\(3\) 配置RIP基本功能

\# 配置Switch C。

\[SwitchC\] rip 1

\[SwitchC-rip-1\] network 11.3.1.0

\[SwitchC-rip-1\] version 2

\[SwitchC-rip-1\] undo summary

\# 配置Switch D。

\<SwitchD\> system-view

\[SwitchD\] rip 1

\[SwitchD-rip-1\] network 11.0.0.0

\[SwitchD-rip-1\] version 2

\[SwitchD-rip-1\] undo summary

\[SwitchD-rip-1\] quit

\# 在Switch C上配置RIP引入外部路由，引入OSPF进程1的路由和直连路由。

\[SwitchC-rip-1\] import-route direct

\[SwitchC-rip-1\] import-route ospf 1

\[SwitchC-rip-1\] quit

\(4\) 在Switch C上配置路由聚合，只发布聚合路由10.0.0.0/8。

\[SwitchC\] interface vlan-interface 300

\[SwitchC-Vlan-interface300\] rip summary-address 10.0.0.0 8

## 测试结果：

在Switch C上配置路由聚合，只发布聚合路由10.0.0.0/8前：

![](./Media//image2.png)


在Switch C上配置路由聚合，只发布聚合路由10.0.0.0/8后：

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
