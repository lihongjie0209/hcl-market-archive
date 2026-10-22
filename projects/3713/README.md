# BGP负载分担配置（交换）

## 需求：

所有交换机都配置BGP，Switch A 在AS 65008 中，Switch B 和Switch C 在AS
65009 中。Switch A 与Switch B、Switch C 之间运行EBGP，Switch B 和Switch
C 之间运行IBGP。在 Switch A
上配置负载分担的路由条数为2，以提高链路利用率。

##  实验步骤：

(1)  配置各接口的IP 地址

\(2\) 配置 BGP 连接


## 测试结果：

\# 查看Switch A 的路由表。从 BGP 路由表中可以看出，到目的地址9.1.1.0/24
有两条有效路由，其中下一跳为3.1.1.1的路由前有标志"\>"，表示它是当前有效的最优路由（因为Switch
B 的路由器ID 要小一些）；而下一跳为3.1.2.1
的路由前有标志"\*"，表示它是当前有效的路由，但不是最优的。

使用 display ip routing-table 命令查看IP 路由表项，可以看出到达目的地址

9.1.1.0/24 的路由只有一条，下一跳地址为3.1.1.1，出接口为Vlan200。

![](./Media//image1.png)


配置负载分担

因为 Switch A 有两条路径到达AS 65009 的内部网络，所以，可以在Switch A
配置负载分担的路由条数为2，以提高链路利用率。

\# 配置Switch A。

\[SwitchA\] bgp 65008

\[SwitchA-bgp-default\] address-family ipv4 unicast

\[SwitchA-bgp-default-ipv4\] balance 2

\[SwitchA-bgp-default-ipv4\] quit

\[SwitchA-bgp-default\] quit

![](./Media//image2.png)


从 BGP 路由表中可以看到，BGP 路由9.1.1.0/24
存在两个下一跳，分别是3.1.1.1
和3.1.2.1，两条路由前都有标志"\>"，表明它们都是当前有效的最优路由。

使用 display ip routing-table 命令查看IP
路由表项，可以看出到达目的地址9.1.1.0/24
的路由有两条，其中一条的下一跳地址为3.1.1.1，出接口为Vlan200；另一条的下一跳地址为3.1.2.1，出接口为Vlan300。

## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
