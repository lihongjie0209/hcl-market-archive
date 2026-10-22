# 工程名称
V7 NGFW使用策略NAT方式实现内网使用公网地址访问内部服务器


## 需求：

出口防火墙将内网Server1 172.16.5.4的tcp 23端口映射到了公网地址100.0.10.1的tcp 1223端口，已经实现公网侧可通过访问100.0.10.1的1223端口来访问172.16.5.4的23端口。现在要求内网PC访问172.16.5.4的23端口时也要使用100.0.10.1的1223端口。


## 实验步骤：
**1、配置接口IP及路由保证内外网各自可以互通**

**2、防火墙配置安全域，将内网口加入trust域**
#
security-zone name Trust
 import interface GigabitEthernet1/0/1
#

**3、防火墙配置nat global-policy，对源地址是内网172.16.5.0/24网段，目的地址是100.0.12.1，目的端口是tcp 1223的流量进行双向地址转换。转换后的目的地址为172.16.5.4，目的端口为tcp 23，转换后的源地址为防火墙内网口地址10.0.12.1**
#
object-group ip address 10.0.12.1
 0 network host address 10.0.12.1
#
object-group ip address 172.16.5.0/24
 0 network subnet 172.16.5.0 255.255.255.0
#
object-group service tcp1223
 0 service tcp destination eq 1223
#
nat global-policy
 rule name nwto172.16.5.4
  service tcp1223
  source-ip 172.16.5.0/24
  destination-ip host 100.0.10.1
  action snat object-group 10.0.12.1
  action dnat ip-address 172.16.5.4 local-port 23
#

**4、防火墙配置安全策略，放行trust到trust，目的地址是172.16.5.4的所有流量**
#
security-policy ip
 rule 1 name nwto172.16.5.4
  action pass
  source-zone trust
  destination-zone trust
#

## 测试结果：
1、PC1可以telnet 100.0.12.1的1223端口登陆到172.16.5.4
<PC1>telnet 100.0.10.1 1223
Trying 100.0.10.1 ...
Press CTRL+K to abort
Connected to 100.0.10.1 ...

******************************************************************************
* Copyright (c) 2004-2021 New H3C Technologies Co., Ltd. All rights reserved.*
* Without the owner's prior written consent,                                 *
* no decompiling or reverse-engineering shall be allowed.                    *
******************************************************************************

Login: telnet
Password: 
<Server1>
<Server1>quit

2、防火墙可以看到NAT会话
[FW1]dis nat session verbose 
Slot 1:
Initiator:
  Source      IP/port: 172.16.5.3/54597
  Destination IP/port: 100.0.10.1/1223
  DS-Lite tunnel peer: -
  VPN instance/VLAN ID/Inline ID: -/-/-
  Protocol: TCP(6)
  Inbound interface: GigabitEthernet1/0/1
  Source security zone: Trust
Responder:
  Source      IP/port: 172.16.5.4/23
  Destination IP/port: 10.0.12.1/1026
  DS-Lite tunnel peer: -
  VPN instance/VLAN ID/Inline ID: -/-/-
  Protocol: TCP(6)
  Inbound interface: GigabitEthernet1/0/1
  Source security zone: Trust
State: TCP_ESTABLISHED
Application: GENERAL_TCP
Rule ID: 1
Rule name: nwto172.16.5.4
Start time: 2022-07-27 21:28:51  TTL: 3586s
Initiator->Responder:            0 packets          0 bytes
Responder->Initiator:            0 packets          0 bytes
## 说明： 

**1、内网使用公网地址访问内部服务器的流量是由内网口进来，再从内网口发出去，所以本案例需要放行trust到trust,目的地址是转换后的ip的流量。**

**2、Server1 telnet用户密码为1qaz2wsx3edc**