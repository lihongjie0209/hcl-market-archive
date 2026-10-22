# BGP负载分担配置

## 需求：

所有路由器都配置BGP，Router A在AS 65008中，Router B和Router C在AS
65009中。

Router A与Router B、Router C之间运行EBGP，Router B和Router
C之间运行IBGP。

在Router A上配置负载分担的路由条数为2，以提高链路利用率。

## 实验步骤：

1.  配置各接口的IP地址

2.  配置BGP连接

3.  配置负载分担

因为Router A有两条路径到达AS 65009的内部网络，所以，可以在Router
A配置负载分担的路由条数为2，以提高链路利用率。

\# 配置Router A。

\[RouterA\] bgp 65008

\[RouterA-bgp-default\] address-family ipv4 unicast

\[RouterA-bgp-default-ipv4\] balance 2

\[RouterA-bgp-default-ipv4\] quit

\[RouterA-bgp-default\] quit

## 测试结果：

查看Router A的BGP路由表。

![](./Media//image2.png)


从BGP路由表中可以看到，BGP路由9.1.1.0/24存在两个下一跳，分别是3.1.1.1和3.1.2.1，两条路由前都有标志"\>"，表明它们都是当前有效的最优路由。

使用display ip
routing-table命令查看IP路由表项，可以看出到达目的地址9.1.1.0/24的路由有两条，其中一条的下一跳地址为3.1.1.1，出接口为GigabitEthernet0/0；另一条的下一跳地址为3.1.2.1，出接口为GigabitEthernet0/1。

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
