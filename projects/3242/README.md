# 工程名称
V7交换机BGP路由聚合配置


## 需求：
SW1上存在多个网段，在SW2上配置路由聚合，将1.1.1.1/32、1.1.1.2/32、1.1.1.3/32三条明细路由聚合为1.1.1.0/24再发布给SW3，同时仅发布聚合后的路由


## 实验步骤：
1、接口ip配置,以sw2为例
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

2、基本bgp配置，以sw2为例
#
bgp 200
 peer 10.0.12.1 as-number 100
 peer 10.0.23.3 as-number 200
 #
 address-family ipv4 unicast
  peer 10.0.12.1 enable
  peer 10.0.23.3 enable
  peer 10.0.23.3 next-hop-local
#


3、SW2配置路由手动聚合
#
bgp 200
 #
 address-family ipv4 unicast
  aggregate 1.1.1.0 255.255.255.0 detail-suppressed
#


## 测试结果：
1、SW2配置聚合前查看SW3路由
<SW3>dis ip routing-table 
Destinations : 16       Routes : 16
Destination/Mask   Proto   Pre Cost        NextHop         Interface
0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0
1.1.1.1/32         BGP     255 0           10.0.23.2       Vlan20
1.1.1.2/32         BGP     255 0           10.0.23.2       Vlan20
1.1.1.3/32         BGP     255 0           10.0.23.2       Vlan20
1.1.1.4/32         BGP     255 0           10.0.23.2       Vlan20
10.0.23.0/24       Direct  0   0           10.0.23.3       Vlan20
...................
<SW3>

2、SW2配置聚合后查看SW3路由
<SW3>dis ip routing-table 
Destinations : 13       Routes : 13
Destination/Mask   Proto   Pre Cost        NextHop         Interface
0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0
1.1.1.0/24         BGP     255 0           10.0.23.2       Vlan20
10.0.23.0/24       Direct  0   0           10.0.23.3       Vlan20
......

## 说明： 
在中型或大型BGP网络中，在向对等体发布路由信息时，可以配置路由聚合，减少发布的路由数量，并减小路由表的规模。IPv4 BGP支持自动聚合和手动聚合两种聚合方式，同时配置时，手动聚合的优先级高于自动聚合的优先级。IPv6 BGP只支持手动聚合。
配置自动聚合功能后，BGP将对通过import-route命令引入的IGP子网路由进行聚合，不再发布子网路由，而是发布聚合的自然网段的路由。
自动聚合是按照自然网段进行聚合，而且只能对IGP引入的子网路由进行聚合。通过配置手动聚合，用户可以同时对从IGP路由协议引入的子网路由和用network命令发布的路由进行聚合，而且还可以根据需要定义聚合路由的子网掩码长度。

