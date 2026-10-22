# 工程名称
V7交换机OSPFv3 Totally NSSA区域配置


## 需求：
1、 所有的交换机都运行OSPFv3，整个自治系统划分为3个区域。其中SW1和SW2作为ABR来转发区域之间的路由。

2、将Area 1配置为Totally NSSA区域，减少通告到此区域内的LSA数量，同时将sw1配置为ASBR引入外部路由（L0的直连路由），且路由信息可正确的在AS内传播

## 实验步骤：
1、配置互联接口ipv6地址，以SW1为例

#
interface LoopBack0
 ipv6 address 1::1/128
#
interface GigabitEthernet1/0/1
 port link-mode route
 ipv6 address 10::1/64
#

2、创建OSPF进程，并配置router ID，以SW1为例

#
ospfv3 10
 router-id 1.1.1.1
#

3、接口下使能OSPFv3，以SW3为例

#
interface GigabitEthernet1/0/1
 ospfv3 10 area 0.0.0.1
#

4、SW1 area 1引入外部路由，以直连为例

#
ospfv3 10
 import-route direct
#

5、SW2配置area 1为Totally NSSA区域

[SW2]dis cu conf ospfv3
#
ospfv3 10
 area 0.0.0.1
  nssa no-summary
#

[SW1]dis cu conf ospfv3 
#
ospfv3 10
 area 0.0.0.1
  nssa
#


## 测试结果：
1、配置Totally NSSA区域前查看SW1、SW2和SW4的OSPFv3路由，可以看到当前SW1可以学习到3类路由，SW1引入的外部路由在SW2上看是7类的形式，在SW4上看是5类的

<SW1>dis ospfv3 routing 

               OSPFv3 Process 10 with Router ID 1.1.1.1
-------------------------------------------------------------------------
 I  - Intra area route,  E1 - Type 1 external route,  N1 - Type 1 NSSA route
 IA - Inter area route,  E2 - Type 2 external route,  N2 - Type 2 NSSA route
 *  - Selected route

 *Destination: 10::/64 
  Type       : I                         Area       : 0.0.0.1
  AdvRouter  : 1.1.1.2                   Preference : 10
  NibID      : 0x23000001                Cost       : 1
  Interface  : GE1/0/1                   BkInterface: N/A                      
  Nexthop    : ::
  BkNexthop  : N/A

 *Destination: 11::/64 
  Type       : IA                        Area       : 0.0.0.1
  AdvRouter  : 1.1.1.2                   Preference : 10
  NibID      : 0x23000002                Cost       : 2
  Interface  : GE1/0/1                   BkInterface: N/A                      
  Nexthop    : FE80::26A6:88FF:FE9E:206
  BkNexthop  : N/A

 *Destination: 12::/64 
  Type       : IA                        Area       : 0.0.0.1
  AdvRouter  : 1.1.1.2                   Preference : 10
  NibID      : 0x23000002                Cost       : 3
  Interface  : GE1/0/1                   BkInterface: N/A                      
  Nexthop    : FE80::26A6:88FF:FE9E:206
  BkNexthop  : N/A

 Total: 3        
 Intra area: 1         Inter area: 2         ASE: 0         NSSA: 0        
<SW1> 

<SW2>dis ospfv3 routing 

               OSPFv3 Process 10 with Router ID 1.1.1.2
-------------------------------------------------------------------------
 I  - Intra area route,  E1 - Type 1 external route,  N1 - Type 1 NSSA route
 IA - Inter area route,  E2 - Type 2 external route,  N2 - Type 2 NSSA route
 *  - Selected route

 *Destination: 10::/64 
  Type       : I                         Area       : 0.0.0.1
  AdvRouter  : 1.1.1.2                   Preference : 10
  NibID      : 0x23000001                Cost       : 1
  Interface  : GE1/0/1                   BkInterface: N/A                      
  Nexthop    : ::
  BkNexthop  : N/A

 *Destination: 11::/64 
  Type       : I                         Area       : 0.0.0.0
  AdvRouter  : 1.1.1.3                   Preference : 10
  NibID      : 0x23000002                Cost       : 1
  Interface  : GE1/0/2                   BkInterface: N/A                      
  Nexthop    : ::
  BkNexthop  : N/A

 *Destination: 12::/64 
  Type       : IA                        Area       : 0.0.0.0
  AdvRouter  : 1.1.1.3                   Preference : 10
  NibID      : 0x23000005                Cost       : 2
  Interface  : GE1/0/2                   BkInterface: N/A                      
  Nexthop    : FE80::26A6:90FF:FE1E:307
  BkNexthop  : N/A

 *Destination: 1::1/128 
  Type       : N2                        Tag        : 1
  AdvRouter  : 1.1.1.1                   Preference : 150
  NibID      : 0x23000003                Cost       : 1
  Interface  : GE1/0/1                   BkInterface: N/A                      
  Nexthop    : 10::1
  BkNexthop  : N/A

 *Destination: 1::4/128 
  Type       : E2                        Tag        : 1
  AdvRouter  : 1.1.1.4                   Preference : 150
  NibID      : 0x23000005                Cost       : 1
  Interface  : GE1/0/2                   BkInterface: N/A                      
  Nexthop    : FE80::26A6:90FF:FE1E:307
  BkNexthop  : N/A

 Total: 5        
 Intra area: 2         Inter area: 1         ASE: 1         NSSA: 1        
