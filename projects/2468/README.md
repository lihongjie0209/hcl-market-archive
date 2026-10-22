# 工程名称
V7交换机浮动静态路由(主备静态路由)


## 需求：
交换机上行与两台路由器互联，配置浮动静态路由，实现正常情况下所有上行流量走Route1，当Route1侧故障后，再走Route2。


## 实验步骤：
**1、配置接口互联ip地址**
#
vlan 10
port GigabitEthernet 1/0/1
#
vlan 11
port GigabitEthernet 1/0/2
#
inter vlan 10
ip address 10.0.13.3 24
#
inter vlan 11
ip address 10.0.23.3 24
#

**2、配置两台默认路由，主路由保持默认优先级，备份路由配置优先级为70(数值越小越优先，默认为60)**
#
ip route-static 0.0.0.0 0 10.0.13.1
ip route-static 0.0.0.0 0 10.0.23.2 preference 70
#

## 测试结果：
**1、正常查看路由表只有一条去往Route1的默认路由**
[SW1]dis ip routing-table 
Destinations : 17       Routes : 17
Destination/Mask   Proto   Pre Cost        NextHop         Interface
**0.0.0.0/0          Static  60  0           10.0.13.1       Vlan10**
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

2、当连接Route1的接口故障后，路由切换，在查看路由表默认路由指向Route2
[SW1]inter GigabitEthernet 1/0/1
[SW1-GigabitEthernet1/0/1]shutdown 
[SW1-GigabitEthernet1/0/1]quit
%Aug 10 15:33:41:665 2022 SW1 IFNET/3/PHY_UPDOWN: Physical state on the interface GigabitEthernet1/0/1 changed to down.
%Aug 10 15:33:41:665 2022 SW1 IFNET/5/LINK_UPDOWN: Line protocol state on the interface GigabitEthernet1/0/1 changed to down.
%Aug 10 15:33:41:665 2022 SW1 IFNET/3/PHY_UPDOWN: Physical state on the interface Vlan-interface10 changed to down.
%Aug 10 15:33:41:665 2022 SW1 IFNET/5/LINK_UPDOWN: Line protocol state on the interface Vlan-interface10 changed to down.
[SW1]dis ip routing-table 
Destinations : 13       Routes : 13
Destination/Mask   Proto   Pre Cost        NextHop         Interface
**0.0.0.0/0          Static  70  0           10.0.23.2       Vlan11**
0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0
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

3、当故障接口恢复后，路由恢复
[SW1]inter GigabitEthernet 1/0/1
[SW1-GigabitEthernet1/0/1]shutdown 
[SW1-GigabitEthernet1/0/1]quit
%Aug 10 15:33:46:781 2022 SW1 IFNET/3/PHY_UPDOWN: Physical state on the interface GigabitEthernet1/0/1 changed to up.
%Aug 10 15:33:46:781 2022 SW1 IFNET/5/LINK_UPDOWN: Line protocol state on the interface GigabitEthernet1/0/1 changed to up.
%Aug 10 15:33:46:781 2022 SW1 IFNET/3/PHY_UPDOWN: Physical state on the interface Vlan-interface10 changed to up.
%Aug 10 15:33:46:781 2022 SW1 IFNET/5/LINK_UPDOWN: Line protocol state on the interface Vlan-interface10 changed to up.


[SW1]dis ip routing-table 
Destinations : 17       Routes : 17
Destination/Mask   Proto   Pre Cost        NextHop         Interface
**0.0.0.0/0          Static  60  0           10.0.13.1       Vlan10**
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
1、静态路由默认优先级为60，优先级数值越小越优先

2、可以通过配置静态路由与BFD/track的联动，提升路由切换灵敏度

