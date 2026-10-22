# 工程名称
V7交换机OSPFv3 Totally stub区域配置


## 需求：
1、 所有的交换机都运行OSPFv3，整个自治系统划分为3个区域。其中SW1和SW2作为ABR来转发区域之间的路由。

2、将Area 2配置为Totally Stub区域，减少通告到此区域内的LSA数量，但不影响路由的可达性。


## 实验步骤：

1、配置互联接口ipv6地址，以SW3为例

#
interface GigabitEthernet1/0/2
 port link-mode route
 ipv6 address 11::3/64
#
interface GigabitEthernet1/0/3
 port link-mode route
 ipv6 address 12::3/64
#

2、创建OSPF进程，并配置router ID，以SW3为例

#
ospfv3 10
 router-id 1.1.1.3
#

3、接口下使能OSPFv3，以SW3为例

#
interface GigabitEthernet1/0/2
 ospfv3 10 area 0.0.0.0
#
interface GigabitEthernet1/0/3
 ospfv3 10 area 0.0.0.2
#

4、SW3、SW4配置area 2为Totally stub区域

<SW3>dis cu conf ospfv3
#
ospfv3 10
 router-id 1.1.1.3
 area 0.0.0.0
 area 0.0.0.2
  stub no-summary
#
<SW4>dis cu conf ospfv3
#
ospfv3 10
 router-id 1.1.1.4
 area 0.0.0.2
  stub
#


## 测试结果：
1、area2配置为stub区域时查看SW4的路由

[SW4]dis ipv6 routing-table

Destinations : 8        Routes : 8

Destination: ::/0                                        Protocol  : O_INTER
NextHop    : FE80::262B:8FFF:FE80:308                    Preference: 10
Interface  : GE1/0/3                                     Cost      : 2

Destination: ::1/128                                     Protocol  : Direct
NextHop    : ::1                                         Preference: 0
Interface  : InLoop0                                     Cost      : 0

Destination: 10::/64                                     Protocol  : O_INTER
NextHop    : FE80::262B:8FFF:FE80:308                    Preference: 10
Interface  : GE1/0/3                                     Cost      : 3

Destination: 11::/64                                     Protocol  : O_INTER
NextHop    : FE80::262B:8FFF:FE80:308                    Preference: 10
Interface  : GE1/0/3                                     Cost      : 2

Destination: 12::/64                                     Protocol  : Direct
NextHop    : ::                                          Preference: 0
Interface  : GE1/0/3                                     Cost      : 0

Destination: 12::4/128                                   Protocol  : Direct
NextHop    : ::1                                         Preference: 0
Interface  : InLoop0                                     Cost      : 0

Destination: FE80::/10                                   Protocol  : Direct
NextHop    : ::                                          Preference: 0
Interface  : InLoop0                                     Cost      : 0

Destination: FF00::/8                                    Protocol  : Direct
NextHop    : ::                                          Preference: 0
Interface  : NULL0                                       Cost      : 0
[SW4]  
[SW4]dis ospfv3 routing 

               OSPFv3 Process 10 with Router ID 1.1.1.4
-------------------------------------------------------------------------
 I  - Intra area route,  E1 - Type 1 external route,  N1 - Type 1 NSSA route
 IA - Inter area route,  E2 - Type 2 external route,  N2 - Type 2 NSSA route
 *  - Selected route

 *Destination: ::/0 
  Type       : IA                        Area       : 0.0.0.2
  AdvRouter  : 1.1.1.3                   Preference : 10
  NibID      : 0x23000002                Cost       : 2
  Interface  : GE1/0/3                   BkInterface: N/A                      
  Nexthop    : FE80::262B:8FFF:FE80:308
  BkNexthop  : N/A

 *Destination: 10::/64 
  Type       : IA                        Area       : 0.0.0.2
  AdvRouter  : 1.1.1.3                   Preference : 10
  NibID      : 0x23000002                Cost       : 3
  Interface  : GE1/0/3                   BkInterface: N/A                      
  Nexthop    : FE80::262B:8FFF:FE80:308
  BkNexthop  : N/A

 *Destination: 11::/64 
  Type       : IA                        Area       : 0.0.0.2
  AdvRouter  : 1.1.1.3                   Preference : 10
  NibID      : 0x23000002                Cost       : 2
  Interface  : GE1/0/3                   BkInterface: N/A                      
  Nexthop    : FE80::262B:8FFF:FE80:308
  BkNexthop  : N/A

 *Destination: 12::/64 
  Type       : I                         Area       : 0.0.0.2
  AdvRouter  : 1.1.1.4                   Preference : 10
  NibID      : 0x23000001                Cost       : 1
  Interface  : GE1/0/3                   BkInterface: N/A                      
  Nexthop    : ::
  BkNexthop  : N/A

 Total: 4        
 Intra area: 1         Inter area: 3         ASE: 0         NSSA: 0        
[SW4]  

2、area2配置为Totally stub区域后查看SW4的路由，可以看到OSPFv3外部路由和区域间路由都已经没有了，但是3类的缺省路由还在

<SW4>dis ipv6 routing-table

Destinations : 6        Routes : 6

Destination: ::/0                                        Protocol  : O_INTER
NextHop    : FE80::2651:11FF:FEC0:308                    Preference: 10
Interface  : GE1/0/3                                     Cost      : 2

Destination: ::1/128                                     Protocol  : Direct
NextHop    : ::1                                         Preference: 0
Interface  : InLoop0                                     Cost      : 0

Destination: 12::/64                                     Protocol  : Direct
NextHop    : ::                                          Preference: 0
Interface  : GE1/0/3                                     Cost      : 0

Destination: 12::4/128                                   Protocol  : Direct
NextHop    : ::1                                         Preference: 0
Interface  : InLoop0                                     Cost      : 0

Destination: FE80::/10                                   Protocol  : Direct
NextHop    : ::                                          Preference: 0
Interface  : InLoop0                                     Cost      : 0

Destination: FF00::/8                                    Protocol  : Direct
NextHop    : ::                                          Preference: 0
Interface  : NULL0                                       Cost      : 0
<SW4>  
<SW4>dis ospfv3 routing 

               OSPFv3 Process 10 with Router ID 1.1.1.4
-------------------------------------------------------------------------
 I  - Intra area route,  E1 - Type 1 external route,  N1 - Type 1 NSSA route
 IA - Inter area route,  E2 - Type 2 external route,  N2 - Type 2 NSSA route
 *  - Selected route

 *Destination: ::/0 
  Type       : IA                        Area       : 0.0.0.2
  AdvRouter  : 1.1.1.3                   Preference : 10
  NibID      : 0x23000002                Cost       : 2
  Interface  : GE1/0/3                   BkInterface: N/A                      
  Nexthop    : FE80::2651:11FF:FEC0:308
  BkNexthop  : N/A

 *Destination: 12::/64 
  Type       : I                         Area       : 0.0.0.2
  AdvRouter  : 1.1.1.4                   Preference : 10
  NibID      : 0x23000001                Cost       : 1
  Interface  : GE1/0/3                   BkInterface: N/A                      
  Nexthop    : ::
  BkNexthop  : N/A

 Total: 2        
 Intra area: 1         Inter area: 1         ASE: 0         NSSA: 0        
<SW4> 
<SW4>


## 说明： 
1、Totally stub区域禁止OSPFv3外部路由和区域间路由进入，但会生成一条3类缺省路由保证对外的路由连通性

2、OSPFv3支持Totally Stub区域，其原理及应用环境与OSPFv2相同

