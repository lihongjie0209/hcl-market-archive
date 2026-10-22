# 工程名称
V7交换机OSPF验证


## 需求：
为保证路由安全性，配置OSPF验证，其中area0使用区域验证，area1使用接口验证


## 实验步骤：
1、配置接口ip，以SW3为例
#
interface GigabitEthernet1/0/2
 port link-mode bridge
 port access vlan 20
#
interface GigabitEthernet1/0/3
 port link-mode bridge
 port access vlan 30
#

2、配置ospf area 0 区域验证，以SW3为例
#
ospf 1 router-id 1.1.1.3
 area 0.0.0.0
  authentication-mode simple plain 12345
  network 10.0.23.3 0.0.0.0
#


3、配置ospf area 1 接口验证，以SW3为例
#
interface Vlan-interface30
 ospf authentication-mode simple plain 1234
#

## 测试结果：
1、area 0和area1内路由器使用相同的密钥，邻居关系建立正常
[SW3]dis ospf peer

         OSPF Process 1 with Router ID 1.1.1.3
               Neighbor Brief Information

 Area: 0.0.0.0        
 Router ID       Address         Pri Dead-Time  State             Interface
 1.1.1.2         10.0.23.2       1   36         Full/BDR          Vlan20

 Area: 0.0.0.1        
 Router ID       Address         Pri Dead-Time  State             Interface
 1.1.1.4         10.0.34.4       1   36         Full/DR           Vlan30
[SW3]


## 说明： 
1、OSPF路由器建立邻居关系时，在发送的报文中会携带验证模式等信息，接收报文时进行验证，只有通过验证的报文才能接收，否则将不会接收报文，不能正常建立邻居。

2、如果区域验证和接口验证都进行了配置，以接口验证的配置为准。

3、一个区域中所有路由器的验证模式必须一致，如果设置了密钥，需要保证密钥的一致性。

4、邻居路由器两端接口的验证模式必须一致，如果设置了密钥，需要保证密钥的一致性。


