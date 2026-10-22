# 工程名称
V7 NGFW使用策略NAT方式实现源地址转换


## 需求：

内网vlan4：172.16.4.0/24访问运营商网络时源地址转换成100.0.12.4
内网vlan5：172.16.5.0/24中仅172.16.5.10可以访问运营商网络，源地址转换成100.0.12.5


## 实验步骤：
**1、配置接口IP及路由保证内外网各自可以互通**

**2、防火墙配置安全域，将内网口加入trust域，公网口加入untrust域**
<FW>dis cu conf seczone
#
security-zone name Trust
 import interface GigabitEthernet1/0/2
#
security-zone name Untrust
 import interface GigabitEthernet1/0/1
#

**3、防火墙配置nat global-policy，包含两条规则：①、对trust到untrust，源地址为172.16.4.0/24网段的流量进行SNAT ，转换后的地址为100.0.12.4；②对trust到untrust，源地址为172.16.5.10这个地址的流量进行SNAT ，转换后的地址为100.0.12.5**
#
nat address-group 1
 address 100.0.12.4 100.0.12.4
#
nat global-policy
 rule name snat1
  source-zone trust
  destination-zone untrust
  source-ip subnet 172.16.4.0 24
  action snat address-group 1
 rule name snat2
  source-zone trust
  destination-zone untrust
  source-ip host 172.16.5.10
  action snat static ip-address 100.0.12.5
#
**4、防火墙配置安全策略，放行trust到untrust，源地址为172.16.4.0/24和172.16.5.10的流量**
#
security-policy ip
 rule 1 name trust2untrust
  action pass
  source-zone trust
  destination-zone untrust
  source-ip-host 172.16.5.10
  source-ip-subnet 172.16.4.0 255.255.255.0
#

## 测试结果：
1、PC_4地址为172.16.4.10，可以ping通运营商地址1.1.1.1
[H3C]ping 1.1.1.1
Ping 1.1.1.1 (1.1.1.1): 56 data bytes, press CTRL_C to break
56 bytes from 1.1.1.1: icmp_seq=0 ttl=253 time=2.000 ms
56 bytes from 1.1.1.1: icmp_seq=1 ttl=253 time=1.000 ms
56 bytes from 1.1.1.1: icmp_seq=2 ttl=253 time=2.000 ms
56 bytes from 1.1.1.1: icmp_seq=3 ttl=253 time=3.000 ms
56 bytes from 1.1.1.1: icmp_seq=4 ttl=253 time=1.000 ms

--- Ping statistics for 1.1.1.1 ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss


2、PC_5地址为172.16.5.10，可以ping通运营商地址1.1.1.1
<H3C>ping 1.1.1.1
Ping 1.1.1.1 (1.1.1.1): 56 data bytes, press CTRL_C to break
56 bytes from 1.1.1.1: icmp_seq=0 ttl=253 time=2.000 ms
56 bytes from 1.1.1.1: icmp_seq=1 ttl=253 time=2.000 ms
56 bytes from 1.1.1.1: icmp_seq=2 ttl=253 time=1.000 ms
56 bytes from 1.1.1.1: icmp_seq=3 ttl=253 time=1.000 ms
56 bytes from 1.1.1.1: icmp_seq=4 ttl=253 time=2.000 ms

--- Ping statistics for 1.1.1.1 ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss

3、防火墙可以dis nat session verboose查看到nat会话
<FW>dis nat session verbose
Slot 1:
Initiator:
  Source      IP/port: 172.16.5.10/212
  Destination IP/port: 1.1.1.1/2048
  DS-Lite tunnel peer: -
  VPN instance/VLAN ID/Inline ID: -/-/-
  Protocol: ICMP(1)
  Inbound interface: GigabitEthernet1/0/2
  Source security zone: Trust
Responder:
  Source      IP/port: 1.1.1.1/212
  Destination IP/port: 100.0.12.5/0		//SNAT转换后的地址
  DS-Lite tunnel peer: -
  VPN instance/VLAN ID/Inline ID: -/-/-
  Protocol: ICMP(1)
  Inbound interface: GigabitEthernet1/0/1
  Source security zone: Untrust
State: ICMP_REPLY
Application: ICMP
Rule ID: 1
Rule name: trust2untrust
Start time: 2022-07-26 15:31:08  TTL: 23s
Initiator->Responder:            0 packets          0 bytes
Responder->Initiator:            0 packets          0 bytes

Initiator:
  Source      IP/port: 172.16.4.10/182
  Destination IP/port: 1.1.1.1/2048
  DS-Lite tunnel peer: -
  VPN instance/VLAN ID/Inline ID: -/-/-
  Protocol: ICMP(1)
  Inbound interface: GigabitEthernet1/0/2
  Source security zone: Trust
Responder:
  Source      IP/port: 1.1.1.1/3
  Destination IP/port: 100.0.12.4/0		//SNAT转换后的地址
  DS-Lite tunnel peer: -
  VPN instance/VLAN ID/Inline ID: -/-/-
  Protocol: ICMP(1)
  Inbound interface: GigabitEthernet1/0/1
  Source security zone: Untrust
State: ICMP_REPLY
Application: ICMP
Rule ID: 1
Rule name: trust2untrust
Start time: 2022-07-26 15:31:04  TTL: 19s
Initiator->Responder:            0 packets          0 bytes
Responder->Initiator:            0 packets          0 bytes

Total sessions found: 2
<FW>


4、PC_5修改地址为172.16.5.11后无法ping通运营商地址1.1.1.1
<H3C>ping 1.1.1.1
Ping 1.1.1.1 (1.1.1.1): 56 data bytes, press CTRL_C to break
Request time out

--- Ping statistics for 1.1.1.1 ---
2 packet(s) transmitted, 0 packet(s) received, 100.0% packet loss


## 说明： 
对于NAT源地址转换，防火墙处理顺序是原始数据先匹配安全策略，再进行SNAT的操作，所以SNAT场景安全策略规则放行的是NAT转换前的源ip地址。

