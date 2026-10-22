**标签：**

IPSEC

FQDN

TUNNEL

路由注入

**需求：**

FW1作为总部，和分支FW3/FW4建立ipsec隧道，采用模板方式，总部不写感兴趣流，分支侧触发，建立隧道后，总部侧自动生成到分支的静态路由，隧道删除后相应路由删除。


实验步骤：总部和分支配置相关安全策略和ipsec，本实验使用loopback0口代替内网用户；之后由分支侧带源ping总部，建立隧道；在总部侧查看路由；
reset ike sa和ipsec sa后再次查看路由。

**现象：**

**隧道建立前：**

**总部：**

\<H3C\>dis ip routing-table

Destinations : 17 Routes : 17

Destination/Mask Proto Pre Cost NextHop Interface

0.0.0.0/0 Static 60 0 1.1.1.1 GE1/0/1

0.0.0.0/32 Direct 0 0 127.0.0.1 InLoop0

1.1.1.0/30 Direct 0 0 1.1.1.2 GE1/0/1

1.1.1.0/32 Direct 0 0 1.1.1.2 GE1/0/1

1.1.1.2/32 Direct 0 0 127.0.0.1 InLoop0

1.1.1.3/32 Direct 0 0 1.1.1.2 GE1/0/1

127.0.0.0/8 Direct 0 0 127.0.0.1 InLoop0

127.0.0.0/32 Direct 0 0 127.0.0.1 InLoop0

127.0.0.1/32 Direct 0 0 127.0.0.1 InLoop0

127.255.255.255/32 Direct 0 0 127.0.0.1 InLoop0

192.168.10.0/24 Direct 0 0 192.168.10.1 Loop0

192.168.10.0/32 Direct 0 0 192.168.10.1 Loop0

192.168.10.1/32 Direct 0 0 127.0.0.1 InLoop0

192.168.10.255/32 Direct 0 0 192.168.10.1 Loop0

224.0.0.0/4 Direct 0 0 0.0.0.0 NULL0

224.0.0.0/24 Direct 0 0 0.0.0.0 NULL0

255.255.255.255/32 Direct 0 0 127.0.0.1 InLoop0

\<H3C\>dis ike sa

Connection-ID Remote Flag DOI

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

\<H3C\>dis ipsec sa

**隧道建立：**

**分支1：**

\<H3C\>ping -a 192.168.20.1 192.168.10.1

Ping 192.168.10.1 (192.168.10.1) from 192.168.20.1: 56 data bytes, press
CTRL_C to break

Request time out

56 bytes from 192.168.10.1: icmp_seq=1 ttl=255 time=0.000 ms

56 bytes from 192.168.10.1: icmp_seq=2 ttl=255 time=1.000 ms

56 bytes from 192.168.10.1: icmp_seq=3 ttl=255 time=1.000 ms

56 bytes from 192.168.10.1: icmp_seq=4 ttl=255 time=1.000 ms

\-\-- Ping statistics for 192.168.10.1 \-\--

5 packet(s) transmitted, 4 packet(s) received, 20.0% packet loss

round-trip min/avg/max/std-dev = 0.000/0.750/1.000/0.433 ms

\<H3C\>%Jan 24 14:23:51:758 2022 H3C PING/6/PING_STATISTICS: -Context=1;
Ping statistics for 192.168.10.1: 5 packet(s) transmitted, 4 packet(s)
received, 20.0% packet loss, round-trip min/avg/max/std-dev =
0.000/0.750/1.000/0.433 ms.

\<H3C\>dis ike sa

Connection-ID Remote Flag DOI

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

2 1.1.1.2 RD IPsec

Flags:

RD\--READY RL\--REPLACED FD-FADING RK-REKEY

\<H3C\>dis ipsec sa

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Interface: GigabitEthernet1/0/1

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

IPsec policy: 1

Sequence number: 1

Mode: ISAKMP

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Tunnel id: 0

Encapsulation mode: tunnel

Perfect Forward Secrecy:

Inside VPN:

Extended Sequence Numbers enable: N

Traffic Flow Confidentiality enable: N

Path MTU: 1444

Tunnel:

local address: 2.2.2.2

remote address: 1.1.1.2

Flow:

sour addr: 192.168.20.0/255.255.255.0 port: 0 protocol: ip

dest addr: 192.168.10.0/255.255.255.0 port: 0 protocol: ip

**分支2**：

\<H3C\>ping -a 192.168.30.1 192.168.10.1

