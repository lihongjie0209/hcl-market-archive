# 工程名称
V7交换机等价静态路由(ECMP)


## 需求：
交换机上行与两台路由器互联，配置等价静态路由，实现上行流量在两台路由器的负载均衡。


## 实验步骤：
**1、配置接口互联ip地址**
#
vlan 10
port GigabitEthernet 1/0/1
#
vlan 11
port GigabitEthernet 1/0/2
#
interface Vlan-interface10
 ip address 10.0.13.3 255.255.255.0
#
interface Vlan-interface11
 ip address 10.0.23.3 255.255.255.0
#


**2、配置两台默认路由，两条路由保持默认优先级**
#
 ip route-static 0.0.0.0 0 10.0.13.1
 ip route-static 0.0.0.0 0 10.0.23.2
#


## 测试结果：
查看路由表已形成两条默认路由
[H3C]dis ip routing-table 

Destinations : 17       Routes : 18

Destination/Mask   Proto   Pre Cost        NextHop         Interface
**0.0.0.0/0          Static  60  0           10.0.13.1       Vlan10**
**                                           10.0.23.2       Vlan11**
0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0
10.0.13.0/24       Direct  0   0           10.0.13.3       Vlan10
10.0.13.0/32       Direct  0   0           10.0.13.3       Vlan10
10.0.13.3/32       Direct  0   0           127.0.0.1       InLoop0
10.0.13.255/32     Direct  0   0           10.0.13.3       Vlan10
10.0.23.0/24       Direct  0   0           10.0.23.3       Vlan11
10.0.23.0/32       Direct  0   0           10.0.23.3       Vlan11
10.0.23.3/32       Direct  0   0           127.0.0.1       InLoop0
10.0.23.255/32     Direct  0   0           10.0.23.3       Vlan11
127.0.0.0/8        Direct  0   0           127.0.0.1       InLoop0
127.0.0.0/32       Direct  0   0           127.0.0.1       InLoop0
127.0.0.1/32       Direct  0   0           127.0.0.1       InLoop0
127.255.255.255/32 Direct  0   0           127.0.0.1       InLoop0
224.0.0.0/4        Direct  0   0           0.0.0.0         NULL0
224.0.0.0/24       Direct  0   0           0.0.0.0         NULL0
255.255.255.255/32 Direct  0   0           127.0.0.1       InLoop0


## 说明： 
**1、静态路由默认优先级为60，优先级数值越小越优先**

**2、可以通过配置静态路由与BFD/track的联动，提升路由切换灵敏度**

