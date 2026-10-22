# 工程名称
NGFW双机RBM+VRRP主备组网NAT_Server配置实验


## 需求：
FW1、FW2为公网出口设备，在FW1、FW2上配置nat server使公网能够访问内网的SW设备。
为提高业务稳定性，两台FW做RBM+VRRP主备组网，FW1作为主设备，FW2作为备设备。当FW1或其链路发生故障时，由FW2接替FW1继续工作，保证业务不中断。


## 实验步骤：
1、根据组网规划，配置接口的IPV4地址以及路由
2、接口加入安全域，配置安全策略
3、配置静态路由，保证网络可达
4、配置RBM及VRRP
5、配置NAT


## 测试结果：
在公网设备上telnet 100.100.100.4，成功登录到SW上
<Internet>telnet 100.100.100.4
Trying 100.100.100.4 ...
Press CTRL+K to abort
Connected to 100.100.100.4 ...
******************************************************************************
* Copyright (c) 2004-2022 New H3C Technologies Co., Ltd. All rights reserved.*
* Without the owner's prior written consent,                                 *
* no decompiling or reverse-engineering shall be allowed.                    *
******************************************************************************

<SW>     

看当前active设备的会话有报文计数  
RBM_P<FW1>dis session table ipv4 source-ip 100.100.100.100 destination-ip 100.100.100.4 verbose  
Slot 1:  
Initiator:  
  Source      IP/port: 100.100.100.100/6336  
  Destination IP/port: 100.100.100.4/23  
  DS-Lite tunnel peer: -  
  VPN instance/VLAN ID/Inline ID: -/-/-  
  Protocol: TCP(6)  
  Inbound interface: GigabitEthernet1/0/2  
  Source security zone: Untrust  
Responder:  
  Source      IP/port: 192.168.1.254/23  
  Destination IP/port: 100.100.100.100/6336  
  DS-Lite tunnel peer: -  
  VPN instance/VLAN ID/Inline ID: -/-/-  
  Protocol: TCP(6)  
  Inbound interface: GigabitEthernet1/0/1  
  Source security zone: Trust  
State: TCP_ESTABLISHED  
Application: TELNET  
Rule ID: 0  
Rule name: permit-all  
Start time: 2022-09-05 00:05:54  TTL: 1163s  
Initiator->Responder:           19 packets       1054 bytes  
Responder->Initiator:           18 packets       1302 bytes  
  
Total sessions found: 1  

shutdown FW1的g1/0/2接口，使RBM active设备发生切换  
RBM_P[FW1-GigabitEthernet1/0/2]shut
RBM_P[FW1-GigabitEthernet1/0/2]%Sep  5 00:14:43:317 2022 FW1 VRRP4/6/VRRP_STATUS_CHANGE: -Context=1; 
The status of IPv4 virtual router 1 (configured on GigabitEthernet1/0/2) changed from Master to Initialize: Interface event received.
%Sep  5 00:14:43:318 2022 FW1 VRRP4/6/VRRP_STATUS_CHANGE: -Context=1; 
The status of IPv4 virtual router 2 (configured on GigabitEthernet1/0/2) changed from Master to Initialize: Interface event received.
%Sep  5 00:14:43:329 2022 FW1 IFNET/3/PHY_UPDOWN: -Context=1; Physical state on the interface GigabitEthernet1/0/2 changed to down.
%Sep  5 00:14:43:330 2022 FW1 IFNET/5/LINK_UPDOWN: -Context=1; Line protocol state on the interface GigabitEthernet1/0/2 changed to down.
%Sep  5 00:14:43:339 2022 FW1 VRRP4/6/VRRP_STATUS_CHANGE: -Context=1; 
The status of IPv4 virtual router 1 (configured on GigabitEthernet1/0/1) changed from Master to Backup: Controled by RBM.

此时可以在备框看到会话有报文计数
RBM_S<FW2>dis session table ipv4 source-ip 100.100.100.100 destination-ip 100.10
0.100.4 verbose
Slot 1:
Initiator:
  Source      IP/port: 100.100.100.100/6337
  Destination IP/port: 100.100.100.4/23
  DS-Lite tunnel peer: -
  VPN instance/VLAN ID/Inline ID: -/-/-
  Protocol: TCP(6)
  Inbound interface: GigabitEthernet1/0/2
  Source security zone: Untrust
Responder:
  Source      IP/port: 192.168.1.254/23
  Destination IP/port: 100.100.100.100/6337
  DS-Lite tunnel peer: -
  VPN instance/VLAN ID/Inline ID: -/-/-
  Protocol: TCP(6)
  Inbound interface: GigabitEthernet1/0/1
  Source security zone: Trust
State: TCP_ESTABLISHED
Application: TELNET
Rule ID: 0
Rule name: permit-all
Start time: 2022-09-04 23:59:34  TTL: 1191s
Initiator->Responder:           11 packets        638 bytes
Responder->Initiator:           10 packets        982 bytes

Total sessions found: 1


## 说明： 
1、本实验用的模拟器为F1090和S6850，FW的内存为768M。

