**标签：**

nat outbound

nat server

安全策略

内网主机192.168.10.1和内网服务器10.1.1.1网关均在核心交换机上，核心交换机相连的接口地址分别为192.168.10.2、10.1.1.2。核心交换机上行是出口防火墙F1090，内网口G1/0/3地址为172.31.1.1，公网口G1/0/2地址为61.1.1.1。出口防火墙公网口与公网服务器61.1.1.2直连。要求：（1）内网主机需要通过出口防火墙做动态NAT转换去访问公网服务器，要求使用公网地址61.1.1.10作为动态地址池地址。（2）出口防火墙上做一条nat
server的映射（61.1.1.6:5456映射内网服务器10.1.1.1:23），使得公网可以访问内网服务器的23端口。

**2、实验步骤：**

网络搭建，路由配置；防火墙配置安全域和安全策略；防火墙上配置NAT
outbound与NAT server。

**3、测试内容及结果：**

（1）主机可以ping通61.1.1.2，防火墙上查看会话可以看到公网服务器回包的目的地址为61.1.1.10。

\<host\>ping 61.1.1.2

Ping 61.1.1.2 (61.1.1.2): 56 data bytes, press CTRL+C to break

56 bytes from 61.1.1.2: icmp_seq=0 ttl=253 time=2.000 ms

56 bytes from 61.1.1.2: icmp_seq=1 ttl=253 time=2.000 ms

56 bytes from 61.1.1.2: icmp_seq=2 ttl=253 time=1.000 ms

56 bytes from 61.1.1.2: icmp_seq=3 ttl=253 time=1.000 ms

56 bytes from 61.1.1.2: icmp_seq=4 ttl=253 time=1.000 ms

\-\-- Ping statistics for 61.1.1.2 \-\--

5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss

> 会话：

\<F1090\>display session table ipv4 source-ip 192.168.10.1 verbose

Slot 1:

Initiator:

Source IP/port: 192.168.10.1/10993

Destination IP/port: 61.1.1.2/2048

DS-Lite tunnel peer: -

VPN instance/VLAN ID/Inline ID: -/-/-

Protocol: ICMP(1)

Inbound interface: GigabitEthernet1/0/3

Source security zone: Trust

Responder:

Source IP/port: 61.1.1.2/5

Destination IP/port: 61.1.1.10/0

DS-Lite tunnel peer: -

VPN instance/VLAN ID/Inline ID: -/-/-

Protocol: ICMP(1)

Inbound interface: GigabitEthernet1/0/2

Source security zone: Untrust

State: ICMP_REPLY

Application: ICMP

Rule ID: 0

Rule name: 1

Start time: 2022-01-22 10:53:52 TTL: 27s

Initiator-\>Responder: 5 packets 420 bytes

Responder-\>Initiator: 5 packets 420 bytes

Total sessions found: 1

（2）在公网服务器telnet
61.1.1.6的5456端口可以登录内部服务器10.1.1.1，在防火墙上看会话显示回包的源地址为10.1.1.1。

\<gongwang\>telnet 61.1.1.6 5456

Trying 61.1.1.6 \...

Press CTRL+K to abort

Connected to 61.1.1.6 \...

\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*

\* Copyright (c) 2004-2021 New H3C Technologies Co., Ltd. All rights
reserved.\*

\* Without the owner\'s prior written consent, \*

\* no decompiling or reverse-engineering shall be allowed. \*

\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*

Login: admin

Password:

\<neiwang\>

\<neiwang\>

\<neiwang\>

> 会话：

\<F1090\>display session table ipv4 source-ip 61.1.1.2 verbose

Slot 1:

Initiator:

Source IP/port: 61.1.1.2/2119

Destination IP/port: 61.1.1.6/5456

DS-Lite tunnel peer: -

VPN instance/VLAN ID/Inline ID: -/-/-

Protocol: TCP(6)

Inbound interface: GigabitEthernet1/0/2

Source security zone: Untrust

Responder:

Source IP/port: 10.1.1.1/23

Destination IP/port: 61.1.1.2/2119

DS-Lite tunnel peer: -

VPN instance/VLAN ID/Inline ID: -/-/-

Protocol: TCP(6)

Inbound interface: GigabitEthernet1/0/3

Source security zone: Trust

State: TCP_ESTABLISHED

Application: GENERAL_TCP

Rule ID: 0

Rule name: 1

Start time: 2022-01-22 10:57:11 TTL: 3541s

Initiator-\>Responder: 42 packets 2274 bytes

Responder-\>Initiator: 41 packets 2631 bytes

Total sessions found: 1

**4、注意事项及说明：**

1、NAT
outbound是在报文的出接口上完成源地址转换，此时是先进行安全策略检查，安全策略检查通过以后才进行NAT转换，所以此处明细的安全策略是需要放通nat转换前的源地址。

2、NAT
server是在报文的入接口上完成目的地址转换，此时是先完成NAT地址转换，然后才进行安全策略检查，所以此处明细的安全策略是需要放通nat转换后的目的地址。

3、本实验用的模拟器版本为3.0.1，防火墙内存设置为800M。

4、telnet测试账户及密码：admin\\Admin@h3c!
