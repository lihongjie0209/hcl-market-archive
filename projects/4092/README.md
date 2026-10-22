# 工程名称

防火墙vpn实例隔离下，配置nat static实现互访。

## 需求：
防火墙配置VPN实例进行内外网隔离，同时又需要单个设备通过NAT static互访。


## 实验步骤：
1.配置IP。

2.配置防火墙vpn实例。

3.配置nat static。

4.配置安全策略安全域，左边为trust，右边为untrust，放通trust-untrust，并且只放通vrf vpn1即可。

5.配置路由。


## 测试结果：

测试可以互通，并且看会话都是进行了地址转换。

Slot 1:

Initiator:

  Source      IP/port: 2.2.2.1/182

  Destination IP/port: 2.2.2.2/2048

  DS-Lite tunnel peer: -

  VPN instance/VLAN ID/Inline ID: vpn2/-/-

  Protocol: ICMP(1)

  Inbound interface: GigabitEthernet1/0/3

  Source security zone: Untrust

Responder:

  Source      IP/port: 1.1.1.1/182

  Destination IP/port: 2.2.2.1/0

  DS-Lite tunnel peer: -

  VPN instance/VLAN ID/Inline ID: vpn1/-/-

  Protocol: ICMP(1)

  Inbound interface: GigabitEthernet1/0/2

  Source security zone: Trust

State: ICMP_REPLY

Application: ICMP

Rule ID: 1

Rule name: natsttic

Start time: 2022-09-14 10:32:19  TTL: 22s

Initiator->Responder:            0 packets          0 bytes

Responder->Initiator:            0 packets          0 bytes


Initiator:

  Source      IP/port: 1.1.1.1/191

  Destination IP/port: 2.2.2.1/2048

  DS-Lite tunnel peer: -

  VPN instance/VLAN ID/Inline ID: vpn1/-/-

  Protocol: ICMP(1)

  Inbound interface: GigabitEthernet1/0/2

  Source security zone: Trust

Responder:

  Source      IP/port: 2.2.2.1/191

  Destination IP/port: 2.2.2.2/0

  DS-Lite tunnel peer: -

  VPN instance/VLAN ID/Inline ID: vpn2/-/-

  Protocol: ICMP(1)

  Inbound interface: GigabitEthernet1/0/3

  Source security zone: Untrust

State: ICMP_REPLY

Application: ICMP

Rule ID: 1

Rule name: natsttic

Start time: 2022-09-14 10:32:15  TTL: 18s

Initiator->Responder:            0 packets          0 bytes

Responder->Initiator:            0 packets          0 bytes

## 说明： 