Ping 192.168.10.1 (192.168.10.1) from 192.168.30.1: 56 data bytes, press
CTRL_C to break

Request time out

56 bytes from 192.168.10.1: icmp_seq=1 ttl=255 time=1.000 ms

56 bytes from 192.168.10.1: icmp_seq=2 ttl=255 time=0.000 ms

56 bytes from 192.168.10.1: icmp_seq=3 ttl=255 time=0.000 ms

56 bytes from 192.168.10.1: icmp_seq=4 ttl=255 time=1.000 ms

\-\-- Ping statistics for 192.168.10.1 \-\--

5 packet(s) transmitted, 4 packet(s) received, 20.0% packet loss

round-trip min/avg/max/std-dev = 0.000/0.500/1.000/0.500 ms

\<H3C\>%Jan 24 14:25:24:551 2022 H3C PING/6/PING_STATISTICS: -Context=1;
Ping statistics for 192.168.10.1: 5 packet(s) transmitted, 4 packet(s)
received, 20.0% packet loss, round-trip min/avg/max/std-dev =
0.000/0.500/1.000/0.500 ms.

\<H3C\>dis ike sa

Connection-ID Remote Flag DOI

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

2 1.1.1.2 RD IPsec

Flags:

RD\--READY RL\--REPLACED FD-FADING RK-REKEY

\<H3C\>dis ipsec sa

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Interface: GigabitEthernet1/0/2

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

IPsec policy: 1

Sequence number: 1

Mode: ISAKMP

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Tunnel id: 0

Encapsulation mode: tunnel

Perfect Forward Secrecy:

Inside VPN:

Extended Sequence Numbers enable: N

Traffic Flow Confidentiality enable: N

Path MTU: 1444

Tunnel:

local address: 3.3.3.2

remote address: 1.1.1.2

Flow:

sour addr: 192.168.30.0/255.255.255.0 port: 0 protocol: ip

dest addr: 192.168.10.0/255.255.255.0 port: 0 protocol: ip

**总部**：

\<H3C\>dis ike sa

Connection-ID Remote Flag DOI

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

3 2.2.2.2 RD IPsec

4 3.3.3.2 RD IPsec

Flags:

RD\--READY RL\--REPLACED FD-FADING RK-REKEY

\<H3C\>dis ipsec sa

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Interface: GigabitEthernet1/0/1

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

IPsec policy: test

Sequence number: 1

Mode: Template

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Tunnel id: 1

Encapsulation mode: tunnel

Perfect Forward Secrecy:

Inside VPN:

Extended Sequence Numbers enable: N

Traffic Flow Confidentiality enable: N

Path MTU: 1444

Tunnel:

local address: 1.1.1.2

remote address: 2.2.2.2

Flow:

sour addr: 192.168.10.0/255.255.255.0 port: 0 protocol: ip

dest addr: 192.168.20.0/255.255.255.0 port: 0 protocol: ip

\[Inbound ESP SAs\]

SPI: 3755923342 (0xdfded78e)

Connection ID: 12884901891

Transform set: ESP-ENCRYPT-3DES-CBC ESP-AUTH-MD5

SA duration (kilobytes/sec): 1843200/3600

SA remaining duration (kilobytes/sec): 1843199/3526

Max received sequence-number: 4

Anti-replay check enable: Y

Anti-replay window size: 64

UDP encapsulation used for NAT traversal: N

Status: Active

\[Outbound ESP SAs\]

SPI: 4288813145 (0xffa21859)

Connection ID: 12884901890

Transform set: ESP-ENCRYPT-3DES-CBC ESP-AUTH-MD5

SA duration (kilobytes/sec): 1843200/3600

SA remaining duration (kilobytes/sec): 1843199/3526

Max sent sequence-number: 4

UDP encapsulation used for NAT traversal: N

Status: Active

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

IPsec policy: test

Sequence number: 2

Mode: Template

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Tunnel id: 0

Encapsulation mode: tunnel

Perfect Forward Secrecy:

Inside VPN:

Extended Sequence Numbers enable: N

Traffic Flow Confidentiality enable: N

Path MTU: 1444

Tunnel:

local address: 1.1.1.2

remote address: 3.3.3.2

Flow:

sour addr: 192.168.10.0/255.255.255.0 port: 0 protocol: ip

dest addr: 192.168.30.0/255.255.255.0 port: 0 protocol: ip

\[Inbound ESP SAs\]

SPI: 2078299474 (0x7be05552)

