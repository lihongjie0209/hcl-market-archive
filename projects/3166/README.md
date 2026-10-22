# 工程名称
V7交换机BGP local-preference属性


## 需求：
1、sw1与sw2、sw4建立ebgp邻居关系，sw3与sw2、sw4建立ibgp邻居关系

2、sw1宣告自身loopback地址，通过修改sw2或者sw4的bgp默认local-preference值来影响SW3去往SW1 loopback地址的路由选路


## 实验步骤：
1、配置接口ip，以SW4为例
#
interface GigabitEthernet1/0/3
 port link-mode bridge
 port access vlan 30
#
interface GigabitEthernet1/0/4
 port link-mode bridge
 port access vlan 40
#
interface LoopBack0
 ip address 4.4.4.4 255.255.255.255
#
interface Vlan-interface30
 ip address 10.0.34.4 255.255.255.0
#
interface Vlan-interface40
 ip address 10.0.14.4 255.255.255.0
#

2、sw2、sw3、sw4之间运行ospf，保证loopback地址可以互通，以sw4为例
#
ospf 1 router-id 4.4.4.4
 area 0.0.0.0
  network 4.4.4.4 0.0.0.0
  network 10.0.34.4 0.0.0.0
#

3、配置bgp，ibgp使用loopback口建立邻居，以sw4为例
#
bgp 200
 router-id 4.4.4.4
 peer 3.3.3.3 as-number 200
 peer 3.3.3.3 connect-interface LoopBack0
 peer 10.0.14.1 as-number 100
 #
 address-family ipv4 unicast
  peer 3.3.3.3 enable
  peer 3.3.3.3 next-hop-local
  peer 10.0.14.1 enable
#

4、本此实验sw3优选了sw2的传递的路由，因此修改sw4的bgp default local-preference值来让sw3优选sw4传递的路由
#
bgp 200
 #
 address-family ipv4 unicast
  default local-preference 150
#

## 测试结果：
1、bgp首次建立成功时查看sw3的路由表，可以看到去往1.1.1.1/32的下一跳地址是sw2
<SW3>dis ip rou
Destinations : 20       Routes : 20
Destination/Mask   Proto   Pre Cost        NextHop         Interface
0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0
1.1.1.1/32         BGP     255 0           2.2.2.2         GE1/0/2		//下一跳是sw2
2.2.2.2/32         O_INTRA 10  1           10.0.23.2       GE1/0/2
3.3.3.3/32         Direct  0   0           127.0.0.1       InLoop0
4.4.4.4/32         O_INTRA 10  1           10.0.34.4       GE1/0/3
10.0.23.0/24       Direct  0   0           10.0.23.3       GE1/0/2

2、修改sw4的bgp default local-preference值后再次查看sw3的路由表
<SW3>dis ip rou
Destinations : 20       Routes : 20
Destination/Mask   Proto   Pre Cost        NextHop         Interface
0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0
1.1.1.1/32         BGP     255 0           4.4.4.4         GE1/0/3	//下一跳是SW4
2.2.2.2/32         O_INTRA 10  1           10.0.23.2       GE1/0/2
3.3.3.3/32         Direct  0   0           127.0.0.1       InLoop0
4.4.4.4/32         O_INTRA 10  1           10.0.34.4       GE1/0/3
10.0.23.0/24       Direct  0   0           10.0.23.3       GE1/0/2

## 说明： 

1、local-preference属性仅在本AS内传递

2、local-preference属性用来判断流量离开AS时的最佳路由

3、local-preference属性数值越大，优先级越高
