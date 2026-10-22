# RIP快速重路由配置举例交换机

## 需求：

Switch A、Switch B和Switch C通过RIPv2协议实现网络互连。要求当Switch
A和Switch B之间的链路出现单通故障时，业务可以快速切换到链路B上。

## 组网 

> RIP快速重路由配置组网图
>
> ![https://resource.h3c.com/cn/202207/06/20220706_7458122_x\_Img_x\_png_11_1644578_30005_0.png](./Media//image1.png)
> 

![](./Media//image2.png)


##  实验步骤：

\(1\) 配置各交换机接口的IP地址和RIPv2协议

请按照上面组网图配置各接口的IP地址和子网掩码，具体配置过程略。

配置各交换机之间采用RIPv2协议进行互连，确保Switch A、Switch B和Switch
C之间能够在网络层互通，并且各交换机之间能够借助RIPv2协议实现动态路由更新。

具体配置过程略。

\(2\) 配置RIP 快速重路由

\# 配置Switch A。

\<SwitchA\> system-view

\[SwitchA\] ip prefix-list abc index 10 permit 4.4.4.4 32

\[SwitchA\] route-policy frr permit node 10

\[SwitchA-route-policy-frr-10\] if-match ip address prefix-list abc

\[SwitchA-route-policy-frr-10\] apply fast-reroute backup-interface
vlan-interface 100 backup-nexthop 12.12.12.2

\[SwitchA-route-policy-frr-10\] quit

\[SwitchA\] rip 1

\[SwitchA-rip-1\] fast-reroute route-policy frr

\[SwitchA-rip-1\] quit

\# 配置Switch B。

\<SwitchB\> system-view

\[SwitchB\] ip prefix-list abc index 10 permit 1.1.1.1 32

\[SwitchB\] route-policy frr permit node 10

\[SwitchB-route-policy-frr-10\] if-match ip address prefix-list abc

\[SwitchB-route-policy-frr-10\] apply fast-reroute backup-interface
vlan-interface 101 backup-nexthop 24.24.24.2

\[SwitchB-route-policy-frr-10\] quit

\[SwitchB\] rip 1

\[SwitchB-rip-1\] fast-reroute route-policy frr

\[SwitchB-rip-1\] quit

## 测试结果：

\# 在Switch A上查看4.4.4.4/32路由，可以看到备份下一跳信息：

![](./Media//image3.png)


\# 在Switch B上查看1.1.1.1/32路由，可以看到备份下一跳信息：

![](./Media//image4.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
