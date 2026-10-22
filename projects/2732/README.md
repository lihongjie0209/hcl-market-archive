# 工程名称
V7交换机OSPF路由聚合配置（ASBR）


## 需求：
1、SW1和Route2属于area 0，Route2和Route3属于area 1

2、SW1上import内网192.168.1.1/32-192.168.1.3/32的直连路由

3、SW1作为ASBR，配置路由聚合


## 实验步骤：
1、配置接口ip，以SW1为例
#
interface GigabitEthernet1/0/1
 port link-mode bridge
 port access vlan 10
#  
interface LoopBack1
 ip address 192.168.1.1 255.255.255.255
#
interface LoopBack2
 ip address 192.168.1.2 255.255.255.255
#
interface LoopBack3
 ip address 192.168.1.3 255.255.255.255
#
interface Vlan-interface10
 ip address 10.0.12.1 255.255.255.0
#

2、OSPF基础配置，以SW1为例
#
ospf 1
 import-route direct
 area 0.0.0.0
  network 10.0.12.1 0.0.0.0
#

3、SW1配置聚合
#
ospf 1
 asbr-summary 192.168.1.0 255.255.255.0
#

## 测试结果：
1、配置聚合前Route3查看路由表：
<Route3>dis ip routing-table 
Destinations : 14       Routes : 14
Destination/Mask   Proto   Pre Cost        NextHop         Interface
0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0
10.0.12.0/24       O_INTER 10  2           10.0.23.2       GE0/1
10.0.23.0/24       Direct  0   0           10.0.23.3       GE0/1
10.0.23.3/32       Direct  0   0           127.0.0.1       InLoop0
10.0.23.255/32     Direct  0   0           10.0.23.3       GE0/1
127.0.0.0/8        Direct  0   0           127.0.0.1       InLoop0
127.0.0.1/32       Direct  0   0           127.0.0.1       InLoop0
127.255.255.255/32 Direct  0   0           127.0.0.1       InLoop0
192.168.1.1/32     O_ASE2  150 1           10.0.23.2       GE0/1
192.168.1.2/32     O_ASE2  150 1           10.0.23.2       GE0/1
192.168.1.3/32     O_ASE2  150 1           10.0.23.2       GE0/1
224.0.0.0/4        Direct  0   0           0.0.0.0         NULL0
224.0.0.0/24       Direct  0   0           0.0.0.0         NULL0
255.255.255.255/32 Direct  0   0           127.0.0.1       InLoop0
<Route3>

2、配置聚合后Route3查看路由表：
<Route3>dis ip routing-table 
Destinations : 12       Routes : 12
Destination/Mask   Proto   Pre Cost        NextHop         Interface
0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0
10.0.12.0/24       O_INTER 10  2           10.0.23.2       GE0/1
10.0.23.0/24       Direct  0   0           10.0.23.3       GE0/1
10.0.23.3/32       Direct  0   0           127.0.0.1       InLoop0
10.0.23.255/32     Direct  0   0           10.0.23.3       GE0/1
127.0.0.0/8        Direct  0   0           127.0.0.1       InLoop0
127.0.0.1/32       Direct  0   0           127.0.0.1       InLoop0
127.255.255.255/32 Direct  0   0           127.0.0.1       InLoop0
192.168.1.0/24     O_ASE2  150 1           10.0.23.2       GE0/1
224.0.0.0/4        Direct  0   0           0.0.0.0         NULL0
224.0.0.0/24       Direct  0   0           0.0.0.0         NULL0
255.255.255.255/32 Direct  0   0           127.0.0.1       InLoop0
<Route3>  

## 说明： 
1、路由聚合需在ABR/ASBR上配置

