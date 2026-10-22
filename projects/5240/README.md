# 工程名称

防火墙二层旁挂部署

## 需求：

防火墙二层旁挂，并且只有一个接口，实现对流量的检测和阻断。


## 实验步骤：

1.配置IP和路由。

2.交换机配置PBR，2口配置目的地址2.2.2.1，引流到防火墙，5口配置源地址2.2.2.1，引流到防火墙。

3.配置防火墙地址和路由，静态路由指到交换机。

4.配置安全策略和安全域，由于一个接口，放入trust，策略放通同域互通就行。

## 测试结果：

ping正常，并且防火墙有会话。
Slot 1:

Initiator:

  Source      IP/port: 1.1.1.1/167

  Destination IP/port: 2.2.2.1/2048

  DS-Lite tunnel peer: -

  VPN instance/VLAN ID/Inline ID: -/-/-

  Protocol: ICMP(1)

  Inbound interface: GigabitEthernet1/0/2

  Source security zone: Trust

Responder:

  Source      IP/port: 2.2.2.1/167

  Destination IP/port: 1.1.1.1/0

  DS-Lite tunnel peer: -

  VPN instance/VLAN ID/Inline ID: -/-/-

  Protocol: ICMP(1)

  Inbound interface: GigabitEthernet1/0/2

  Source security zone: Trust

State: ICMP_REPLY

Application: ICMP

Rule ID: 0

Rule name: trust_trust

Start time: 2022-10-14 14:25:35  TTL: 25s

Initiator->Responder:            0 packets          0 bytes

Responder->Initiator:            0 packets          0 bytes


## 说明： 


交换机的模拟器存在问题，所以对于这种流量要关闭快转分担，让快转表关心接口。