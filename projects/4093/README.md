# 工程名称

防火墙在VPN实例下配置NAT  outbound。

## 需求：
防火墙做vpn实例隔离，但是需要内网通过nat outbound访问外网。


## 实验步骤：
1.配置IP。

2.配置防火墙VPN实例。

3.配置nat。

4.配置安全策略和安全域，左边为内网trust，右边外网untrust，策略放通trust-untrust，并且vrf配置vpn1即可。


## 测试结果：
测试可以ping通，并且看会话是做了地址转换。

Slot 1:

Initiator:

  Source      IP/port: 1.1.1.1/170

  Destination IP/port: 2.2.2.1/2048

  DS-Lite tunnel peer: -

  VPN instance/VLAN ID/Inline ID: vpn1/-/-

  Protocol: ICMP(1)

  Inbound interface: GigabitEthernet1/0/3

  Source security zone: Trust

Responder:

  Source      IP/port: 2.2.2.1/1

  Destination IP/port: 2.2.2.2/0

  DS-Lite tunnel peer: -

  VPN instance/VLAN ID/Inline ID: vpn2/-/-

  Protocol: ICMP(1)

  Inbound interface: GigabitEthernet1/0/2

  Source security zone: Untrust

State: ICMP_REPLY

Application: ICMP

Rule ID: 1

Rule name: trust_untrust

Start time: 2022-09-14 09:38:02  TTL: 25s

Initiator->Responder:            0 packets          0 bytes

Responder->Initiator:            0 packets          0 bytes




## 说明： 

由于NAT也会转换VPN，并且是在接口就做了，因此去程需要路由指到出接口，回程在接口就做地址转换和VPN转换，因此回程不需要路由。
