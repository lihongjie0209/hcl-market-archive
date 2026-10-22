# 工程名称
防火墙用三角传输模式实现负载均衡。


## 需求：
利用防火墙做负载均衡，并且希望不做任何地址转换。
防火墙和后端telnet服务器在同网段，并且不做任何地址转换。防火墙地址为1.1.1.1/24，msr4和msr5模拟telnet服务器，地址1.1.1.4/24和1.1.1.5/24，交换机做内网网关，vlan interface10 地址为1.1.1.2/24.同时和外网msr3连接，模拟客户端访问，地址为3.3.3.1/24.


## 实验步骤：
1.配置地址和路由。

2.配置策略和安全域，只有一个接口放入trust域，放通trust-trust互访和本地发出的local-trust的探测报文。

3.配置实服务器、实服务组和虚服务。

4.配置持续性和健康性检测。开启会话统计。

5.telnet服务相关配置。

6.telnet服务器上配置loopback地址，和vsip相同。




## 测试结果：
测试可以访问，并且多次访问是不同的telnet服务器。同时看防火墙的会话。只有发出去没有任何回包。

<H3C>telnet  5.5.5.5

Trying 5.5.5.5 ...

Press CTRL+K to abort

Connected to 5.5.5.5 ...


************************************************************************                                                                                                                     ******

* Copyright (c) 2004-2021 New H3C Technologies Co., Ltd. All rights rese                                                                                                                    
 rved.*

* Without the owner's prior written consent,                                                                                                                                                      *

* no decompiling or reverse-engineering shall be allowed.                                                                                                                                         *

************************************************************************                                                                                                                     ******


Login: telnet

Password:

<msr5>

<msr5>

<msr5>qu


The connection was closed by the remote host!

<H3C>telnet  5.5.5.5

Trying 5.5.5.5 ...

Press CTRL+K to abort

Connected to 5.5.5.5 ...


************************************************************************                                                                                                                     ******

* Copyright (c) 2004-2021 New H3C Technologies Co., Ltd. All rights rese                                                                                                                     rved.*

* Without the owner's prior written consent,                                                                                                                                                      *

* no decompiling or reverse-engineering shall be allowed.                                                                                                                                         *

************************************************************************                                                                                                                     ******


Login: telnet

Password:

<msr4>qu


[H3C]dis session table ipv4 destination-ip 5.5.5.5 verbose

Slot 1:

Initiator:

  Source      IP/port: 3.3.3.1/38723

  Destination IP/port: 5.5.5.5/23

  DS-Lite tunnel peer: -

  VPN instance/VLAN ID/Inline ID: -/-/-

  Protocol: TCP(6)

  Inbound interface: GigabitEthernet1/0/2

  Source security zone: Trust

Responder:

  Source      IP/port: 5.5.5.5/23

  Destination IP/port: 3.3.3.1/38723

  DS-Lite tunnel peer: -

  VPN instance/VLAN ID/Inline ID: -/-/-

  Protocol: TCP(6)

  Inbound interface: GigabitEthernet1/0/2

  Source security zone: Trust

State: TCP_FIN_WAIT

Application: TELNET

Rule ID: 0

Rule name: trust_trust

Start time: 2022-07-20 09:29:54  TTL: 27s

Initiator->Responder:           79 packets       4215 bytes

Responder->Initiator:            0 packets          0 bytes




## 说明： 

1.三角传输不转地址，但是会转换报文的目的MAC，因此必须保证防火墙和后端服务器二层互通，学到mac地址。

2.三角传输只有单边报文上墙，因此极为消耗性能。

3.三角传输模式极不推荐。非必要情况不要部署现网。
