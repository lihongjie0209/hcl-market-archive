# 工程名称
VPN实例场景下，使用全局NAT实现同时对外和对内提供服务。


## 需求：
1.现场VPN实例，进行内外网隔离。
2.用全局nat来做地址转换。
3.必须保证能对外提供服务，同时内网用户也可以用公网地址访问内部服务器。


## 实验步骤：

1.配置地址和路由。

2.配置防火墙VPN实例。

3.配置防火墙路由，由于外网访问内网跨了VPN实例，因此需要路由打通。

4.配置安全策略和安全域。路由器对接为untrust，对接交换机为trust，并且NAT是会改VPN实例，因此策略上放通untrust到trust，vrf为vpn2，内网为trust到trust，vrf为vpn2。

5.配置全局NAT，注意vrf如果单独写代表的是入接口的VPN实例，用于过滤流量，action后面跟的VRF是转换后的VPN实例，需要写出接口的VPN实例。

## 测试结果：
测试都能ping通。
ping 3.3.3.3

Ping 3.3.3.3 (3.3.3.3): 56 data bytes, press CTRL+C to break

56 bytes from 3.3.3.3: icmp_seq=0 ttl=254 time=1.000 ms

56 bytes from 3.3.3.3: icmp_seq=1 ttl=254 time=1.000 ms

56 bytes from 3.3.3.3: icmp_seq=2 ttl=254 time=2.000 ms

56 bytes from 3.3.3.3: icmp_seq=3 ttl=254 time=2.000 ms

56 bytes from 3.3.3.3: icmp_seq=4 ttl=254 time=1.000 ms


Slot 1:

Initiator:

  Source      IP/port: 1.1.1.1/184

  Destination IP/port: 3.3.3.3/2048

  DS-Lite tunnel peer: -

  VPN instance/VLAN ID/Inline ID: vpn2/-/-

  Protocol: ICMP(1)

  Inbound interface: GigabitEthernet1/0/3

  Source security zone: Trust

Responder:

  Source      IP/port: 1.1.1.2/2

  Destination IP/port: 2.2.2.2/0

  DS-Lite tunnel peer: -

  VPN instance/VLAN ID/Inline ID: vpn2/-/-

  Protocol: ICMP(1)

  Inbound interface: GigabitEthernet1/0/3

  Source security zone: Trust

State: ICMP_REPLY

Application: ICMP

Rule ID: 2

Rule name: vpn2

Start time: 2022-10-12 14:46:22  TTL: 24s

Initiator->Responder:            0 packets          0 bytes

Responder->Initiator:            0 packets          0 bytes


Initiator:

  Source      IP/port: 2.2.2.1/10990

  Destination IP/port: 3.3.3.3/2048

  DS-Lite tunnel peer: -

  VPN instance/VLAN ID/Inline ID: vpn1/-/-

  Protocol: ICMP(1)

  Inbound interface: GigabitEthernet1/0/2

  Source security zone: Untrust

Responder:

  Source      IP/port: 1.1.1.2/10990

  Destination IP/port: 2.2.2.1/0

  DS-Lite tunnel peer: -

  VPN instance/VLAN ID/Inline ID: vpn2/-/-

  Protocol: ICMP(1)

  Inbound interface: GigabitEthernet1/0/3

  Source security zone: Trust

State: ICMP_REPLY

Application: ICMP

Rule ID: 1

Rule name: vpn1

Start time: 2022-10-12 14:46:17  TTL: 19s

Initiator->Responder:            0 packets          0 bytes

Responder->Initiator:            0 packets          0 bytes





## 说明： 

nat也会转换VRF，因此策略匹配上也要考虑VRF转换的情况，同时还要注意NAT是在策略之前还是之后。
