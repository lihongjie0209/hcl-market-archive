# 工程名称
V7交换机OSPFv3基础

## 需求：
所有的交换机都运行OSPFv3，整个自治系统划分为2个区域。其中SW2和SW3作为ABR来转发区域之间的路由


## 实验步骤：
1、配置互联接口ipv6地址，以SW2为例
#
interface LoopBack0
 ipv6 address 1::2/128
#
interface GigabitEthernet1/0/1
 port link-mode route
 ipv6 address 10::2/64
#
interface GigabitEthernet1/0/2
 port link-mode route
 ipv6 address 11::2/64
#


2、创建OSPF进程，并配置router ID，以SW2为例
#
ospfv3 10
 router-id 1.1.1.2
#

3、接口下使能OSPFv3，以SW2为例
#
interface LoopBack0
 ospfv3 10 area 0.0.0.0
#
interface GigabitEthernet1/0/1
 ospfv3 10 area 0.0.0.1
#
interface GigabitEthernet1/0/2
 ospfv3 10 area 0.0.0.0
#

## 测试结果：
1、设备间OSPFv3邻居建立成功，以SW2为例

[SW2]display ospfv3 peer 
               OSPFv3 Process 10 with Router ID 1.1.1.2
 Area: 0.0.0.0        
-------------------------------------------------------------------------
 Router ID       Pri State             Dead-Time InstID Interface
 1.1.1.3         1   Full/DR           00:00:39  0      GE1/0/2
 Area: 0.0.0.1        
-------------------------------------------------------------------------
 Router ID       Pri State             Dead-Time InstID Interface
 1.1.1.1         1   Full/DR           00:00:39  0      GE1/0/1
[SW2]


2、IPV6路由学习正常，以SW2为例

[SW2]display ipv6 routing-table

Destinations : 12       Routes : 12

Destination: ::1/128                                     Protocol  : Direct
NextHop    : ::1                                         Preference: 0
Interface  : InLoop0                                     Cost      : 0

Destination: 1::1/128                                    Protocol  : O_INTRA
NextHop    : FE80::26AF:38FF:FEAF:106                    Preference: 10
Interface  : GE1/0/1                                     Cost      : 1

Destination: 1::2/128                                    Protocol  : Direct
NextHop    : ::1                                         Preference: 0
Interface  : InLoop0                                     Cost      : 0

Destination: 1::3/128                                    Protocol  : O_INTRA
NextHop    : FE80::26AF:41FF:FE69:307                    Preference: 10
Interface  : GE1/0/2                                     Cost      : 1

Destination: 1::4/128                                    Protocol  : O_INTER
NextHop    : FE80::26AF:41FF:FE69:307                    Preference: 10
Interface  : GE1/0/2                                     Cost      : 2

Destination: 10::/64                                     Protocol  : Direct
NextHop    : ::                                          Preference: 0
Interface  : GE1/0/1                                     Cost      : 0

Destination: 10::2/128                                   Protocol  : Direct
NextHop    : ::1                                         Preference: 0
Interface  : InLoop0                                     Cost      : 0

Destination: 11::/64                                     Protocol  : Direct
NextHop    : ::                                          Preference: 0
Interface  : GE1/0/2                                     Cost      : 0

Destination: 11::2/128                                   Protocol  : Direct
NextHop    : ::1                                         Preference: 0
Interface  : InLoop0                                     Cost      : 0

Destination: 12::/64                                     Protocol  : O_INTER
NextHop    : FE80::26AF:41FF:FE69:307                    Preference: 10
Interface  : GE1/0/2                                     Cost      : 2

Destination: FE80::/10                                   Protocol  : Direct
NextHop    : ::                                          Preference: 0
Interface  : InLoop0                                     Cost      : 0
               
Destination: FF00::/8                                    Protocol  : Direct
NextHop    : ::                                          Preference: 0
Interface  : NULL0                                       Cost      : 0
[SW2]    


## 说明： 
1、OSPFv3必须配置router id

2、OSPFv3无法在OSPFv3进程的区域视图下network，只能在接口视图下配置ospfv3 xx area xx来使能ospf

3、当OSPFv3进程视图下没有创建area时，直接在接口视图下使能OSPFv3会自动创建对应area



