# 工程名称
防火墙做RBM，配合VRRP和OSPF实现主备。


## 需求：

防火墙上下VRRP，对端使用静态路由，下行用OSPF，实现主备。


## 实验步骤：
1.交换机配置地址和静态路由。

2.路由器配置地址和OSPF。

3.防火墙配置RBM。

4.防火墙配置安全策略和安全域，上行trust，下行untrust，放通trust-untrust，并且放通VRRP和OSPF的报文。

5.防火墙配置OSPF和VRRP，注意防火墙有默认地址192.168.0.1，因此会有route id冲突，要改。

6.测试配置。


## 测试结果：

测试交换机可以ping通路由器，并且看路由器路由的确是主框学到。
[H3C-ospf-1-area-0.0.0.0]dis ip routing-table

Destinations : 14       Routes : 14

Destination/Mask   Proto   Pre Cost        NextHop         Interface

0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0

2.2.2.0/24         O_INTRA 10  2           3.3.3.2         GE0/0


[H3C]ping 3.3.3.1

Ping 3.3.3.1 (3.3.3.1): 56 data bytes, press CTRL_C to break

56 bytes from 3.3.3.1: icmp_seq=0 ttl=254 time=0.000 ms

56 bytes from 3.3.3.1: icmp_seq=1 ttl=254 time=2.000 ms

56 bytes from 3.3.3.1: icmp_seq=2 ttl=254 time=1.000 ms

56 bytes from 3.3.3.1: icmp_seq=3 ttl=254 time=1.000 ms

56 bytes from 3.3.3.1: icmp_seq=4 ttl=254 time=0.000 ms




## 说明： 

无
