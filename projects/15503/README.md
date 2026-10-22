# 工程名称
comwareV7防火墙跨VPN实例的静态NAT典型配置


## 需求：
FW上做了静态NAT，并且内外网口都有VPN实例，要实现MSR4通过访问1.1.1.1来实现MSR4访问MSR1的10.0.0.1 
![跨VPN实例NAT.png](./Media/跨VPN实例NAT.png)


## 实验步骤：

MSR1关键配置：
 interface GigabitEthernet0/0
 port link-mode route
 combo enable copper
 ip address 10.0.0.1 255.255.255.0 

 ip route-static 0.0.0.0 0 10.0.0.2 

MSR2关键配置：
interface GigabitEthernet0/0
 port link-mode route 
 combo enable copper
 ip address 10.0.0.2 255.255.255.0

interface GigabitEthernet0/1
 port link-mode route
 combo enable copper
 ip address 10.1.0.1 255.255.255.0 

ip route-static 0.0.0.0 0 10.1.0.2

FW主要配置：
VPN配置：
 ip binding vpn-instance vpn1
 ip binding vpn-instance vpn2

接口配置以及静态NAT配置：
interface GigabitEthernet1/0/1
 port link-mode route
 combo enable copper
 ip binding vpn-instance vpn1
 ip address 10.1.0.2 255.255.255.0 

interface GigabitEthernet1/0/2
 port link-mode route
 combo enable copper
 ip binding vpn-instance vpn2
 ip address 1.1.1.1 255.255.255.0
 nat static enable 

nat static outbound 10.0.0.1 vpn-instance vpn1 1.1.1.1 vpn-instance vpn2

安全域及安全策略配置：
security-zone name Trust
 import interface GigabitEthernet1/0/1 

security-zone name Untrust
 import interface GigabitEthernet1/0/2 

security-policy ip
 rule 0 name 0
 action pass
 vrf vpn1
 source-zone untrust
 destination-zone trust 
 rule 1 name 1 
 action pass
 vrf vpn2
 source-zone untrust
 destination-zone trust

路由配置：
ip route-static vpn-instance vpn1 2.2.2.0 24 vpn-instance vpn2 1.1.1.2 
ip route-static vpn-instance vpn1 10.0.0.0 24 10.1.0.1 
 ip route-static vpn-instance vpn2 2.2.2.0 24 1.1.1.2 
 ip route-static vpn-instance vpn2 10.0.0.0 24 vpn-instance vpn1 10.1.0.1

MSR3关键配置：
interface GigabitEthernet0/0
 port link-mode route
 combo enable copper
 ip address 1.1.1.2 255.255.255.0 

interface GigabitEthernet0/1
 port link-mode route
 combo enable copper
 ip address 2.2.2.1 255.255.255.0 

MSR4关键配置：
interface GigabitEthernet0/1
 port link-mode route 
 combo enable copper
 ip address 2.2.2.2 255.255.255.0 

ip route-static 1.1.1.0 24 2.2.2.1



## 测试结果：

配置完成后，MSR4可以通过访问1.1.1.1来访问10.0.0.1

<MSR>%Apr 22 16:57:34:443 2024 MSR SHELL/5/SHELL_LOGIN: Console logged in from con0.

<MSR>ping 1.1.1.1
Ping 1.1.1.1 (1.1.1.1): 56 data bytes, press CTRL+C to break
56 bytes from 1.1.1.1: icmp_seq=0 ttl=252 time=1.666 ms
56 bytes from 1.1.1.1: icmp_seq=1 ttl=252 time=0.759 ms
56 bytes from 1.1.1.1: icmp_seq=2 ttl=252 time=1.090 ms
56 bytes from 1.1.1.1: icmp_seq=3 ttl=252 time=1.481 ms
56 bytes from 1.1.1.1: icmp_seq=4 ttl=252 time=1.041 ms


<FW>display  session table ipv4 destination-ip 1.1.1.1 verbose
Slot 1:
Initiator:
  Source      IP/port: 2.2.2.2/10951
  Destination IP/port: 1.1.1.1/2048
  DS-Lite tunnel peer: -
  VPN instance/VLAN ID/Inline ID: vpn2/-/-
  Protocol: ICMP(1)
  Inbound interface: GigabitEthernet1/0/2
  Source security zone: Untrust
Responder:
  Source      IP/port: 10.0.0.1/10951
  Destination IP/port: 2.2.2.2/0
  DS-Lite tunnel peer: -
  VPN instance/VLAN ID/Inline ID: vpn1/-/-
  Protocol: ICMP(1)
  Inbound interface: GigabitEthernet1/0/1
  Source security zone: Trust
State: ICMP_REPLY
Application: ICMP
Rule ID: 0
Rule name: 0
Start time: 2024-04-22 16:57:37  TTL: 21s
Initiator->Responder:            5 packets        420 bytes
Responder->Initiator:            5 packets        420 bytes

Total sessions found: 1

配置关键点
配置关键点，主要是防火墙：
1.安全策略中UNtrust-----trust方向策略 在VRF1与VRF2中都要配置，并且VRF1中，源地址是公网地址，目的地址nat global地址；
在VRF2中，源地址是公网地址，目的地址是nat server 的inside地址
2、跨VPN实例的路由要配置
(1)VPN1中要有到10.0.0.1的路由，并且要有到VPN2目的地址为2.2.2.2的路由
ip route-static vpn-instance vpn1 2.2.2.0 24 vpn-instance vpn2 1.1.1.2 
ip route-static vpn-instance vpn1 10.0.0.0 24 10.1.0.1 
(2)VPN2中要有2.2.2.0的路由，并且要有到1VPN1目的地址为10.0.0.1的路由
 ip route-static vpn-instance vpn2 2.2.2.0 24 1.1.1.2 
 ip route-static vpn-instance vpn2 10.0.0.0 24 vpn-instance vpn1 10.1.0.1


## 说明： 

本案例使用HCL模拟器，F1060以及MSR
