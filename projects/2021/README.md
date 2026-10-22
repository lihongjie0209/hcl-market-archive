# 工程名称
V7 NGFW使用策略NAT方式实现目的地址转换或者端口映射


## 需求：
1、通过访问防火墙出口地址100.0.12.3实现访问内网172.16.5.4这台服务器的所有服务
2、通过访问防火墙出口地址100.0.12.2的1123端口实现访问内网172.16.5.5这台服务器的23端


## 实验步骤：
**1、配置接口IP及路由保证内外网各自可以互通**

**2、防火墙配置安全域，将内网口加入trust域，公网口加入untrust域**
#
security-zone name Trust
 import interface GigabitEthernet1/0/2
#
security-zone name Untrust
 import interface GigabitEthernet1/0/1
#

**3、防火墙配置nat global-policy，包含两条规则：①、对来自untrust域，目的地址是100.0.12.3的流量进行目的地址转换，转换后的目的地址为172.16.5.4；②、对来自untrust域，目的地址是100.0.12.2，目的端口是tcp 1123的流量进行目的地址转换，转换后的目的地址为172.16.5.5,目的端口为tcp 23**
#
object-group service tcp1123
 0 service tcp destination eq 1123
#
nat global-policy
 rule name to172.16.5.4
  source-zone untrust
  destination-ip host 100.0.12.3
  action dnat ip-address 172.16.5.4
 rule name to172.16.5.5
  service tcp1123
  source-zone untrust
  destination-ip host 100.0.12.2
  action dnat ip-address 172.16.5.5 local-port 23
#

**4、防火墙配置安全策略，包含两条规则：①、放行untrust到trust，目的地址是172.16.5.4的所有流量；②、放行untrust到trust，目的地址是172.16.5.5，目的端口(服务)是tcp 23(telnet)的流量**
[FW1]dis cu conf security-policy-ip
#
security-policy ip
 rule 1 name to172.16.5.4
  action pass
  source-zone untrust
  destination-zone trust
  destination-ip-host 172.16.5.4 
 rule 5 name to172.16.5.5
  action pass
  source-zone untrust
  destination-zone trust
  destination-ip-host 172.16.5.5 
  service telnet
#

## 测试结果：
1、测试在运营商网络ssh 100.0.12.3可以直接ssh到172.16.5.4
<Internet>ssh 100.0.12.3
Username: ssh
Press CTRL+C to abort.
Connecting to 100.0.12.3 port 22.
The server is not authenticated. Continue? [Y/N]:y
Do you want to save the server public key? [Y/N]:n
ssh@100.0.12.3's password: 
Enter a character ~ and a dot to abort.

******************************************************************************
* Copyright (c) 2004-2021 New H3C Technologies Co., Ltd. All rights reserved.*
* Without the owner's prior written consent,                                 *
* no decompiling or reverse-engineering shall be allowed.                    *
******************************************************************************

<server1>
<server1>quit

Connection to 100.0.12.3 closed.
<Internet>

2、测试在运营商网络ftp 100.0.12.3可以直接ftp登陆到172.16.5.4
<Internet>ftp 100.0.12.3
Press CTRL+C to abort.
Connected to 100.0.12.3 (100.0.12.3).
220 FTP service ready.
User (100.0.12.3:(none)): ftp
331 Password required for ftp.
Password: 
230 User logged in.
Remote system type is UNIX.
Using binary mode to transfer files.
ftp> dir
227 Entering Passive Mode (100,0,12,3,145,187)
150 Accepted data connection
drwxrwxrwx    2 0          0                4096 Jul 27 11:59 diagfile
-rwxrwxrwx    1 0          0                 735 Jul 27 14:51 hostkey
-rwxrwxrwx    1 0          0                 252 Jul 27 15:10 ifindex.dat
-rwxrwxrwx    1 0          0               43136 Jul 27 11:59 licbackup
-rwxrwxrwx    1 0          0               43136 Jul 27 11:59 licnormal
drwxrwxrwx    2 0          0                4096 Jul 27 11:59 logfile
-rwxrwxrwx    1 0          0                   0 Jul 27 11:59 msr36-cmw710-boot-r0424p22.bin
-rwxrwxrwx    1 0          0                   0 Jul 27 11:59 msr36-cmw710-system-r0424p22.bin
drwxrwxrwx    2 0          0                4096 Jul 27 11:59 seclog
-rwxrwxrwx    1 0          0                 591 Jul 27 14:51 serverkey
-rwxrwxrwx    1 0          0                2923 Jul 27 15:10 startup.cfg
-rwxrwxrwx    1 0          0               54307 Jul 27 15:10 startup.mdb
226 12 matches total
ftp> bye
221-Goodbye. You uploaded 0 and downloaded 0 kbytes.
221 Logout.
<Internet>


