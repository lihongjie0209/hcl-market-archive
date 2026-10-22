# 工程名称
V7交换机策略路由配置


## 需求：
某企业原有一条电信出口(100.0.23.2)线路,内网所有终端访问网部资源都走这条出口线路，现在因为业务需要新增了一条专线出口(101.0.13.1)，要求内网172.16.4.0/24网段访问所有外网资源都优先走专线，其他网段还是走电信出口


## 实验步骤：
1、SW1配置接口ip和去往电信链路的默认路由
#
interface GigabitEthernet1/0/4
 port link-mode bridge
 port access vlan 4
#
interface GigabitEthernet1/0/5
 port link-mode bridge
 port access vlan 5
#
interface NULL0
#
interface Vlan-interface4
 ip address 172.16.4.1 255.255.255.0
#
interface Vlan-interface5
 ip address 172.16.5.1 255.255.255.0
#
interface FortyGigE1/0/53
 port link-mode bridge
#
interface FortyGigE1/0/54
 port link-mode bridge
#
interface GigabitEthernet1/0/1
 port link-mode route
 combo enable fiber
 ip address 101.0.13.3 255.255.255.0
#
interface GigabitEthernet1/0/2
 port link-mode route
 combo enable fiber
 ip address 100.0.23.3 255.255.255.0
#
 ip route-static 0.0.0.0 0 100.0.23.2
#

2、SW1配置acl分别匹配172.16.4.0/24访问内网的数据和172.16.4.0/24访问外网的数据
#
acl advanced 3000
 rule 0 permit ip source 172.16.4.0 0.0.0.255 destination 172.16.5.0 0.0.0.255
#
acl advanced 3005
 rule 0 permit ip source 172.16.4.0 0.0.0.255
#

3、SW1配置策略路由，node 5匹配172.16.4.0/24访问内网的acl，不做任何处理，按全局路由表转发。node 10匹配172.16.4.0/24访问外网的acl，指定下一跳地址是专线对端地址101.0.13.1
#
policy-based-route pbr permit node 5
 if-match acl 3000
#
policy-based-route pbr permit node 10
 if-match acl 3005
 apply next-hop 101.0.13.1
#
interface Vlan-interface4
 ip policy-based-route pbr
#

## 测试结果：
1、172.16.4.4可以访问专线侧地址101.0.14.1，172.16.5.5无法访问
<PC1>ping 101.0.14.1
Ping 101.0.14.1 (101.0.14.1): 56 data bytes, press CTRL+C to break
56 bytes from 101.0.14.1: icmp_seq=0 ttl=254 time=1.000 ms
56 bytes from 101.0.14.1: icmp_seq=1 ttl=254 time=1.000 ms

<PC2>ping 101.0.14.1
Ping 101.0.14.1 (101.0.14.1): 56 data bytes, press CTRL+C to break
Request time out
Request time out

2、172.16.5.5可以访问电信侧地址100.0.24.1，172.16.4.4无法访问
<PC2>ping 100.0.24.1
Ping 100.0.24.1 (100.0.24.1): 56 data bytes, press CTRL+C to break
56 bytes from 100.0.24.1: icmp_seq=0 ttl=254 time=1.000 ms
56 bytes from 100.0.24.1: icmp_seq=1 ttl=254 time=1.000 ms

<PC1>ping 100.0.24.1
Ping 100.0.24.1 (100.0.24.1): 56 data bytes, press CTRL+C to break
Request time out
Request time out

## 说明： 
1、策略路由优先级高于全局路由表

2、配置策略路由时，为了不影响到内网互访的数据，可以先配置一个空节点去匹配这类数据，然后不配置apply相关命令，即按照路由表转发

3、策略用来定义报文的匹配规则，以及对报文执行的操作。策略由节点组成。
一个策略可以包含一个或者多个节点。节点的构成如下：
① 每个节点由节点编号来标识。节点编号越小节点的优先级越高，优先级高的节点优先被执行。
② 每个节点的具体内容由if-match子句和apply子句来指定。if-match子句定义该节点的匹配规则，apply子句定义该节点的动作。
③每个节点对报文的处理方式由匹配模式决定。匹配模式分为permit（允许）和deny（拒绝）两种。
应用策略后，系统将根据策略中定义的匹配规则和操作，对报文进行处理：系统按照优先级从高到低的顺序依次匹配各节点，如果报文满足这个节点的匹配规则，就执行该节点的动作；如果报文不满足这个节点的匹配规则，就继续匹配下一个节点；如果报文不能满足策略中任何一个节点的匹配规则，则根据路由表来转发报文。
