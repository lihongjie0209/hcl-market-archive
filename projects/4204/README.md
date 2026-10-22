# 工程名称
V7交换机vlan划分


## 需求：
1、内网划分3个vlan，分别为vlan3、vlan4、vlan5

2、内网网关均在核心交换机上

3、PC1划分到vlan3、PC2划分到vlan4、PC3划分到vlan5



## 实验步骤：
1、接入交换机和核心交换机都创建vlan3、vlan4、vlan5

#
vlan 3 to 5
#

2、接入交换机将链接pc的接口配置为access接口，按需求分别划分到各vlan
#
interface GigabitEthernet1/0/3
 port link-mode bridge
 port access vlan 3
#              
interface GigabitEthernet1/0/4
 port link-mode bridge
 port access vlan 4
#
interface GigabitEthernet1/0/5
 port link-mode bridge
 port access vlan 5
#


3、接入交换机连接核心交换机的接口配置为trunk接口，放行vlan3、4、5，并禁止vlan1通过
#
interface GigabitEthernet1/0/1
 port link-mode bridge
 port link-type trunk
 undo port trunk permit vlan 1
 port trunk permit vlan 3 to 5
#


4、核心交换机连接接入交换机的接口配置为trunk接口，放行vlan3、4、5，并禁止vlan1通过
#
interface GigabitEthernet1/0/1
 port link-mode bridge
 port link-type trunk
 undo port trunk permit vlan 1
 port trunk permit vlan 3 to 5
#


5、核心交换机分别创建vlan-int3、vlan-int4、vlan-int5，并配置ip地址
#
interface Vlan-interface3
 ip address 192.168.3.1 255.255.255.0
#
interface Vlan-interface4
 ip address 192.168.4.1 255.255.255.0
#
interface Vlan-interface5
 ip address 192.168.5.1 255.255.255.0
#


## 测试结果：
PC配置同网段地址可以ping通网关
[PC1]ping 192.168.3.1
Ping 192.168.3.1 (192.168.3.1): 56 data bytes, press CTRL+C to break
56 bytes from 192.168.3.1: icmp_seq=0 ttl=255 time=1.000 ms
56 bytes from 192.168.3.1: icmp_seq=1 ttl=255 time=1.000 ms
56 bytes from 192.168.3.1: icmp_seq=2 ttl=255 time=2.000 ms
56 bytes from 192.168.3.1: icmp_seq=3 ttl=255 time=2.000 ms
56 bytes from 192.168.3.1: icmp_seq=4 ttl=255 time=1.000 ms

--- Ping statistics for 192.168.3.1 ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss
round-trip min/avg/max/std-dev = 1.000/1.400/2.000/0.490 ms
[PC1]%Sep 17 20:26:31:545 2022 PC1 PING/6/PING_STATISTICS: Ping statistics for 192.168.3.1: 5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss, round-trip min/avg/max/std-dev = 1.000/1.400/2.000/0.490 ms.

[PC1]

[PC2]ping 192.168.4.1
Ping 192.168.4.1 (192.168.4.1): 56 data bytes, press CTRL+C to break
56 bytes from 192.168.4.1: icmp_seq=0 ttl=255 time=2.000 ms
56 bytes from 192.168.4.1: icmp_seq=1 ttl=255 time=1.000 ms
56 bytes from 192.168.4.1: icmp_seq=2 ttl=255 time=1.000 ms
56 bytes from 192.168.4.1: icmp_seq=3 ttl=255 time=1.000 ms
56 bytes from 192.168.4.1: icmp_seq=4 ttl=255 time=2.000 ms

--- Ping statistics for 192.168.4.1 ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss
round-trip min/avg/max/std-dev = 1.000/1.400/2.000/0.490 ms
%Sep 17 20:26:42:012 2022 PC2 PING/6/PING_STATISTICS: Ping statistics for 192.168.4.1: 5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss, round-trip min/avg/max/std-dev = 1.000/1.400/2.000/0.490 ms.
[PC2]

[PC3]ping 192.168.5.1
Ping 192.168.5.1 (192.168.5.1): 56 data bytes, press CTRL+C to break
56 bytes from 192.168.5.1: icmp_seq=0 ttl=255 time=2.000 ms
56 bytes from 192.168.5.1: icmp_seq=1 ttl=255 time=1.000 ms
56 bytes from 192.168.5.1: icmp_seq=2 ttl=255 time=1.000 ms
56 bytes from 192.168.5.1: icmp_seq=3 ttl=255 time=1.000 ms
56 bytes from 192.168.5.1: icmp_seq=4 ttl=255 time=1.000 ms

--- Ping statistics for 192.168.5.1 ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss
round-trip min/avg/max/std-dev = 1.000/1.200/2.000/0.400 ms
[PC3]%Sep 17 20:26:50:719 2022 PC3 PING/6/PING_STATISTICS: Ping statistics for 192.168.5.1: 5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss, round-trip min/avg/max/std-dev = 1.000/1.200/2.000/0.400 ms.

[PC3]



## 说明： 
1、接终端的接口通常配置为access模式，并划分到对应vlan

2、接入交换机和汇聚/核心交换机互联的接口因为要透传vlan，所以通常配置为trunk模式

3、因为交换机接口默认属于vlan1，因此如果业务没有使用vlan1，建议需要透传vlan的接口禁止vlan1通过


