# 工程名称
策略路由下一跳与Track联动配置


## 需求：
策略路由通过与Track联动，增强了应用的灵活性和对网络环境变化的动态感知能力。当track结果失效时，引导报文从其他接口转发，避免丢包。



## 实验步骤：
1、配置接口地址<BR>
2、配置策略路由，指定下一跳并关联track，track与NQA探测结果关联<BR>
\#<BR>
track 1 nqa entry admin test reaction 1<BR>
\#<BR>
policy-based-route aaa permit node 0<BR>
 if-match acl 3000<BR>
 apply next-hop 1.1.1.2 track 1<BR>
 apply next-hop 2.2.2.2<BR>
\#<BR>
nqa entry admin test<BR>
 type icmp-echo<BR>
  destination ip 1.1.1.2<BR>
  frequency 100<BR>
  reaction 1 checked-element probe-fail threshold-type consecutive 5 action-type trigger-only<BR>
\#<BR>
 nqa schedule admin test start-time now lifetime forever<BR>
\#<BR>
interface GigabitEthernet0/0<BR>
 ip address 192.168.0.2 255.255.255.0<BR>
 ip policy-based-route aaa<BR>
\#<BR>
interface GigabitEthernet0/1<BR>
 ip address 1.1.1.1 255.255.255.252<BR>
\#<BR>
interface GigabitEthernet0/2
 ip address 2.2.2.1 255.255.255.252<BR>
\#<BR>
 ip route-static 8.8.8.8 32 1.1.1.2<BR>
 ip route-static 8.8.8.8 32 2.2.2.2<BR>
\#<BR>
acl advanced 3000<BR>
 rule 0 permit ip source 192.168.0.0 0.0.0.255<BR>
\#

## 测试结果：

正常测试时，策略路由指导通过ISP-1转发。<BR>
[RTA]tracert 8.8.8.8<BR>
traceroute to 8.8.8.8 (8.8.8.8), 30 hops at most, 40 bytes each packet, press CTRL+C to break<BR>
 1  192.168.0.2 (192.168.0.2)  1.160 ms  0.465 ms  0.282 ms<BR>
 2  1.1.1.2 (1.1.1.2)  0.466 ms  0.820 ms  0.660 ms<BR>

当NQA探测失败时，策略路由指导从ISP-2转发：<BR>
[RTA]tracert 8.8.8.8<BR>
traceroute to 8.8.8.8 (8.8.8.8), 30 hops at most, 40 bytes each packet, press CTRL+C to break<BR>
 1  192.168.0.2 (192.168.0.2)  0.953 ms  0.514 ms  0.487 ms<BR>
 2  2.2.2.2 (2.2.2.2)  0.862 ms  0.700 ms  0.849 ms

## 说明： 
策略路由可以在配置报文的下一跳、出接口、缺省下一跳、缺省出接口时与Track项关联，根据Track项的状态来动态地决定策略的可用性。策略路由配置仅在关联的Track项状态为Positive或NotReady时生效。
.