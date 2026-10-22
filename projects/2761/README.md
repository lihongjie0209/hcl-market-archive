# 工程名称
V7交换机OSPF虚连接配置


## 需求：
1、Area 2与Area 0没有直接相连。Area 1被用作传输区域（Transit Area）来连接Area 2和Area 0。SW2和SW3之间配置一条虚连接。

2、配置完成后，SW3能够学到Area 2中的路由。


## 实验步骤：
1、配置接口IP，以SW2为例
#
interface GigabitEthernet1/0/1
 port link-mode bridge
 port access vlan 10
#
interface GigabitEthernet1/0/2
 port link-mode bridge
 port access vlan 20
#
interface Vlan-interface10
 ip address 10.0.12.2 255.255.255.0
#
interface Vlan-interface20
 ip address 10.0.23.2 255.255.255.0
#

2、OSPF基本配置，以SW2为例
#
ospf 1 router-id 1.1.1.2
 area 0.0.0.1
  network 10.0.23.2 0.0.0.0
 area 0.0.0.2
  network 10.0.12.2 0.0.0.0
#

3、SW2和SW3在area 1配置虚连接
<SW2>dis cu conf ospf
#
ospf 1 router-id 1.1.1.2
 area 0.0.0.1
  vlink-peer 1.1.1.3
#
<SW3>dis cu conf ospf
#
ospf 1 router-id 1.1.1.3
 area 0.0.0.1
  vlink-peer 1.1.1.2
#

## 测试结果：
1、配置虚连接前查看SW3路由
<SW3>dis ip routing-table 
Destinations : 16       Routes : 16
Destination/Mask   Proto   Pre Cost        NextHop         Interface
0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0
10.0.23.0/24       Direct  0   0           10.0.23.3       Vlan20
10.0.23.0/32       Direct  0   0           10.0.23.3       Vlan20
10.0.23.3/32       Direct  0   0           127.0.0.1       InLoop0
10.0.23.255/32     Direct  0   0           10.0.23.3       Vlan20
10.0.34.0/24       Direct  0   0           10.0.34.3       Vlan30
10.0.34.0/32       Direct  0   0           10.0.34.3       Vlan30
10.0.34.3/32       Direct  0   0           127.0.0.1       InLoop0
10.0.34.255/32     Direct  0   0           10.0.34.3       Vlan30
127.0.0.0/8        Direct  0   0           127.0.0.1       InLoop0
127.0.0.0/32       Direct  0   0           127.0.0.1       InLoop0
127.0.0.1/32       Direct  0   0           127.0.0.1       InLoop0
127.255.255.255/32 Direct  0   0           127.0.0.1       InLoop0
224.0.0.0/4        Direct  0   0           0.0.0.0         NULL0
224.0.0.0/24       Direct  0   0           0.0.0.0         NULL0
255.255.255.255/32 Direct  0   0           127.0.0.1       InLoop0
<SW3>


2、配置虚连接后查看SW3路由
<SW3>dis ip routing-table 
Destinations : 17       Routes : 17
Destination/Mask   Proto   Pre Cost        NextHop         Interface
0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0
10.0.12.0/24       O_INTER 10  2           10.0.23.2       Vlan20
10.0.23.0/24       Direct  0   0           10.0.23.3       Vlan20
......

## 说明： 
1、所有非骨干区域必须与骨干区域保持连通

2、虚连接是指在两台ABR之间通过一个非骨干区域建立的一条逻辑上的连接通道。它的两端必须是ABR，而且必须在两端同时配置方可生效。为虚连接两端提供一条非骨干区域内部路由的区域称为传输区（Transit Area）

3、Area2与骨干区域之间没有直接相连的物理链路，但可以在ABR上配置虚连接，使Area2通过一条逻辑链路与骨干区域保持连通


