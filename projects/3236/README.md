# 工程名称
V7交换机通过IP前缀列表过滤BGP路由配置


## 需求：
通过配置IP前缀列表，对BGP发给对等体的路由进行过滤


## 实验步骤：
1、配置接口ip，以SW2为例
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

2、基本bgp配置。以sw2为例
#
bgp 200
 peer 10.0.12.1 as-number 100
 peer 10.0.23.3 as-number 300
 #
 address-family ipv4 unicast
  peer 10.0.12.1 enable
  peer 10.0.23.3 enable
#


3、配置ip前缀列表
#
 ip prefix-list deny1 index 5 deny 1.1.1.2 32
 ip prefix-list deny1 index 10 permit 0.0.0.0 0 less-equal 32
#

4、配置SW2给SW3发布路由时使用前缀列表过滤
#              
bgp 200
 #
 address-family ipv4 unicast
  peer 10.0.23.3 prefix-list deny1 export
#


## 测试结果：
1、配置路由过滤前查看SW3路由表
<SW3>dis ip routing-table 
Destinations : 18       Routes : 18
Destination/Mask   Proto   Pre Cost        NextHop         Interface
0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0
1.1.1.2/32         BGP     255 0           10.0.23.2       GE1/0/2		//下一跳是SW2
3.3.3.3/32         Direct  0   0           127.0.0.1       InLoop0


2、配置路由过滤后查看SW3路由表
<SW3>dis ip rou
Destinations : 18       Routes : 18
Destination/Mask   Proto   Pre Cost        NextHop         Interface
0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0
1.1.1.2/32         BGP     255 0           10.0.34.4       GE1/0/3		//下一跳是SW4
3.3.3.3/32         Direct  0   0           127.0.0.1       InLoop0
......

## 说明： 
1、地址前缀列表的作用类似于ACL，但比它更为灵活，且更易于用户理解。使用地址前缀列表过滤路由信息时，其匹配对象为路由信息的目的地址。

2、一个地址前缀列表由前缀列表名标识。每个前缀列表可以包含多个表项，每个表项可以独立指定一个网络前缀形式的匹配范围，并用一个索引号来标识，索引号指明了在地址前缀列表中进行匹配检查的顺序。

3、每个表项之间是“或”的关系，在匹配的过程中，路由器按升序依次检查由索引号标识的各个表项，只要有某一表项满足条件，就意味着通过该地址前缀列表的过滤

