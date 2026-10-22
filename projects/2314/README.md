### 静态路由与BFD联动（非直连）配置举例交换机

**标签：**

静态路由

BFD

**需求:**

> •     在Switch A上配置静态路由可以到达120.1.1.0/24网段，在Switch
> B上配置静态路由可以到达121.1.1.0/24网段，并都使能BFD检测功能。
>
> •     在Switch C和Switch
> D上配置静态路由可以到达120.1.1.0/24网段和121.1.1.0/24网段。
>
> •     Switch A存在到Switch
> B的接口Loopback1（2.2.2.9/32）的路由，出接口为Vlan-interface10；Switch
> B存在到Switch
> A的接口Loopback1（1.1.1.9/32）的路由，出接口为Vlan-interface12；Switch
> D存在到1.1.1.9/32的路由，出接口为Vlan-interface10，存在到2.2.2.9/32的路由，出接口为Vlan-interface12。
>
> •     当Switch A和Switch B通过Switch
> D通信的链路出现故障时，BFD能够快速感知，并且切换到Switch C进行通信。 

**实验步骤：**

> (1)     配置各接口的IP地址（略）
>
> (2)     配置静态路由和BFD

\# 在Switch A上配置静态路由，并使能BFD检测功能，使用双向检测方式。

> \<SwitchA\> system-view
>
> \[SwitchA\] bfd multi-hop min-transmit-interval 500
>
> \[SwitchA\] bfd multi-hop min-receive-interval 500
>
> \[SwitchA\] bfd multi-hop detect-multiplier 9
>
> \[SwitchA\] ip route-static 120.1.1.0 24 2.2.2.9 bfd control-packet
> bfd-source 1.1.1.9
>
> \[SwitchA\] ip route-static 120.1.1.0 24 vlan-interface 11 10.1.1.100
> preference 65
>
> \[SwitchA\] quit

\# 在Switch B上配置静态路由，并使能BFD检测功能，使用双向检测方式。

> \<SwitchB\> system-view
>
> \[SwitchB\] bfd multi-hop min-transmit-interval 500
>
> \[SwitchB\] bfd multi-hop min-receive-interval 500
>
> \[SwitchB\] bfd multi-hop detect-multiplier 9
>
> \[SwitchB\] ip route-static 121.1.1.0 24 1.1.1.9 bfd control-packet
> bfd-source 2.2.2.9
>
> \[SwitchB\] ip route-static 121.1.1.0 24 vlan-interface 13 13.1.1.2
> preference 65
>
> \[SwitchB\] quit

\# 在Switch C上配置静态路由。

> \<SwitchC\> system-view
>
> \[SwitchC\] ip route-static 120.1.1.0 24 13.1.1.1
>
> \[SwitchC\] ip route-static 121.1.1.0 24 10.1.1.102

\# 在Switch D上配置静态路由。

> \<SwitchD\> system-view
>
> \[SwitchD\] ip route-static 120.1.1.0 24 11.1.1.1
>
> \[SwitchD\] ip route-static 121.1.1.0 24 12.1.1.1

**测试结果：**

下面以Switch A为例，Switch B和Switch A类似，不再赘述。

\# 查看BFD会话，可以看到BFD会话已经创建。

> \[SwtichA\]dis bfd session
>
> Total Session Num: 1 Up Session Num: 1 Init Mode: Active
>
> IPv4 session working in control packet mode:
>
> LD/RD SourceAddr DestAddr State Holdtime Interface
>
> 34881/34881 1.1.1.9 2.2.2.9 Up 4466ms N/A

\# 查看静态路由，可以看到Switch A经过Switch D到达Switch B。

> \[SwtichA\]dis ip routing-table protocol static
>
> Summary count : 2
>
> Static Routing table status : \<Active\>
>
> Summary count : 2
>
> Destination/Mask Proto Pre Cost NextHop Interface
>
> 2.2.2.9/32 Static 60 0 12.1.1.2 Vlan10
>
> **120.1.1.0/24 Static 60 0 2.2.2.9 Vlan10**

当Switch A和Switch B通过Switch D通信的链路出现故障时：

\# 查看静态路由，可以看到Switch A经过Switch C到达Switch B。

> \[SwtichA\]dis ip routing-table pro static
>
> Summary count : 1
>
> Static Routing table status : \<Active\>
>
> Summary count : 1
>
> Destination/Mask Proto Pre Cost NextHop Interface
>
> 120.1.1.0/24 Static 65 0 10.1.1.100 Vlan11

## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
