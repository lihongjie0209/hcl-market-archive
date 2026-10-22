**标签：**

Gre

**需求:**

Switch A和Switch B分别连接IPv4私有网络Group 1和Group
2。这两个私有网络都使用私网地址，且属于同一个VPN。通过在Switch A和Switch
B之间建立GRE隧道，实现两个私有网络的互联。

> ![](./Media//image1.png)
> 

**实验步骤：**

在开始下面的配置之前，假设设备各接口的地址都已配置完毕，并且Switch
A和Switch B之间路由可达。

> (1)     配置Switch A

\# 创建业务环回组1，并配置服务类型为Tunnel。

> \<SwitchA\> system-view
>
> \[SwitchA\] service-loopback group 1 type tunnel

\# 将接口Ten-GigabitEthernet1/0/3加入业务环回组1。

> \[SwitchA\] interface gigabitethernet 1/0/3
>
> \[SwitchA-GigabitEthernet1/0/3\] port service-loopback group 1
>
> \[SwitchA- GigabitEthernet1/0/3\] quit

\# 创建Tunnel1接口，并指定隧道模式为GRE over IPv4隧道。

> \[SwitchA\] interface tunnel 1 mode gre

\# 配置Tunnel1接口的IP地址。

> \[SwitchA-Tunnel1\] ip address 10.1.2.1 255.255.255.0

\# 配置Tunnel1接口的源端地址（Switch A的Vlan-interface101的IP地址）。

> \[SwitchA-Tunnel1\] source vlan-interface 101

\# 配置Tunnel1接口的目的端地址（Switch B的Vlan-interface101的IP地址）。

> \[SwitchA-Tunnel1\] destination 2.2.2.2
>
> \[SwitchA-Tunnel1\] quit

\# 配置从Switch A经过Tunnel1接口到Group 2的静态路由。

> \[SwitchA\] ip route-static 10.1.3.0 255.255.255.0 tunnel 1
>
> (2)     配置Switch B

\# 创建业务环回组1，并配置服务类型为Tunnel。

> \<SwitchB\> system-view
>
> \[SwitchB\] service-loopback group 1 type tunnel

\# 将接口Ten-GigabitEthernet1/0/3加入业务环回组1。

> \[SwitchB\] interface gigabitethernet 1/0/3
>
> \[SwitchB- GigabitEthernet1/0/3\] port service-loopback group 1
>
> \[SwitchB-GigabitEthernet1/0/3\] quit

\# 创建Tunnel1接口，并指定隧道模式为GRE over IPv4隧道。

> \[SwitchB\] interface tunnel 1 mode gre

\# 配置Tunnel1接口的IP地址。

> \[SwitchB-Tunnel1\] ip address 10.1.2.2 255.255.255.0

\# 配置Tunnel1接口的源端地址（Switch B的Vlan-interface101的IP地址）。

> \[SwitchB-Tunnel1\] source vlan-interface 101

\# 配置Tunnel1接口的目的端地址（Switch A的Vlan-interface101的IP地址）。

> \[SwitchB-Tunnel1\] destination 1.1.1.1
>
> \[SwitchB-Tunnel1\] quit

\# 配置从Switch B经过Tunnel1接口到Group 1的静态路由。

> \[SwitchB\] ip route-static 10.1.1.0 255.255.255.0 Tunnel 1

**测试结果：**

\# 查看Switch A的Tunnel接口状态。

\[switchA\]dis interface Tunnel 1

Tunnel1

Current state: UP

Line protocol state: UP

Description: Tunnel1 Interface

Bandwidth: 64 kbps

Maximum transmission unit: 1476

Internet address: 10.1.2.1/24 (Primary)

Tunnel source 1.1.1.1 (Vlan-interface101), destination 2.2.2.2

Tunnel keepalive disabled

Tunnel TTL 255

Tunnel protocol/transport GRE/IP

GRE key disabled

Checksumming of GRE packets disabled

Last clearing of counters: Never

Last 300 seconds input rate: 0 bytes/sec, 0 bits/sec, 0 packets/sec

Last 300 seconds output rate: 0 bytes/sec, 0 bits/sec, 0 packets/sec

Input: 0 packets, 0 bytes, 0 drops

Output: 0 packets, 0 bytes, 0 drops

\# 查看Switch B的Tunnel接口状态。

> \[SwitchB\]dis int tu 1
>
> Tunnel1
>
> Current state: UP
>
> Line protocol state: UP
>
> Description: Tunnel1 Interface
>
> Bandwidth: 64 kbps
>
> Maximum transmission unit: 1476
>
> Internet address: 10.1.2.2/24 (Primary)
>
> Tunnel source 2.2.2.2 (Vlan-interface101), destination 1.1.1.1
>
> Tunnel keepalive disabled
>
> Tunnel TTL 255
>
> Tunnel protocol/transport GRE/IP
>
> GRE key disabled
>
> Checksumming of GRE packets disabled
>
> Last clearing of counters: Never
>
> Last 300 seconds input rate: 0 bytes/sec, 0 bits/sec, 0 packets/sec
>
> Last 300 seconds output rate: 0 bytes/sec, 0 bits/sec, 0 packets/sec
>
> Input: 0 packets, 0 bytes, 0 drops
>
> Output: 0 packets, 0 bytes, 0 drops

\# 从Switch B可以Ping通Switch A上Vlan-interface100的地址。

> \[SwitchB\]ping -a 10.1.3.1 10.1.1.1
>
> Ping 10.1.1.1 (10.1.1.1) from 10.1.3.1: 56 data bytes, press CTRL+C to
> break
>
> 56 bytes from 10.1.1.1: icmp_seq=0 ttl=255 time=1.000 ms
>
> 56 bytes from 10.1.1.1: icmp_seq=1 ttl=255 time=0.000 ms
>
> 56 bytes from 10.1.1.1: icmp_seq=2 ttl=255 time=0.000 ms
>
> 56 bytes from 10.1.1.1: icmp_seq=3 ttl=255 time=0.000 ms
>
> 56 bytes from 10.1.1.1: icmp_seq=4 ttl=255 time=0.000 ms
>
> \-\-- Ping statistics for 10.1.1.1 \-\--
>
> 5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss
>
> round-trip min/avg/max/std-dev = 0.000/0.200/1.000/0.400 ms
>
> \[SwitchB\]%Aug 3 20:33:13:365 2022 SwitchB PING/6/PING_STATISTICS:
> Ping statistics for 10.1.1.1: 5 packet(s) transmitted, 5 packet(s)
> received, 0.0% packet loss, round-trip min/avg/max/std-dev =
> 0.000/0.200/1.000/0.400 ms.

## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本**。**
