**安全策略不通问题debug排查实验**

**标签：**

安全策略

Debugging

ASPF

**需求：**

本实验用于指导基础用户如何排查过FW不通

本实验没有NAT，网络连通性全靠路由打通

组网如下：

MSR2（G0/0:10.0.0.1）\-\-\-\-\-\--(G1/0/1:10.0.0.2)FW1(G0/2:1.1.1.1)\-\-\-\--（G0/0:1.1.1.2）MSR3

其中FW1的G1/0/1属于trust安全域

FW2的G1/0/2属于UNtrust安全域

**实验步骤：**

在MSR2上ping MSR3的1.1.1.2，本实验故意不放通trust到untrust的安全策略

在FW1上写明源目IP，如果有NAT，NAT前后地址都要写，本实验没有NAT

acl advanced 3000

rule 0 permit ip source 10.0.0.1 0 destination 1.1.1.2 0

rule 5 permit ip source 1.1.1.2 0 destination 10.0.0.1 0

\<FW1\>debugging ip packet acl 3000

\<FW1\>debugging ip info acl 3000

\<FW1\>debugging security-policy packet ip acl 3000

\<FW1\>debugging aspf packet acl 3000

**测试结果：**

主要看两个位置有没有问题，第一个位置就是安全策略匹配情况

第二个就是ASPF检测情况

\[FW1\]\*Jan 22 08:22:28:310 2022 FW1 IPFW/7/IPFW_PACKET: -Context=1;

Receiving, interface = GigabitEthernet1/0/1

version = 4, headlen = 20, tos = 0

pktlen = 84, pktid = 11, offset = 0, ttl = 255, protocol = 1

checksum = 44954, s = 10.0.0.1, d = 1.1.1.2

channelID = 0, vpn-InstanceIn = 0, vpn-InstanceOut = 0.

prompt: Receiving IP packet from interface GigabitEthernet1/0/1.

Payload: ICMP

type = 8, code = 0, checksum = 0x233d.

以下内容是因为没有安全策略所以被FW deny，关键字样是The packet is denied

\*Jan 22 08:22:28:310 2022 FW1 FILTER/7/PACKET: -Context=1; The packet
is denied. Src-Zone=Trust,
Dst-Zone=Untrust;If-In=GigabitEthernet1/0/1(2),
If-Out=GigabitEthernet1/0/2(3); Packet Info:Src-IP=10.0.0.1,
Dst-IP=1.1.1.2, VPN-Instance=,Src-Port=8, Dst-Port=0, Protocol=ICMP(1),
Application=ICMP(22742), ACL=none, Rule-ID=none.

以下内容是FW的ASPF检测不通过，FW丢弃掉不合法报文，关键字样是The first
packet was dropped by packet filter or object-policy

\*Jan 22 08:22:28:310 2022 FW1 ASPF/7/PACKET: -Context=1; The first
packet was dropped by packet filter or object-policy. Src-Zone=Trust,
Dst-Zone=Untrust;If-In=GigabitEthernet1/0/1(2),
If-Out=GigabitEthernet1/0/2(3); Packet Info:Src-IP=10.0.0.1,
Dst-IP=1.1.1.2, VPN-Instance=none, Src-Port=10955, Dst-Port=2048.
Protocol=ICMP(1).

\*Jan 22 08:22:28:310 2022 FW1 IPFW/7/IPFW_INFO: -Context=1;

MBUF was intercepted! Phase Num is 8(post routing beforefrag), Service
ID is 3(interzone), Bitmap is 10040000, return 1(0:continue, 1:dropped,
2:consumed, 3:enqueued, 4:relay)! Interface is GigabitEthernet1/0/2,

s= 10.0.0.1, d= 1.1.1.2, protocol= 1, pktid = 11.

\*Jan 22 08:22:30:321 2022 FW1 IPFW/7/IPFW_PACKET: -Context=1;

Receiving, interface = GigabitEthernet1/0/1

version = 4, headlen = 20, tos = 0

pktlen = 84, pktid = 12, offset = 0, ttl = 255, protocol = 1

checksum = 44953, s = 10.0.0.1, d = 1.1.1.2

channelID = 0, vpn-InstanceIn = 0, vpn-InstanceOut = 0.

prompt: Receiving IP packet from interface GigabitEthernet1/0/1.

Payload: ICMP

type = 8, code = 0, checksum = 0x0e27.

**说明：**

关键配置如下：

FW1

interface GigabitEthernet1/0/2

port link-mode route

combo enable copper

ip address 1.1.1.1 255.255.255.0

interface GigabitEthernet1/0/1

port link-mode route

combo enable copper

ip address 10.0.0.2 255.255.255.0

security-zone name Trust

import interface GigabitEthernet1/0/1

security-zone name Untrust

import interface GigabitEthernet1/0/2

Security-policy ip

rule 0 name trust-local

action pass

source-zone trust

destination-zone local

rule 1 name local-untrust

action pass

source-zone local

destination-zone untrust

rule 3 name untrust-trust

action pass

source-zone untrust

destination-zone trust

rule 4 name untrust-local

action pass

source-zone untrust

destination-zone locaL

rule 5 name local-trust

action pass

source-zone local

destination-zone trust

MSR3

interface GigabitEthernet0/0

port link-mode route

combo enable copper

ip address 1.1.1.2 255.255.255.0

ip route-static 10.0.0.0 0 1.1.1.1
