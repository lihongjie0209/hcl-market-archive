# 工程名称
V7交换机IPV6 BGP基本配置


## 需求：
所有交换机均运行IPv6 BGP协议。SW1位于AS 100；SW2和SW3位于AS 101。要求SW1和SW2之间建立EBGP连接，SW2和SW3之间建立IBGP连接，使得SW3能够访问SW1的L0 100::1/128。


## 实验步骤：
1、配置相关接口ipv6地址，以SW1为例

#
interface GigabitEthernet1/0/1
 port link-mode route
 combo enable fiber
 ipv6 address 10::1/64
#

2、创建BGP进程，并配置router ID、配置BGP邻居和使能BGP邻居

[SW1]dis cu conf bgp
#
bgp 100
 router-id 1.1.1.1
 peer 10::2 as-number 101
 #
 address-family ipv6 unicast
  peer 10::2 enable
#

[SW2]dis cu conf bgp
#
bgp 101
 router-id 1.1.1.2
 peer 10::1 as-number 100
 peer 11::3 as-number 101
 #
 address-family ipv6 unicast
  peer 10::1 enable
  peer 11::3 enable
#

[SW3]dis cu conf bgp
#
bgp 101
 router-id 1.1.1.3
 peer 11::2 as-number 101
 #
 address-family ipv6 unicast
  peer 11::2 enable
#

3、SW1在bgp中宣告L0的地址，SW3在BGP宣告自己接口g1/0/2所在网段

[SW1]dis cu conf bgp
#
bgp 100
 #
 address-family ipv6 unicast
  network 100::1 128
#

[SW3]dis cu conf bgp
#
bgp 101
 #
 address-family ipv6 unicast
  network 11:: 64
#

4、SW2在bgp中配置给SW3发送路由时，将下一跳属性修改为自身的地址
[SW2]dis cu conf bgp
#
bgp 101
 #
 address-family ipv6 unicast
  peer 11::3 next-hop-local
#



## 测试结果：
1、SW1和SW2建立了EBGP邻居，SW2和SW3建立了IBGP邻居

[SW1]dis bgp peer ipv6

 BGP local router ID: 1.1.1.1
 Local AS number: 100
 Total number of peers: 1                 Peers in established state: 1

  * - Dynamically created peer
  ^ - Peer created through link-local address
  Peer                    AS  MsgRcvd  MsgSent OutQ PrefRcv Up/Down  State

  10::2                  101       31       26    0       1 00:18:07 Established
[SW1] 

[SW2]dis bgp peer ipv6

 BGP local router ID: 1.1.1.2
 Local AS number: 101
 Total number of peers: 2                 Peers in established state: 2

  * - Dynamically created peer
  ^ - Peer created through link-local address
  Peer                    AS  MsgRcvd  MsgSent OutQ PrefRcv Up/Down  State

  10::1                  100       26       31    0       1 00:18:23 Established
  11::3                  101       29       36    0       1 00:18:35 Established
[SW2] 

[SW3]dis bgp peer ipv6

 BGP local router ID: 1.1.1.3
 Local AS number: 101
 Total number of peers: 1                 Peers in established state: 1

  * - Dynamically created peer
  ^ - Peer created through link-local address
  Peer                    AS  MsgRcvd  MsgSent OutQ PrefRcv Up/Down  State

  11::2                  101       36       29    0       1 00:18:54 Established
[SW3]  

2、SW1学习到了SW3直连网段的路由信息

[SW1]dis ipv6 routing-table

Destinations : 7        Routes : 7

Destination: ::1/128                                     Protocol  : Direct
NextHop    : ::1                                         Preference: 0
Interface  : InLoop0                                     Cost      : 0

Destination: 10::/64                                     Protocol  : Direct
NextHop    : ::                                          Preference: 0
Interface  : GE1/0/1                                     Cost      : 0

Destination: 10::1/128                                   Protocol  : Direct
NextHop    : ::1                                         Preference: 0
Interface  : InLoop0                                     Cost      : 0

Destination: 11::/64                                     Protocol  : BGP4+
NextHop    : 10::2                                       Preference: 255
Interface  : GE1/0/1                                     Cost      : 0

Destination: 100::1/128                                  Protocol  : Direct
NextHop    : ::1                                         Preference: 0
Interface  : InLoop0                                     Cost      : 0

Destination: FE80::/10                                   Protocol  : Direct
NextHop    : ::                                          Preference: 0
Interface  : InLoop0                                     Cost      : 0

Destination: FF00::/8                                    Protocol  : Direct
NextHop    : ::                                          Preference: 0
Interface  : NULL0                                       Cost      : 0
[SW1]   


3、SW3学习到了SW1的L0口路由信息

[SW3]dis ipv6 routing-table

Destinations : 6        Routes : 6

Destination: ::1/128                                     Protocol  : Direct
NextHop    : ::1                                         Preference: 0
Interface  : InLoop0                                     Cost      : 0

Destination: 11::/64                                     Protocol  : Direct
NextHop    : ::                                          Preference: 0
Interface  : GE1/0/2                                     Cost      : 0

Destination: 11::3/128                                   Protocol  : Direct
NextHop    : ::1                                         Preference: 0
Interface  : InLoop0                                     Cost      : 0

Destination: 100::1/128                                  Protocol  : BGP4+
NextHop    : 11::2                                       Preference: 255
Interface  : GE1/0/2                                     Cost      : 0

Destination: FE80::/10                                   Protocol  : Direct
NextHop    : ::                                          Preference: 0
Interface  : InLoop0                                     Cost      : 0

Destination: FF00::/8                                    Protocol  : Direct
NextHop    : ::                                          Preference: 0
Interface  : NULL0                                       Cost      : 0
[SW3] 

4、SW3可以ping通SW1的L0地址

[SW3]ping ipv6 100::1
Ping6(56 data bytes) 11::3 --> 100::1, press CTRL+C to break
56 bytes from 100::1, icmp_seq=0 hlim=63 time=2.000 ms
56 bytes from 100::1, icmp_seq=1 hlim=63 time=1.000 ms
56 bytes from 100::1, icmp_seq=2 hlim=63 time=1.000 ms
56 bytes from 100::1, icmp_seq=3 hlim=63 time=2.000 ms
56 bytes from 100::1, icmp_seq=4 hlim=63 time=2.000 ms

--- Ping6 statistics for 100::1 ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss
round-trip min/avg/max/std-dev = 1.000/1.600/2.000/0.490 ms
[SW3]


## 说明： 
对于IPV6/IPV4路由，向IBGP对等体/对等体组发布EBGP路由时，不修改下一跳属性，需配置peer next-hop-local命令