Connection ID: 12884901889

Transform set: ESP-ENCRYPT-3DES-CBC ESP-AUTH-MD5

SA duration (kilobytes/sec): 1843200/3600

SA remaining duration (kilobytes/sec): 1843199/3568

Max received sequence-number: 4

Anti-replay check enable: Y

Anti-replay window size: 64

UDP encapsulation used for NAT traversal: N

Status: Active

\[Outbound ESP SAs\]

SPI: 740542814 (0x2c23c95e)

Connection ID: 12884901888

Transform set: ESP-ENCRYPT-3DES-CBC ESP-AUTH-MD5

SA duration (kilobytes/sec): 1843200/3600

SA remaining duration (kilobytes/sec): 1843199/3568

Max sent sequence-number: 4

UDP encapsulation used for NAT traversal: N

Status: Active

\<H3C\>dis ip rou

\<H3C\>dis ip routing-table

Destinations : 19 Routes : 19

Destination/Mask Proto Pre Cost NextHop Interface

0.0.0.0/0 Static 60 0 1.1.1.1 GE1/0/1

0.0.0.0/32 Direct 0 0 127.0.0.1 InLoop0

1.1.1.0/30 Direct 0 0 1.1.1.2 GE1/0/1

1.1.1.0/32 Direct 0 0 1.1.1.2 GE1/0/1

1.1.1.2/32 Direct 0 0 127.0.0.1 InLoop0

1.1.1.3/32 Direct 0 0 1.1.1.2 GE1/0/1

127.0.0.0/8 Direct 0 0 127.0.0.1 InLoop0

127.0.0.0/32 Direct 0 0 127.0.0.1 InLoop0

127.0.0.1/32 Direct 0 0 127.0.0.1 InLoop0

127.255.255.255/32 Direct 0 0 127.0.0.1 InLoop0

192.168.10.0/24 Direct 0 0 192.168.10.1 Loop0

192.168.10.0/32 Direct 0 0 192.168.10.1 Loop0

192.168.10.1/32 Direct 0 0 127.0.0.1 InLoop0

192.168.10.255/32 Direct 0 0 192.168.10.1 Loop0

192.168.20.0/24 Static 100 0 2.2.2.2 GE1/0/1

192.168.30.0/24 Static 100 0 3.3.3.2 GE1/0/1

224.0.0.0/4 Direct 0 0 0.0.0.0 NULL0

224.0.0.0/24 Direct 0 0 0.0.0.0 NULL0

255.255.255.255/32 Direct 0 0 127.0.0.1 InLoop0

\<H3C\>

**删除隧道：**\
**总部：可以看到路由也被删除了\
**\<H3C\>reset ike sa

\<H3C\>res

\<H3C\>reset ipse sa

\<H3C\>

\<H3C\>

\<H3C\>dis ip rou

\<H3C\>dis ip routing-table

Destinations : 17 Routes : 17

Destination/Mask Proto Pre Cost NextHop Interface

0.0.0.0/0 Static 60 0 1.1.1.1 GE1/0/1

0.0.0.0/32 Direct 0 0 127.0.0.1 InLoop0

1.1.1.0/30 Direct 0 0 1.1.1.2 GE1/0/1

1.1.1.0/32 Direct 0 0 1.1.1.2 GE1/0/1

1.1.1.2/32 Direct 0 0 127.0.0.1 InLoop0

1.1.1.3/32 Direct 0 0 1.1.1.2 GE1/0/1

127.0.0.0/8 Direct 0 0 127.0.0.1 InLoop0

127.0.0.0/32 Direct 0 0 127.0.0.1 InLoop0

127.0.0.1/32 Direct 0 0 127.0.0.1 InLoop0

127.255.255.255/32 Direct 0 0 127.0.0.1 InLoop0

192.168.10.0/24 Direct 0 0 192.168.10.1 Loop0

192.168.10.0/32 Direct 0 0 192.168.10.1 Loop0

192.168.10.1/32 Direct 0 0 127.0.0.1 InLoop0

192.168.10.255/32 Direct 0 0 192.168.10.1 Loop0

224.0.0.0/4 Direct 0 0 0.0.0.0 NULL0

224.0.0.0/24 Direct 0 0 0.0.0.0 NULL0

255.255.255.255/32 Direct 0 0 127.0.0.1 InLoop0

**相关说明：本实验基于模拟器HCL
v3.0.1完成，设备内存均配置为512M，选用防火墙为F1060,路由器为MSR36-20。**