3、测试在运营商网络telnet 100.0.12.2的1123端口可以直接telnet登陆172.16.5.5
<Internet>telnet 100.0.12.2 1123
Trying 100.0.12.2 ...
Press CTRL+K to abort
Connected to 100.0.12.2 ...

******************************************************************************
* Copyright (c) 2004-2021 New H3C Technologies Co., Ltd. All rights reserved.*
* Without the owner's prior written consent,                                 *
* no decompiling or reverse-engineering shall be allowed.                    *
******************************************************************************

Login: telnet
Password: 
<server2>
<server2>quit

The connection was closed by the remote host!
<Internet>

4、防火墙可以通过dis nat session verbose查看会话
[FW1]dis nat session verbose 
Slot 1:
Initiator:
  Source      IP/port: 100.0.12.1/51968
  Destination IP/port: 100.0.12.3/22
  DS-Lite tunnel peer: -
  VPN instance/VLAN ID/Inline ID: -/-/-
  Protocol: TCP(6)
  Inbound interface: GigabitEthernet1/0/1
  Source security zone: Untrust
Responder:
  Source      IP/port: 172.16.5.4/22
  Destination IP/port: 100.0.12.1/51968
  DS-Lite tunnel peer: -
  VPN instance/VLAN ID/Inline ID: -/-/-
  Protocol: TCP(6)
  Inbound interface: GigabitEthernet1/0/2
  Source security zone: Trust
State: TCP_ESTABLISHED
Application: SSH
Rule ID: 1
Rule name: to172.16.5.4
Start time: 2022-07-27 14:53:59  TTL: 1190s
Initiator->Responder:            0 packets          0 bytes
Responder->Initiator:            0 packets          0 bytes

Initiator:
  Source      IP/port: 100.0.12.1/51970
  Destination IP/port: 100.0.12.2/1123
  DS-Lite tunnel peer: -
  VPN instance/VLAN ID/Inline ID: -/-/-
  Protocol: TCP(6)
  Inbound interface: GigabitEthernet1/0/1
  Source security zone: Untrust
Responder:
  Source      IP/port: 172.16.5.5/23
  Destination IP/port: 100.0.12.1/51970
  DS-Lite tunnel peer: -
  VPN instance/VLAN ID/Inline ID: -/-/-
  Protocol: TCP(6)
  Inbound interface: GigabitEthernet1/0/2
  Source security zone: Trust
State: TCP_ESTABLISHED
Application: GENERAL_TCP
Rule ID: 5
Rule name: to172.16.5.5
Start time: 2022-07-27 14:54:59  TTL: 3597s
Initiator->Responder:            0 packets          0 bytes
Responder->Initiator:            0 packets          0 bytes

Initiator:
  Source      IP/port: 100.0.12.1/51974
  Destination IP/port: 100.0.12.3/21
  DS-Lite tunnel peer: -
  VPN instance/VLAN ID/Inline ID: -/-/-
  Protocol: TCP(6)
  Inbound interface: GigabitEthernet1/0/1
  Source security zone: Untrust
Responder:
  Source      IP/port: 172.16.5.4/21
  Destination IP/port: 100.0.12.1/51974
  DS-Lite tunnel peer: -
  VPN instance/VLAN ID/Inline ID: -/-/-
  Protocol: TCP(6)
  Inbound interface: GigabitEthernet1/0/2
  Source security zone: Trust
State: TCP_ESTABLISHED
Application: FTP
Rule ID: 1
Rule name: to172.16.5.4
Start time: 2022-07-27 15:11:20  TTL: 3597s
Initiator->Responder:            0 packets          0 bytes
Responder->Initiator:            0 packets          0 bytes

## 说明： 
**对于NAT目的地址转换，防火墙处理顺序是原始数据先进行NDAT的转换，再去匹配安全策略，所以DNAT场景安全策略规则放行的是DNAT转换后的目的地址**
