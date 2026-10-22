# 工程名称
V7交换机OSPF stub区域配置


## 需求：
1、所有的交换机都运行OSPF，整个自治系统划分为3个区域。

2、其中SW2和SW3作为ABR来转发区域之间的路由，SW4作为ASBR引入了外部路由（使用loopback口的直连路由模拟）。

3、要求将Area1配置为Stub区域，减少通告到此区域内的LSA数量，但不影响路由的可达性。


## 实验步骤：
1、配置接口IP，以SW1为例
#
interface GigabitEthernet1/0/1
 port link-mode bridge
 port access vlan 10
#
interface Vlan-interface10
 ip address 10.0.12.1 255.255.255.0
#

2、OSPF基本配置，以SW1为例
#
ospf 1 router-id 1.1.1.1
 area 0.0.0.1
  network 10.0.12.1 0.0.0.0
#

3、配置AREA 1为stub区域
<SW1>dis cu conf ospf
#
ospf 1 router-id 1.1.1.1
 area 0.0.0.1
  network 10.0.12.1 0.0.0.0
  stub
#

<SW2>dis cu conf ospf
#
ospf 1 router-id 1.1.1.2
 area 0.0.0.1
  network 10.0.12.2 0.0.0.0
  stub
#

## 测试结果：
1、area 1配置为stub区域前查看SW1路由表
[SW1]dis ip routing-table 
Destinations : 15       Routes : 15
Destination/Mask   Proto   Pre Cost        NextHop         Interface
0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0
10.0.12.0/24       Direct  0   0           10.0.12.1       Vlan10
10.0.12.0/32       Direct  0   0           10.0.12.1       Vlan10
10.0.12.1/32       Direct  0   0           127.0.0.1       InLoop0
10.0.12.255/32     Direct  0   0           10.0.12.1       Vlan10
10.0.23.0/24       O_INTER 10  2           10.0.12.2       Vlan10
10.0.34.0/24       O_INTER 10  3           10.0.12.2       Vlan10
127.0.0.0/8        Direct  0   0           127.0.0.1       InLoop0
127.0.0.0/32       Direct  0   0           127.0.0.1       InLoop0
127.0.0.1/32       Direct  0   0           127.0.0.1       InLoop0
127.255.255.255/32 Direct  0   0           127.0.0.1       InLoop0
192.168.1.1/32     O_ASE2  150 1           10.0.12.2       Vlan10
224.0.0.0/4        Direct  0   0           0.0.0.0         NULL0
224.0.0.0/24       Direct  0   0           0.0.0.0         NULL0
255.255.255.255/32 Direct  0   0           127.0.0.1       InLoop0
[SW1]

2、area 1配置为stub区域后查看SW1路由表
<SW1>dis ip routing-table 
Destinations : 15       Routes : 15
Destination/Mask   Proto   Pre Cost        NextHop         Interface
0.0.0.0/0          O_INTER 10  2           10.0.12.2       Vlan10
0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0
10.0.12.0/24       Direct  0   0           10.0.12.1       Vlan10
10.0.12.0/32       Direct  0   0           10.0.12.1       Vlan10
10.0.12.1/32       Direct  0   0           127.0.0.1       InLoop0
10.0.12.255/32     Direct  0   0           10.0.12.1       Vlan10
10.0.23.0/24       O_INTER 10  2           10.0.12.2       Vlan10
10.0.34.0/24       O_INTER 10  3           10.0.12.2       Vlan10
127.0.0.0/8        Direct  0   0           127.0.0.1       InLoop0
127.0.0.0/32       Direct  0   0           127.0.0.1       InLoop0
127.0.0.1/32       Direct  0   0           127.0.0.1       InLoop0
127.255.255.255/32 Direct  0   0           127.0.0.1       InLoop0
224.0.0.0/4        Direct  0   0           0.0.0.0         NULL0
224.0.0.0/24       Direct  0   0           0.0.0.0         NULL0
255.255.255.255/32 Direct  0   0           127.0.0.1       InLoop0
<SW1>  

## 说明： 
1、Stub区域是一些特定的区域，该区域的ABR会将区域间的路由信息传递到本区域，但不会引入自治系统外部路由，区域中路由器的路由表规模以及LSA数量都会大大减少。为保证到自治系统外的路由依旧可达，该区域的ABR将生成一条缺省路由Type-3 LSA，发布给本区域中的其他非ABR路由器。

2、如果要配置area 1 为stub区域，那么SW1和SW2都要在area 1 内配置stub

