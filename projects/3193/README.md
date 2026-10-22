# 工程名称
V7交换机使用AS-PATH完成BGP路由过滤


## 需求：
SW2配置不向SW3发布任何来自AS100的路由


## 实验步骤：
1、配置接口ip,以SW2为例
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

2、基本BGP配置,以SW2为例
#
bgp 200
 peer 10.0.12.1 as-number 100
 peer 10.0.23.3 as-number 300
 #
 address-family ipv4 unicast
  peer 10.0.12.1 enable
  peer 10.0.23.3 enable
#

3、SW2配置ip as-path，并在SW2向SW3发布路由的时候使用as-path-acl过滤
#
 ip as-path denyas100 deny 100$
 ip as-path denyas100 permit .*
#            
bgp 200
 #
 address-family ipv4 unicast
  peer 10.0.23.3 as-path-acl denyas100 export
#


## 测试结果：
1、过滤前查看SW3上1.1.1.2/32路由
[SW3]dis ip rou
Destinations : 18       Routes : 18
Destination/Mask   Proto   Pre Cost        NextHop         Interface
0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0
1.1.1.2/32         BGP     255 0           10.0.23.2       GE1/0/2
3.3.3.3/32         Direct  0   0           127.0.0.1       InLoop0
......

2、过滤后查看SW3上1.1.1.2/32路由
<SW3>dis ip routing-table 
Destinations : 18       Routes : 18
Destination/Mask   Proto   Pre Cost        NextHop         Interface
0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0
1.1.1.2/32         BGP     255 0           10.0.34.4       GE1/0/3		//下一跳是SW4
3.3.3.3/32         Direct  0   0           127.0.0.1       InLoop0
......

## 说明： 

1、
$
匹配以指定字符结束的行

2、具体as-path的格式请参考产品手册
