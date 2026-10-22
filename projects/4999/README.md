# 工程名称
防火墙使用全局NAT完成内网通过公网地址访问内网的功能


## 需求：

防火墙使用全局NAT，要去实现外网访问内网1.1.1.2.内网通过公网地址3.3.3.3访问到内网1.1.1.2.

## 实验步骤：
1.配置IP和路由。路由器写静态路由3.3.3.3到防火墙。PC使用网关为防火墙。

2.配置防火墙安全域和安全策略。外网口2口放入untrust，内网口3口放入trust。策略由于全局NAT和接口NAT是一个匹配逻辑，因此源地址转换是在策略之后，策略中地址写转化前的源地址。目的地址转换在策略之前，策略中要写转换后的目的地址。因此外网访问内网是untrust到trust，并且放通目的地址1.1.1.2。对于内网访问的流量放通trust到trust，地址为源地址1.1.1.1，目的地址为1.1.1.2。

3.配置全局NAT。外网配置为源域为untrust，动作只有目的地址转换。内网访问配置源域为trust，动作同时写源地址转换和目的地址转换。

4.实际测试

## 测试结果：

测试外网和内网都能通，并且看会话的确转换正常，策略也匹配正常。
<H3C>ping 3.3.3.3

Ping 3.3.3.3 (3.3.3.3): 56 data bytes, press CTRL_C to break

56 bytes from 3.3.3.3: icmp_seq=0 ttl=254 time=7.000 ms

56 bytes from 3.3.3.3: icmp_seq=1 ttl=254 time=6.000 ms

56 bytes from 3.3.3.3: icmp_seq=2 ttl=254 time=1.000 ms

56 bytes from 3.3.3.3: icmp_seq=3 ttl=254 time=2.000 ms

56 bytes from 3.3.3.3: icmp_seq=4 ttl=254 time=2.000 ms

Slot 1:

Initiator:

  Source      IP/port: 1.1.1.1/171

  Destination IP/port: 3.3.3.3/2048

  DS-Lite tunnel peer: -

  VPN instance/VLAN ID/Inline ID: -/-/-

  Protocol: ICMP(1)

  Inbound interface: GigabitEthernet1/0/3

  Source security zone: Trust

Responder:

  Source      IP/port: 1.1.1.2/2

  Destination IP/port: 2.2.2.2/0

  DS-Lite tunnel peer: -

  VPN instance/VLAN ID/Inline ID: -/-/-

  Protocol: ICMP(1)

  Inbound interface: GigabitEthernet1/0/3

  Source security zone: Trust

State: ICMP_REPLY

Application: ICMP

Rule ID: 2

Rule name: trust_trust

Start time: 2022-10-10 15:11:11  TTL: 10s

Initiator->Responder:            0 packets          0 bytes

Responder->Initiator:            0 packets          0 bytes





外网路由器

[H3C]ping 3.3.3.3

Ping 3.3.3.3 (3.3.3.3): 56 data bytes, press CTRL+C to break

56 bytes from 3.3.3.3: icmp_seq=0 ttl=254 time=2.000 ms

56 bytes from 3.3.3.3: icmp_seq=1 ttl=254 time=1.000 ms

56 bytes from 3.3.3.3: icmp_seq=2 ttl=254 time=1.000 ms

56 bytes from 3.3.3.3: icmp_seq=3 ttl=254 time=1.000 ms

56 bytes from 3.3.3.3: icmp_seq=4 ttl=254 time=0.000 ms



Slot 1:

Initiator:

  Source      IP/port: 2.2.2.1/10969

  Destination IP/port: 3.3.3.3/2048

  DS-Lite tunnel peer: -

  VPN instance/VLAN ID/Inline ID: -/-/-

  Protocol: ICMP(1)

  Inbound interface: GigabitEthernet1/0/2

  Source security zone: Untrust

Responder:

  Source      IP/port: 1.1.1.2/10969

  Destination IP/port: 2.2.2.1/0

  DS-Lite tunnel peer: -

  VPN instance/VLAN ID/Inline ID: -/-/-

  Protocol: ICMP(1)

  Inbound interface: GigabitEthernet1/0/3

  Source security zone: Trust

State: ICMP_REPLY

Application: ICMP

Rule ID: 1

Rule name: untrust_trust

Start time: 2022-10-10 15:12:21  TTL: 9s

Initiator->Responder:            0 packets          0 bytes

Responder->Initiator:            0 packets          0 bytes






## 说明： 

1.全局NAT沿用了接口NAT的策略逻辑，源地址都是先做策略在做转换，目的地址都是先做转发后做策略。
