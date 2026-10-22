# 工程名称
V7交换机BGP MED属性


## 需求：
1、sw1与sw2、sw4建立ebgp邻居关系，sw3与sw2、sw4建立ibgp邻居关系

2、sw3宣告自身loopback地址，sw1通过修改从sw2或者sw4的接收到的路由的med值来影响SW1去往SW3 loopback地址的路由选路


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

2、sw2、sw3、sw4之间运行ospf，保证loopback地址可以互通，以SW4为例
#
ospf 1 router-id 4.4.4.4
 area 0.0.0.0
  network 4.4.4.4 0.0.0.0
  network 10.0.34.4 0.0.0.0
#


3、配置bgp，ibgp使用loopback口建立邻居，以SW4为例
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

4、本此实验sw1优选了sw4的传递的路由，因此在SW1修改从sw4学习到的路由的med(cost)值来让sw3优选sw2传递的路由
#
route-policy editmed permit node 10
 apply cost 100
#
bgp 100
 router-id 1.1.1.1
 peer 10.0.12.2 as-number 200
 peer 10.0.14.4 as-number 200
 #
 address-family ipv4 unicast
  network 1.1.1.1 255.255.255.255
  peer 10.0.12.2 enable
  peer 10.0.14.4 enable
  peer 10.0.14.4 route-policy editmed import
#


## 测试结果：
1、bgp首次建立成功时查看sw1的路由表，可以看到去往3.3.3.3/32的下一跳地址是sw4
<SW1>dis ip routing-table 
Destinations : 14       Routes : 14
Destination/Mask   Proto   Pre Cost        NextHop         Interface
0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0
1.1.1.1/32         Direct  0   0           127.0.0.1       InLoop0
3.3.3.3/32         BGP     255 0           10.0.14.4       Vlan40		//sw4
10.0.14.0/24       Direct  0   0           10.0.14.1       Vlan40

2、修改从sw4学习到的路由的med值后再次查看sw1的路由表
<SW1>dis ip routing-table 
Destinations : 18       Routes : 18
Destination/Mask   Proto   Pre Cost        NextHop         Interface
0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0
1.1.1.1/32         Direct  0   0           127.0.0.1       InLoop0
3.3.3.3/32         BGP     255 0           10.0.12.2       Vlan10		//sw2
10.0.12.0/24       Direct  0   0           10.0.12.1       Vlan10

## 说明： 
1、可以通过多种方式配置BGP路由的MED值，按照优先级从高到底的顺序依次为：

(1)     通过路由策略中的apply cost命令设置的MED值；

(2)     通过import-route命令中的med参数设置的MED值；

(3)     通过default med命令配置的MED值；

(4)     学习到的BGP路由自身的MED值，或引入的IGP路由自身的metric值。

2、MED用来判断流量进入AS时的最佳路由。当一个BGP路由器通过不同的EBGP对等体得到目的地址相同但下一跳不同的多条路由时，在其它条件相同的情况下，将优先选择MED属性值较小者作为最佳路由。

3、MED属性数字越小越优先

