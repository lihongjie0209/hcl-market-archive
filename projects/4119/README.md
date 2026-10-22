# BGP与BFD联动 

## 需求：

在 AS 200 内使用OSPF 作为IGP 协议，实现AS 内的互通。Switch A 与Switch C
之间建立两条IBGP 连接。当Switch A 与Switch C
之间的两条路径均连通时，Switch C 与1.1.1.0/24 之间的报文使用Switch
A\<－\>Switch B\<－\>Switch C 这条路径转发；当Switch A\<－\>Switch
B\<－\>Switch C 这条路径发生故障时，BFD 能够快速检测并通告BGP
协议，使得Switch A\<－\>Switch D\<－\>Switch C 这条路径能够迅速生效。

##  实验步骤：

\(1\) 配置各接口的IP 地址

\(2\) 配置 OSPF，保证Switch A 和Switch C 之间路由可达

\(3\) Switch A 上的BGP 配置

\# 配置Switch A 和Switch C 建立两条IBGP 连接。

\<SwitchA\> system-view

\[SwitchA\] bgp 200

\[SwitchA-bgp-default\] peer 3.0.2.2 as-number 200

\[SwitchA-bgp-default\] peer 2.0.2.2 as-number 200

\[SwitchA-bgp-default\] address-family ipv4 unicast

\[SwitchA-bgp-default-ipv4\] peer 3.0.2.2 enable

\[SwitchA-bgp-default-ipv4\] peer 2.0.2.2 enable

\[SwitchA-bgp-default-ipv4\] quit

\[SwitchA-bgp-default\] quit

\# 配置当Switch A 与Switch C 之间的两条路径均连通时，Switch C
与1.1.1.0/24 之间的报文使用Switch A\<－\>Switch B\<－\>Switch C
这条路径转发。（在Switch A 上对发布给对等体2.0.2.2 的1.1.1.0/24
路由配置较高的MED 属性值）

定义编号为2000 的IPv4 基本ACL，允许路由1.1.1.0/24 通过。

\[SwitchA\] acl basic 2000

\[SwitchA-acl-ipv4-basic-2000\] rule permit source 1.1.1.0 0.0.0.255

\[SwitchA-acl-ipv4-basic-2000\] quit

定义两个Route-policy，一个名为apply_med_50，为路由1.1.1.0/24 设置MED
属性值为

50；另一个名为apply_med_100，为路由1.1.1.0/24 设置MED 属性值为100。

\[SwitchA\] route-policy apply_med_50 permit node 10

\[SwitchA-route-policy-apply_med_50-10\] if-match ip address acl 2000

\[SwitchA-route-policy-apply_med_50-10\] apply cost 50

\[SwitchA-route-policy-apply_med_50-10\] quit

\[SwitchA\] route-policy apply_med_100 permit node 10

\[SwitchA-route-policy-apply_med_100-10\] if-match ip address acl 2000

\[SwitchA-route-policy-apply_med_100-10\] apply cost 100

\[SwitchA-route-policy-apply_med_100-10\] quit

对发布给对等体3.0.2.2 的路由应用名为apply_med_50
的Route-policy，对发布给对等体

2.0.2.2 的路由应用名为apply_med_100 的Route-policy。

\[SwitchA\] bgp 200

\[SwitchA-bgp-default\] address-family ipv4 unicast

\[SwitchA-bgp-default-ipv4\] peer 3.0.2.2 route-policy apply_med_50
export

\[SwitchA-bgp-default-ipv4\] peer 2.0.2.2 route-policy apply_med_100
export

\[SwitchA-bgp-default-ipv4\] quit

\# 配置当Switch A\<－\>Switch B\<－\>Switch C 这条路径发生故障时，BFD
能够快速检测并通告BGP 协议，使得Switch A\<－\>Switch D\<－\>Switch C
这条路径能够迅速生效。

\[SwitchA-bgp-default\] peer 3.0.2.2 bfd

\[SwitchA-bgp-default\] quit

\(4\) Switch C 上的BGP 配置。

\# 配置Switch A 和Switch C 建立两条IBGP 连接。

\<SwitchC\> system-view

\[SwitchC\] bgp 200

\[SwitchC-bgp-default\] peer 3.0.1.1 as-number 200

\[SwitchC-bgp-default\] peer 2.0.1.1 as-number 200

\[SwitchC-bgp-default\] address-family ipv4 unicast

\[SwitchC-bgp-default-ipv4\] peer 3.0.1.1 enable

\[SwitchC-bgp-default-ipv4\] peer 2.0.1.1 enable

\[SwitchC-bgp-default-ipv4\] quit

\# 配置当Switch A\<－\>Switch B\<－\>Switch C 这条路径发生故障时，BFD
能够快速检测并通

告BGP 协议，使得Switch A\<－\>Switch D\<－\>Switch C
这条路径能够迅速生效。

\[SwitchC-bgp-default\] peer 3.0.1.1 bfd

\[SwitchC-bgp-default\] quit

\[SwitchC\] quit

## 测试结果：

\# 下面以Switch A 为例，Switch C 和Switch A 类似，不再赘述。

\# 显示Switch A 的BFD 信息。

![](./Media//image1.png)


以上显示信息表明：Switch A 和Switch C 之间已经建立了BFD 连接，而且BFD
协议运行正常。

\# 在Switch A 上查看BGP 邻居信息，可以看出Switch A 和Switch C
之间建立两条BGP 连接，且

均处于Established 状态。

![](./Media//image2.png)


\# 在Switch C 上查看1.1.1.0/24 的路由信息，可以看出Switch C 通过Switch
A\<－\>Switch B\<

－\>Switch C 这条路径与1.1.1.0/24 网段通信。

![](./Media//image3.png)


\# Switch A 和Switch B 之间的链路发生故障后，在Switch C 上查看1.1.1.0/24
的路由信息，可以

看出Switch C 通过Switch A\<－\>Switch D\<－\>Switch C
这条路径与1.1.1.0/24 网段通信。

![](./Media//image4.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
