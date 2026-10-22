# 工程名称

V7交换机ipv4 bgp基本配置

## 需求：
所有交换机均运行BGP协议。要求SW1和SW2之间建立EBGP连接，SW2和SW3之间建立IBGP连接，使得SW3能够访问SW1的192.168.1.1/32。


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
interface LoopBack0
 ip address 1.1.1.2 255.255.255.255
#
interface LoopBack1
 ip address 192.168.2.1 255.255.255.255
#

2、BGP基本配置，以SW2为例
#
bgp 200
 router-id 1.1.1.2
 peer 1.1.1.3 as-number 200
 peer 1.1.1.3 connect-interface LoopBack0
 peer 10.0.12.1 as-number 100
 #
 address-family ipv4 unicast
  import-route direct
  peer 1.1.1.3 enable
  peer 1.1.1.3 next-hop-local
  peer 10.0.12.1 enable
#

## 测试结果：
1、查看bgp邻居和路由表，以sw2为例
<SW2>dis bgp peer ipv4
 BGP local router ID: 1.1.1.2
 Local AS number: 200
 Total number of peers: 2                 Peers in established state: 2
  * - Dynamically created peer
  ^ - Peer created through link-local address
  Peer                    AS  MsgRcvd  MsgSent OutQ PrefRcv Up/Down  State
  1.1.1.3                200        5        7    0       3 00:00:20 Established
  10.0.12.1              100        6        8    0       2 00:01:19 Established
<SW2>
<SW2>dis ip routing-table 

Destinations : 21       Routes : 21

Destination/Mask   Proto   Pre Cost        NextHop         Interface
0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0
1.1.1.2/32         Direct  0   0           127.0.0.1       InLoop0
1.1.1.3/32         O_INTRA 10  1           10.0.23.3       Vlan20
10.0.12.0/24       Direct  0   0           10.0.12.2       Vlan10
10.0.12.0/32       Direct  0   0           10.0.12.2       Vlan10
10.0.12.2/32       Direct  0   0           127.0.0.1       InLoop0
10.0.12.255/32     Direct  0   0           10.0.12.2       Vlan10
10.0.23.0/24       Direct  0   0           10.0.23.2       Vlan20
10.0.23.0/32       Direct  0   0           10.0.23.2       Vlan20
10.0.23.2/32       Direct  0   0           127.0.0.1       InLoop0
10.0.23.255/32     Direct  0   0           10.0.23.2       Vlan20
127.0.0.0/8        Direct  0   0           127.0.0.1       InLoop0
127.0.0.0/32       Direct  0   0           127.0.0.1       InLoop0
127.0.0.1/32       Direct  0   0           127.0.0.1       InLoop0
127.255.255.255/32 Direct  0   0           127.0.0.1       InLoop0
192.168.1.1/32     BGP     255 0           10.0.12.1       Vlan10
192.168.2.1/32     Direct  0   0           127.0.0.1       InLoop0
192.168.3.1/32     BGP     255 0           1.1.1.3         Vlan20
224.0.0.0/4        Direct  0   0           0.0.0.0         NULL0
224.0.0.0/24       Direct  0   0           0.0.0.0         NULL0
255.255.255.255/32 Direct  0   0           127.0.0.1       InLoop0
<SW2> 

2、SW3可以ping通SW1的192.168.1.1
<SW3>ping 192.168.1.1
Ping 192.168.1.1 (192.168.1.1): 56 data bytes, press CTRL+C to break
56 bytes from 192.168.1.1: icmp_seq=0 ttl=254 time=1.000 ms
56 bytes from 192.168.1.1: icmp_seq=1 ttl=254 time=1.000 ms
56 bytes from 192.168.1.1: icmp_seq=2 ttl=254 time=1.000 ms
56 bytes from 192.168.1.1: icmp_seq=3 ttl=254 time=1.000 ms
56 bytes from 192.168.1.1: icmp_seq=4 ttl=254 time=1.000 ms
--- Ping statistics for 192.168.1.1 ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss
round-trip min/avg/max/std-dev = 1.000/1.000/1.000/0.000 ms
%Nov 30 12:48:47:758 2022 SW3 PING/6/PING_STATISTICS: Ping statistics for 192.168.1.1: 5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss, round-trip min/avg/max/std-dev = 1.000/1.000/1.000/0.000 ms.
<SW3>

## 说明： 
1、为了防止端口状态不稳定引起路由震荡，建议使用Loopback接口来创建IBGP对等体

2、用Loopback接口创建IBGP对等体时，因为Loopback接口不是两对等体实际连接的接口，所以，必须使用peer connect-interface命令将Loopback接口配置为BGP连接的源接口。

3、 在AS 200内部，使用OSPF协议，保证SW2到SW3的Loopback接口路由可达，SW3到SW2的Loopback接口路由可达。

4、根据对等体所在的AS，可以将对等体分为以下两种：
·     IBGP对等体：对等体与本地路由器位于同一AS。
·     EBGP对等体：对等体与本地路由器位于不同AS。

5、
 BGP发言者把自己产生的路由发给所有邻居时，将该路由信息的NEXT_HOP属性设置为自己与对端连接的接口地址；
·     BGP发言者把接收到的路由发送给EBGP对等体时，将该路由信息的NEXT_HOP属性设置为自己与对端连接的接口地址；
·     BGP发言者把从EBGP邻居得到的路由发给IBGP邻居时，并不改变该路由信息的NEXT_HOP属性。如果配置了负载分担，等价路由被发给IBGP邻居时则会修改NEXT_HOP属性。

6、
·     BGP发言者只把自己使用的路由发布给对等体。
·     BGP发言者会将从EBGP获得的路由发布给它的所有BGP对等体（包括EBGP对等体和IBGP对等体）。
·     BGP发言者会将从IBGP获得的路由发布给它的EBGP对等体，但不会发布给它的IBGP对等体。