<SW2> 

<SW4>dis ospfv3 routing 

               OSPFv3 Process 10 with Router ID 1.1.1.4
-------------------------------------------------------------------------
 I  - Intra area route,  E1 - Type 1 external route,  N1 - Type 1 NSSA route
 IA - Inter area route,  E2 - Type 2 external route,  N2 - Type 2 NSSA route
 *  - Selected route

 *Destination: 10::/64 
  Type       : IA                        Area       : 0.0.0.2
  AdvRouter  : 1.1.1.3                   Preference : 10
  NibID      : 0x23000002                Cost       : 3
  Interface  : GE1/0/3                   BkInterface: N/A                      
  Nexthop    : FE80::26A6:90FF:FE1E:308
  BkNexthop  : N/A

 *Destination: 11::/64 
  Type       : IA                        Area       : 0.0.0.2
  AdvRouter  : 1.1.1.3                   Preference : 10
  NibID      : 0x23000002                Cost       : 2
  Interface  : GE1/0/3                   BkInterface: N/A                      
  Nexthop    : FE80::26A6:90FF:FE1E:308
  BkNexthop  : N/A

 *Destination: 12::/64 
  Type       : I                         Area       : 0.0.0.2
  AdvRouter  : 1.1.1.4                   Preference : 10
  NibID      : 0x23000001                Cost       : 1
  Interface  : GE1/0/3                   BkInterface: N/A                      
  Nexthop    : ::
  BkNexthop  : N/A

 *Destination: 1::1/128 
  Type       : E2                        Tag        : 1
  AdvRouter  : 1.1.1.2                   Preference : 150
  NibID      : 0x23000002                Cost       : 1
  Interface  : GE1/0/3                   BkInterface: N/A                      
  Nexthop    : FE80::26A6:90FF:FE1E:308
  BkNexthop  : N/A

 Total: 4        
 Intra area: 1         Inter area: 2         ASE: 1         NSSA: 0        
<SW4>  

2、配置Totally NSSA区域后查看SW1、SW2和SW4的OSPFv3路由，可以看到，此时SW1上已经没有了此前的3类路由，但是多了一个3类的缺省路由，SW2上看SW1引入的路由类型还是7类，SW4上看SW1引入的路由还是5类

[SW1]dis ospfv3 routing 

               OSPFv3 Process 10 with Router ID 1.1.1.1
-------------------------------------------------------------------------
 I  - Intra area route,  E1 - Type 1 external route,  N1 - Type 1 NSSA route
 IA - Inter area route,  E2 - Type 2 external route,  N2 - Type 2 NSSA route
 *  - Selected route

 *Destination: ::/0 
  Type       : IA                        Area       : 0.0.0.1
  AdvRouter  : 1.1.1.2                   Preference : 10
  NibID      : 0x23000002                Cost       : 2
  Interface  : GE1/0/1                   BkInterface: N/A                      
  Nexthop    : FE80::26A6:88FF:FE9E:206
  BkNexthop  : N/A

 *Destination: 10::/64 
  Type       : I                         Area       : 0.0.0.1
  AdvRouter  : 1.1.1.2                   Preference : 10
  NibID      : 0x23000001                Cost       : 1
  Interface  : GE1/0/1                   BkInterface: N/A                      
  Nexthop    : ::
  BkNexthop  : N/A

 Total: 2        
 Intra area: 1         Inter area: 1         ASE: 0         NSSA: 0        
[SW1]   

