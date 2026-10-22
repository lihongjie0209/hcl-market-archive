# 工程名称

动态路由下的不通VPN实例之间的路由互引

## 需求：
组网如图：
FW与MSR2建立OSPF邻居，与MSR2直连
FW的g1/0/1属于vpn1，g1/0/2属于VPN2
需求，通过动态路由的VPN互引实现MSR3的2.2.2.1可以访问MSR2的11.11.11.11
![动态路由互引.png](./Media/动态路由互引.png)


## 实验步骤：
MSR2
interface GigabitEthernet0/0
 port link-mode route
 combo enable copper
 ip address 1.1.1.1 255.255.255.0

ospf 1
 import-route direct
 area 0.0.0.0
  network 1.1.1.0 0.0.0.255

ip route-static 2.2.2.0 24 1.1.1.2

FW

ip vpn-instance vpn1
 address-family ipv4
  route-replicate from vpn-instance vpn2 protocol direct

ip vpn-instance vpn2
 address-family ipv4
  route-replicate from vpn-instance vpn1 protocol direct advertise
  route-replicate from vpn-instance vpn1 protocol ospf 1 advertise


ospf 1 vpn-instance vpn1
 area 0.0.0.0
  network 1.1.1.0 0.0.0.255

interface GigabitEthernet1/0/1
 port link-mode route
 combo enable copper
 ip binding vpn-instance vpn1
 ip address 1.1.1.2 255.255.255.0

interface GigabitEthernet1/0/2
 port link-mode route
 combo enable copper
 ip binding vpn-instance vpn2
 ip address 2.2.2.2 255.255.255.128

interface GigabitEthernet1/0/21
 port link-mode route
 combo enable copper

interface GigabitEthernet1/0/22
 port link-mode route
 combo enable copper

security-zone name Trust
 import interface GigabitEthernet1/0/1

security-zone name Untrust
 import interface GigabitEthernet1/0/2

security-policy ip
 rule 0 name 0
  action pass
  vrf vpn1
 rule 1 name 1
  action pass
  vrf vpn2



MSR2
interface GigabitEthernet0/0
 port link-mode route
 combo enable copper
 ip address 2.2.2.1 255.255.255.0

ip route-static 1.1.1.0 24 2.2.2.2
 ip route-static 11.11.11.0 24 2.2.2.2



## 测试结果：
实现效果：
在MSR3上可以直接ping通MSR2的loopback地址 11.11.11.11
[MSR3]ping 11.11.11.11
Ping 11.11.11.11 (11.11.11.11): 56 data bytes, press CTRL+C to break
56 bytes from 11.11.11.11: icmp_seq=0 ttl=254 time=2.000 ms
56 bytes from 11.11.11.11: icmp_seq=1 ttl=254 time=0.000 ms
56 bytes from 11.11.11.11: icmp_seq=2 ttl=254 time=2.000 ms
56 bytes from 11.11.11.11: icmp_seq=3 ttl=254 time=0.000 ms
56 bytes from 11.11.11.11: icmp_seq=4 ttl=254 time=1.000 ms

--- Ping statistics for 11.11.11.11 ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss
round-trip min/avg/max/std-dev = 0.000/1.000/2.000/0.894 ms
[MSR3]%Mar 16 15:23:32:968 2022 MSR3 PING/6/PING_STATISTICS: Ping statistics for 11.11.11.11: 5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss, round-trip min/avg/max/std-dev = 0.000/1.000/2.000/0.894 ms.

配置关键点：
route-replicate from { public | vpn-instance vpn-instance name } protocol
{ direct | static | { isis | ospf | rip } process-id } [advertise ]

在vpn实例的IPv4 VPN视图下配置
忽略RT值（即VPN实例中不手工指定RT值），将公网或其他VPN实例的路由信息引入到指定VPN实例中

特别说明一点，公网的VPN有自己的VPN实例
ip public-instance 



## 说明： 

本案例使用HCL模拟器 MSR
