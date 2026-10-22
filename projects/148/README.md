**标签：**

IRF

nat server

nat outbound

**1、组网需求：**

内网主机192.168.10.1和内网服务器10.1.1.1网关均在核心交换机上，核心交换机相连的接口地址分别为192.168.10.2、10.1.1.2。核心交换机上行是出口防火墙F1090，F1090做IRF，与交换机之前通过三层聚合口6相连，三层聚合口6地址为172.31.1.1，公网口G1/0/2加入三层聚合口5，地址为61.1.1.1。出口防火墙公网口与外部交换机通过三层聚合口5相连，三层聚合口5地址未61.1.1.1，外部交换机与公网服务器11.1.1.2相连。要求：（1）内网主机需要通过出口防火墙做动态NAT转换去访问公网服务器，要求使用公网地址61.1.1.3作为动态地址池地址。（2）出口防火墙上做一条nat
server的映射（61.1.1.4:5456映射内网服务器10.1.1.1:23），使得公网可以访问内网服务器的23端口。

**2、实验步骤：**

网络搭建，路由配置；防火墙配置安全域和安全策略；防火墙上配置NAT
outbound与NAT server。

**3、测试内容及结果：**

（1）主机可以ping通11.1.1.2，防火墙上查看会话可以看到公网服务器回包的目的地址为1.1.1.3。

> \<host\>ping 11.1.1.2
>
> Ping 11.1.1.2 (11.1.1.2): 56 data bytes, press CTRL+C to br eak
>
> 56 bytes from 11.1.1.2: icmp_seq=0 ttl=252 time=2.000 ms
>
> 56 bytes from 11.1.1.2: icmp_seq=1 ttl=252 time=4.000 ms
>
> 56 bytes from 11.1.1.2: icmp_seq=2 ttl=252 time=3.000 ms
>
> 56 bytes from 11.1.1.2: icmp_seq=3 ttl=252 time=4.000 ms
>
> 56 bytes from 11.1.1.2: icmp_seq=4 ttl=252 time=2.000 ms
>
> \-\-- Ping statistics for 11.1.1.2 \-\--
>
> 5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss
>
> 会话：
>
> \<FW\>display session table ipv4 source-ip 192.168.10.1 ve
>
> Slot 1:
>
> Total sessions found: 0
>
> Slot 2:
>
> Initiator:
>
> Source IP/port: 192.168.10.1/10953
>
> Destination IP/port: 11.1.1.2/2048
>
> DS-Lite tunnel peer: -
>
> VPN instance/VLAN ID/Inline ID: -/-/-
>
> Protocol: ICMP(1)
>
> Inbound interface: Route-Aggregation6
>
> Source security zone: Trust
>
> Responder:
>
> Source IP/port: 11.1.1.2/1
>
> Destination IP/port: 61.1.1.3/0
>
> DS-Lite tunnel peer: -
>
> VPN instance/VLAN ID/Inline ID: -/-/-
>
> Protocol: ICMP(1)
>
> Inbound interface: Route-Aggregation5
>
> Source security zone: Untrust
>
> State: ICMP_REPLY
>
> Application: ICMP
>
> Rule ID: 0
>
> Rule name: any
>
> Start time: 2022-01-23 14:59:21 TTL: 11s
>
> Initiator-\>Responder: 5 packets 420 bytes
>
> Responder-\>Initiator: 5 packets 420 bytes
>
> Total sessions found: 1

（2）在公网服务器telnet
61.1.1.4的5456端口可以登录内部服务器10.1.1.1，在防火墙上看会话显示回包的源地址为10.1.1.1。

\<gongwang\>telnet 61.1.1.4 5456

Trying 61.1.1.4 \...

Press CTRL+K to abort

Connected to 61.1.1.4 \...

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

会话：

\<FW\>display session table ipv4 source-ip 11.1.1.2 verbose

Slot 1:

Total sessions found: 0

Slot 2:

Initiator:

Source IP/port: 11.1.1.2/38978

Destination IP/port: 61.1.1.4/5456

DS-Lite tunnel peer: -

VPN instance/VLAN ID/Inline ID: -/-/-

Protocol: TCP(6)

Inbound interface: Route-Aggregation5

Source security zone: Untrust

Responder:

Source IP/port: 10.1.1.1/23

Destination IP/port: 11.1.1.2/38978

DS-Lite tunnel peer: -

VPN instance/VLAN ID/Inline ID: -/-/-

Protocol: TCP(6)

Inbound interface: Route-Aggregation6

Source security zone: Trust

State: TCP_ESTABLISHED

Application: GENERAL_TCP

Rule ID: 0

Rule name: any

Start time: 2022-01-23 15:05:05 TTL: 3565s

Initiator-\>Responder: 41 packets 2220 bytes

Responder-\>Initiator: 40 packets 2578 bytes

Total sessions found: 1

**4、注意事项及说明：**

1、NAT
outbound是在报文的出接口上完成源地址转换，此时是先进行安全策略检查，安全策略检查通过以后才进行NAT转换，所以此处明细的安全策略是需要放通nat转换前的源地址。

2、NAT
server是在报文的入接口上完成目的地址转换，此时是先完成NAT地址转换，然后才进行安全策略检查，所以此处明细的安全策略是需要放通nat转换后的目的地址。

3、双机环境做NAT在组网规划时需要注意规避这两条限制：（1）流量从Slot2入，Slot1出，出口为物理接口或物理子接口做NAT，NAT不能成功转换。规避方案：将物理接口加入逻辑接口（物理子接口可加入冗余口），在逻辑接口上做NAT。（2）双出口在同一个安全域且同时配置NAT
Outbound时，当链路发生切换时，因为不会删会话，若后续流量持续命中该会话，业务不通。规避方案：对于双出口不同NAT的场景，应关闭会话备份；对于双出口相同NAT的场景，应配置冗余组，采用主备方案。

4、本实验用的模拟器版本为3.0.1，防火墙内存设置为800M。

telnet测试账户及密码：admin\\Admin@h3c!