[SW2]dis ospfv3 routing 

               OSPFv3 Process 10 with Router ID 1.1.1.2
-------------------------------------------------------------------------
 I  - Intra area route,  E1 - Type 1 external route,  N1 - Type 1 NSSA route
 IA - Inter area route,  E2 - Type 2 external route,  N2 - Type 2 NSSA route
 *  - Selected route

 *Destination: 10::/64 
  Type       : I                         Area       : 0.0.0.1
  AdvRouter  : 1.1.1.2                   Preference : 10
  NibID      : 0x23000001                Cost       : 1
  Interface  : GE1/0/1                   BkInterface: N/A                      
  Nexthop    : ::
  BkNexthop  : N/A

 *Destination: 11::/64 
  Type       : I                         Area       : 0.0.0.0
  AdvRouter  : 1.1.1.3                   Preference : 10
  NibID      : 0x23000002                Cost       : 1
  Interface  : GE1/0/2                   BkInterface: N/A                      
  Nexthop    : ::
  BkNexthop  : N/A

 *Destination: 12::/64 
  Type       : IA                        Area       : 0.0.0.0
  AdvRouter  : 1.1.1.3                   Preference : 10
  NibID      : 0x23000005                Cost       : 2
  Interface  : GE1/0/2                   BkInterface: N/A                      
  Nexthop    : FE80::26A6:90FF:FE1E:307
  BkNexthop  : N/A

 *Destination: 1::1/128 
  Type       : N2                        Tag        : 1
  AdvRouter  : 1.1.1.1                   Preference : 150
  NibID      : 0x23000003                Cost       : 1
  Interface  : GE1/0/1                   BkInterface: N/A                      
  Nexthop    : 10::1
  BkNexthop  : N/A

 *Destination: 1::4/128 
  Type       : E2                        Tag        : 1
  AdvRouter  : 1.1.1.4                   Preference : 150
  NibID      : 0x23000005                Cost       : 1
  Interface  : GE1/0/2                   BkInterface: N/A                      
  Nexthop    : FE80::26A6:90FF:FE1E:307
  BkNexthop  : N/A
               
 Total: 5        
 Intra area: 2         Inter area: 1         ASE: 1         NSSA: 1        
[SW2]

<SW4>dis ospfv3 routing 

               OSPFv3 Process 10 with Router ID 1.1.1.4
-------------------------------------------------------------------------
 I  - Intra area route,  E1 - Type 1 external route,  N1 - Type 1 NSSA route
 IA - Inter area route,  E2 - Type 2 external route,  N2 - Type 2 NSSA route
 *  - Selected route

 *Destination: 10::/64 
  Type       : IA                        Area       : 0.0.0.2
  AdvRouter  : 1.1.1.3                   Preference : 10
  NibID      : 0x23000002                Cost       : 3
  Interface  : GE1/0/3                   BkInterface: N/A                      
  Nexthop    : FE80::26A6:90FF:FE1E:308
  BkNexthop  : N/A

 *Destination: 11::/64 
  Type       : IA                        Area       : 0.0.0.2
  AdvRouter  : 1.1.1.3                   Preference : 10
  NibID      : 0x23000002                Cost       : 2
  Interface  : GE1/0/3                   BkInterface: N/A                      
  Nexthop    : FE80::26A6:90FF:FE1E:308
  BkNexthop  : N/A

 *Destination: 12::/64 
  Type       : I                         Area       : 0.0.0.2
  AdvRouter  : 1.1.1.4                   Preference : 10
  NibID      : 0x23000001                Cost       : 1
  Interface  : GE1/0/3                   BkInterface: N/A                      
  Nexthop    : ::
  BkNexthop  : N/A

 *Destination: 1::1/128 
  Type       : E2                        Tag        : 1
  AdvRouter  : 1.1.1.2                   Preference : 150
  NibID      : 0x23000002                Cost       : 1
  Interface  : GE1/0/3                   BkInterface: N/A                      
  Nexthop    : FE80::26A6:90FF:FE1E:308
  BkNexthop  : N/A

 Total: 4        
 Intra area: 1         Inter area: 2         ASE: 1         NSSA: 0        
<SW4>  


## 说明： 
1、Totally NSSA区域禁止3、4、5类LSA进入，但是允许引入外部路由，引入的外部路由会以7类LSA在NSSA域泛洪，进入普通区域时会转成5类LSA

2、OSPFv3支持Totally NSSA区域，其原理及应用环境与OSPFv2相同


