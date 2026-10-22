# 工程名称
V7交换机ipv6策略路由配置


## 需求：
某企业有两个IPV6出口，要求内网4::0/64网段访问10::1/128时按照全局路由表走出口1，4::0/64访问其他地址时走出口2


## 实验步骤：
1、配置接口ip和去往出口1的默认路由
#
 ipv6 route-static :: 0 1::1
#

2、配置acl分别匹配4::064访问10::1/128的数据和4::0/64访问其他地址的数据
#
acl ipv6 advanced 3000
 rule 0 permit ipv6 source 4::/64 destination 10::1/128
#
acl ipv6 advanced 3005
 rule 0 permit ipv6 source 4::/64
#

3、配置ipv6策略路由，node 10匹配4::0/64访问10::1/128的acl，不做任何处理，按全局路由表转发。node 15匹配4::0/64访问其他地址的acl，指定下一跳地址是出口2网关2::1
#
ipv6 policy-based-route v6pbr permit node 10
 if-match acl 3000
#              
ipv6 policy-based-route v6pbr permit node 15
 if-match acl 3005
 apply next-hop 2::1
#

4、连接4::0/64侧的接口应用上述策略路由
#
interface GigabitEthernet1/0/4
 port link-mode route
 ipv6 policy-based-route v6pbr
 ipv6 address 4::1/64
#



## 测试结果：
1、应用策略路由前：
[PC1]ping ipv6 10::1
Ping6(56 data bytes) 4::4 --> 10::1, press CTRL+C to break
56 bytes from 10::1, icmp_seq=0 hlim=63 time=1.000 ms
56 bytes from 10::1, icmp_seq=1 hlim=63 time=1.000 ms
56 bytes from 10::1, icmp_seq=2 hlim=63 time=1.000 ms
56 bytes from 10::1, icmp_seq=3 hlim=63 time=1.000 ms
56 bytes from 10::1, icmp_seq=4 hlim=63 time=1.000 ms

--- Ping6 statistics for 10::1 ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss
round-trip min/avg/max/std-dev = 1.000/1.000/1.000/0.000 ms

[PC1]
[PC1]ping ipv6 20::1
Ping6(56 data bytes) 4::4 --> 20::1, press CTRL+C to break
Request time out
Request time out
Request time out
Request time out
Request time out

--- Ping6 statistics for 20::1 ---
5 packet(s) transmitted, 0 packet(s) received, 100.0% packet loss


2、应用策略路由后：
[PC1]ping ipv6 10::1
Ping6(56 data bytes) 4::4 --> 10::1, press CTRL+C to break
56 bytes from 10::1, icmp_seq=0 hlim=63 time=2.000 ms
56 bytes from 10::1, icmp_seq=1 hlim=63 time=1.000 ms
56 bytes from 10::1, icmp_seq=2 hlim=63 time=1.000 ms
56 bytes from 10::1, icmp_seq=3 hlim=63 time=1.000 ms
56 bytes from 10::1, icmp_seq=4 hlim=63 time=1.000 ms

--- Ping6 statistics for 10::1 ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss
round-trip min/avg/max/std-dev = 1.000/1.200/2.000/0.400 ms
[PC1]
[PC1]ping ipv6 20::1
Ping6(56 data bytes) 4::4 --> 20::1, press CTRL+C to break
56 bytes from 20::1, icmp_seq=0 hlim=63 time=2.000 ms
56 bytes from 20::1, icmp_seq=1 hlim=63 time=1.000 ms
56 bytes from 20::1, icmp_seq=2 hlim=63 time=1.000 ms
56 bytes from 20::1, icmp_seq=3 hlim=63 time=1.000 ms
56 bytes from 20::1, icmp_seq=4 hlim=63 time=1.000 ms

--- Ping6 statistics for 20::1 ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss


## 说明： 
1、策略路由优先级高于全局路由表
2、配置策略路由时，为了不影响到内网互访的数据，可以先配置一个空节点去匹配这类数据，然后不配置apply相关命令，即按照路由表转发
3、策略用来定义报文的匹配规则，以及对报文执行的操作。策略由节点组成。
一个策略可以包含一个或者多个节点。节点的构成如下：
① 每个节点由节点编号来标识。节点编号越小节点的优先级越高，优先级高的节点优先被执行。
② 每个节点的具体内容由if-match子句和apply子句来指定。if-match子句定义该节点的匹配规则，apply子句定义该节点的动作。
③每个节点对报文的处理方式由匹配模式决定。匹配模式分为permit（允许）和deny（拒绝）两种。
应用策略后，系统将根据策略中定义的匹配规则和操作，对报文进行处理：系统按照优先级从高到低的顺序依次匹配各节点，如果报文满足这个节点的匹配规则，就执行该节点的动作；如果报文不满足这个节点的匹配规则，就继续匹配下一个节点；如果报文不能满足策略中任何一个节点的匹配规则，则根据路由表来转发报文。
4、如果一个节点中未配置任何if-match子句，则认为所有报文都满足该节点的匹配规则



