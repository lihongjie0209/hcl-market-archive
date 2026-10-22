# 工程名称
V7交换机OSPF NSSA区域配置


## 需求：
1、所有的交换机都运行OSPF，整个自治系统划分为3个区域。

2、其中SW2和SW3作为ABR来转发区域之间的路由。

3、要求将Area1配置为NSSA区域，同时将SW1配置为ASBR引入外部路由（loopback口的直连路由模拟），且路由信息可正确的在AS内传播。


## 实验步骤：
1、配置接口IP,以SW2为例
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
 area 0.0.0.0
  network 10.0.23.2 0.0.0.0
 area 0.0.0.1
  network 10.0.12.2 0.0.0.0
#

3、配置AREA 1为nssa区域
<SW1>dis cu conf ospf
#
ospf 1 router-id 1.1.1.1
 import-route direct
 area 0.0.0.1
  network 10.0.12.1 0.0.0.0
  nssa
#
<SW2>dis cu conf ospf
#
ospf 1 router-id 1.1.1.2
 area 0.0.0.1
  network 10.0.12.2 0.0.0.0
  nssa
#

## 测试结果：
1、area 1配置为nssa区域后查看SW4路由表
<SW4>dis ip routing-table 
Destinations : 15       Routes : 15
Destination/Mask   Proto   Pre Cost        NextHop         Interface
0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0
10.0.12.0/24       O_INTER 10  3           10.0.34.3       Vlan30
10.0.23.0/24       O_INTER 10  2           10.0.34.3       Vlan30
10.0.34.0/24       Direct  0   0           10.0.34.4       Vlan30
10.0.34.0/32       Direct  0   0           10.0.34.4       Vlan30
10.0.34.4/32       Direct  0   0           127.0.0.1       InLoop0
10.0.34.255/32     Direct  0   0           10.0.34.4       Vlan30
127.0.0.0/8        Direct  0   0           127.0.0.1       InLoop0
127.0.0.0/32       Direct  0   0           127.0.0.1       InLoop0
127.0.0.1/32       Direct  0   0           127.0.0.1       InLoop0
127.255.255.255/32 Direct  0   0           127.0.0.1       InLoop0
192.168.1.1/32     O_ASE2  150 1           10.0.34.3       Vlan30
224.0.0.0/4        Direct  0   0           0.0.0.0         NULL0
224.0.0.0/24       Direct  0   0           0.0.0.0         NULL0
255.255.255.255/32 Direct  0   0           127.0.0.1       InLoop0
<SW4>   

## 说明： 
1、NSSA（Not-So-Stubby Area）区域是Stub区域的变形，与Stub区域的区别在于NSSA区域允许引入自治系统外部路由，由ASBR发布Type-7 LSA通告给本区域。当Type-7 LSA到达NSSA的ABR时，由ABR将Type-7 LSA转换成Type-5 LSA，传播到其他区域。

2、如果要配置area 1 为nssa区域，那么SW1和SW2都要在area 1 内配置nssa
