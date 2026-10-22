# 工程名称
route-replicate跨vpn实例路由互引配置案例


## 需求：
PC1、PC2的网关在SW上，分别属于vpn实例vpn1、vpn2，现在需要将vpn1与vpn2的路由表打通，使PC1、PC2能实现互访。


## 实验步骤：
1、配置Vlan-int1、Vlan-int2作为PC1、PC2的网关，分别绑定vpn1、vpn2实例。
2、在vpn1、vpn2的address-family ipv4视图下配置route-replicate将两个vpn实例的直连路由相互引入。


## 测试结果：
vpn1实例路由表
[SW]dis ip ro vpn vpn1

Destinations : 16       Routes : 16

Destination/Mask   Proto   Pre Cost        NextHop         Interface
0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0
127.0.0.0/8        Direct  0   0           127.0.0.1       InLoop0
127.0.0.0/32       Direct  0   0           127.0.0.1       InLoop0
127.0.0.1/32       Direct  0   0           127.0.0.1       InLoop0
127.255.255.255/32 Direct  0   0           127.0.0.1       InLoop0
192.168.1.0/24     Direct  0   0           192.168.1.1     Vlan1
192.168.1.0/32     Direct  0   0           192.168.1.1     Vlan1
192.168.1.1/32     Direct  0   0           127.0.0.1       InLoop0
192.168.1.255/32   Direct  0   0           192.168.1.1     Vlan1
192.168.2.0/24     Direct  0   0           192.168.2.1     Vlan2
192.168.2.0/32     Direct  0   0           192.168.2.1     Vlan2
192.168.2.1/32     Direct  0   0           127.0.0.1       InLoop0
192.168.2.255/32   Direct  0   0           192.168.2.1     Vlan2
224.0.0.0/4        Direct  0   0           0.0.0.0         NULL0
224.0.0.0/24       Direct  0   0           0.0.0.0         NULL0
255.255.255.255/32 Direct  0   0           127.0.0.1       InLoop0

vpn2实例路由表
[SW]dis ip ro vpn vpn2

Destinations : 16       Routes : 16

Destination/Mask   Proto   Pre Cost        NextHop         Interface
0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0
127.0.0.0/8        Direct  0   0           127.0.0.1       InLoop0
127.0.0.0/32       Direct  0   0           127.0.0.1       InLoop0
127.0.0.1/32       Direct  0   0           127.0.0.1       InLoop0
127.255.255.255/32 Direct  0   0           127.0.0.1       InLoop0
192.168.1.0/24     Direct  0   0           192.168.1.1     Vlan1
192.168.1.0/32     Direct  0   0           192.168.1.1     Vlan1
192.168.1.1/32     Direct  0   0           127.0.0.1       InLoop0
192.168.1.255/32   Direct  0   0           192.168.1.1     Vlan1
192.168.2.0/24     Direct  0   0           192.168.2.1     Vlan2
192.168.2.0/32     Direct  0   0           192.168.2.1     Vlan2
192.168.2.1/32     Direct  0   0           127.0.0.1       InLoop0
192.168.2.255/32   Direct  0   0           192.168.2.1     Vlan2
224.0.0.0/4        Direct  0   0           0.0.0.0         NULL0
224.0.0.0/24       Direct  0   0           0.0.0.0         NULL0
255.255.255.255/32 Direct  0   0           127.0.0.1       InLoop0

PC1 ping PC2记录
<H3C>ping 192.168.2.2
Ping 192.168.2.2 (192.168.2.2): 56 data bytes, press CTRL_C to break
56 bytes from 192.168.2.2: icmp_seq=0 ttl=254 time=2.000 ms
56 bytes from 192.168.2.2: icmp_seq=1 ttl=254 time=1.000 ms
56 bytes from 192.168.2.2: icmp_seq=2 ttl=254 time=1.000 ms
56 bytes from 192.168.2.2: icmp_seq=3 ttl=254 time=1.000 ms
56 bytes from 192.168.2.2: icmp_seq=4 ttl=254 time=1.000 ms

--- Ping statistics for 192.168.2.2 ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss
round-trip min/avg/max/std-dev = 1.000/1.200/2.000/0.400 ms
<H3C>%Aug  5 21:21:45:720 2022 H3C PING/6/PING_STATISTICS: Ping statistics for 192.168.2.2: 5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss, round-trip min/avg/max/std-dev = 1.000/1.200/2.000/0.400 ms.


## 说明： 
本实验使用的模拟器为S6850，设置内存为默认。
本实验使用的虚拟PC版本为默认。

