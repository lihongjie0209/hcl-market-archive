# 工程名称
V7交换机BGP路由反射器配置


## 需求：
通过配置SW3为BGP路由反射器，SW2和SW4为SW3的客户机，让SW4能学习到SW2传递过去的路由

## 实验步骤：
1、配置接口ip,以W3为例
#
interface GigabitEthernet1/0/2
 port link-mode bridge
 port access vlan 20
#              
interface GigabitEthernet1/0/3
 port link-mode bridge
 port access vlan 30
#

2、基本BGP配置,以W3为例
#
bgp 200
 peer 10.0.23.2 as-number 200
 peer 10.0.34.4 as-number 200
 #
 address-family ipv4 unicast
  import-route direct
  peer 10.0.23.2 enable
  peer 10.0.34.4 enable
#

3、SW3配置BGP路由反射器，并指定SW2和SW4为客户机
#
bgp 200
 #
 address-family ipv4 unicast
  peer 10.0.23.2 reflect-client
  peer 10.0.34.4 reflect-client
#


## 测试结果：
1、配置反射器前查看SW4上的路由
<SW4>dis ip routing-table 
Destinations : 13       Routes : 13
Destination/Mask   Proto   Pre Cost        NextHop         Interface
0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0
10.0.23.0/24       BGP     255 0           10.0.34.3       Vlan30
......
<SW4>

2、配置反射器后查看SW4上的路由
<SW4>dis ip routing-table 
Destinations : 15       Routes : 15
Destination/Mask   Proto   Pre Cost        NextHop         Interface
0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0
1.1.1.1/32         BGP     255 0           10.0.23.2       Vlan30
2.2.2.2/32         BGP     255 0           10.0.23.2       Vlan30
10.0.23.0/24       BGP     255 0           10.0.34.3       Vlan30
10.0.34.0/24       Direct  0   0           10.0.34.4       Vlan30
......

## 说明： 
为保证IBGP对等体之间的连通性，需要在IBGP对等体之间建立全连接关系。假设在一个AS内部有n台路由器，那么应该建立的IBGP连接数就为n(n-1)/2。当IBGP对等体数目很多时，对网络资源和CPU资源的消耗都很大。利用路由反射可以解决这一问题。在一个AS内，其中一台路由器作为RR（Route Reflector，路由反射器），作为客户机（Client）的路由器与路由反射器之间建立IBGP连接。路由反射器从客户机接收到路由后，将其传递（反射）给所有其他的客户机，从而保证客户机之间不需要建立BGP连接，就可以学习到彼此的路由。既不是路由反射器也不是客户机的BGP路由器被称为非客户机（Non-client）。非客户机与路由反射器之间，以及所有的非客户机之间仍然必须建立全连接关系。

