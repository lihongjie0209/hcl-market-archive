**访问防火墙本地安全策略配置实验**

**标签：**

安全策略

会话

安全域

LOCAL域

**需求：**

本实验用于指导基础用户学习FW安全策略应该如何去配置

本实验没有NAT，网络连通性全靠路由打通

组网如下：

MSR2（G0/0:10.0.0.1）\-\-\-\-\-\--(G1/0/1:10.0.0.2)FW1(G0/2:1.1.1.1)\-\-\-\--（G0/0:1.1.1.2）MSR3

其中FW1的G1/0/1属于trust安全域

FW2的G1/0/2属于UNtrust安全域

防火墙的报文转发是基于会话的，并且是有方向的

**实验步骤：**

（1）如果想要MSR2可以访问FW1的10.0.0.2，就需要放通FW1的G1/0/1接口所在的安全域到FW1本地的安全策略

即trust到local的安全策略

Security-policy ip

rule 0 name trust-local

action pass

source-zone trust

destination-zone local

**测试结果：**

放通trust-local的安全策略，此时在MSR2上ping 10.0.0.2可以ping通，

\[MSR2\]ping 10.0.0.2

Ping 10.0.0.2 (10.0.0.2): 56 data bytes, press CTRL+C to break

56 bytes from 10.0.0.2: icmp_seq=0 ttl=255 time=1.000 ms

56 bytes from 10.0.0.2: icmp_seq=1 ttl=255 time=0.000 ms

56 bytes from 10.0.0.2: icmp_seq=2 ttl=255 time=2.000 ms

56 bytes from 10.0.0.2: icmp_seq=3 ttl=255 time=1.000 ms

56 bytes from 10.0.0.2: icmp_seq=4 ttl=255 time=0.000 ms

在防火墙上可以看到10.0.0.1到10.0.0.2的ICMP会话，要想看到报文统计个数，请先在全局系统下将会话统计功能打开（session
statistics enable）

\[FW1\]display session table ipv4 protocol icmp verbose

Slot 1:

Initiator:

Source IP/port: 10.0.0.1/10979

Destination IP/port: 10.0.0.2/2048

DS-Lite tunnel peer: -

VPN instance/VLAN ID/Inline ID: -/-/-

Protocol: ICMP(1)

Inbound interface: GigabitEthernet1/0/1

Source security zone: Trust

Responder:

Source IP/port: 10.0.0.2/10979

Destination IP/port: 10.0.0.1/0

DS-Lite tunnel peer: -

VPN instance/VLAN ID/Inline ID: -/-/-

Protocol: ICMP(1)

Inbound interface: InLoopBack0

Source security zone: Local

State: ICMP_REPLY

Application: ICMP

Rule ID: 0

Rule name: trust-local

Start time: 2022-01-21 16:04:14 TTL: 28s

Initiator-\>Responder: 5 packets 420 bytes

Responder-\>Initiator: 5 packets 420 bytes

（2）如果要FW1的1.1.1.1访问MSR3的1.1.1.3，FW1的本地访问FW1的G1/0/2接口所在的安全域，

即local-untrust的安全策略要放通

Security-policy ip

rule 1 name local-untrust

action pass

source-zone local

destination-zone untrust

**测试结果**

配置以上安全策略之后，FW1的1.1.1.1就可以ping通MSR3的1.1.1.2，并且FW1上可以看到

1.1.1.1到1.1.1.2的ICMP会话

\[FW1\]ping 1.1.1.2

Ping 1.1.1.2 (1.1.1.2): 56 data bytes, press CTRL_C to break

56 bytes from 1.1.1.2: icmp_seq=0 ttl=255 time=1.000 ms

56 bytes from 1.1.1.2: icmp_seq=1 ttl=255 time=0.000 ms

56 bytes from 1.1.1.2: icmp_seq=2 ttl=255 time=1.000 ms

56 bytes from 1.1.1.2: icmp_seq=3 ttl=255 time=0.000 ms

56 bytes from 1.1.1.2: icmp_seq=4 ttl=255 time=0.000 ms

\[FW1\]display session table ipv4 protocol icmp verbose

Slot 1:

Initiator:

Source IP/port: 1.1.1.1/539

Destination IP/port: 1.1.1.2/2048

DS-Lite tunnel peer: -

VPN instance/VLAN ID/Inline ID: -/-/-

Protocol: ICMP(1)

Inbound interface: InLoopBack0

Source security zone: Local

Responder:

Source IP/port: 1.1.1.2/539

Destination IP/port: 1.1.1.1/0

DS-Lite tunnel peer: -

VPN instance/VLAN ID/Inline ID: -/-/-

Protocol: ICMP(1)

Inbound interface: GigabitEthernet1/0/2

Source security zone: Untrust

State: ICMP_REPLY

Application: ICMP

Rule ID: 1

Rule name: local-untrust

Start time: 2022-01-21 16:15:35 TTL: 21s

Initiator-\>Responder: 5 packets 420 bytes

Responder-\>Initiator: 5 packets 420 bytes

（3）如果MSR2的10.0.0.1要访问MSR3的1.1.1.2、即FW1接口G1/0/1所在的安全域

访问接口G1/0/2所在的安全域，trust-untrust，就需要放通trust到untrust的安全策略

Security-policy ip

rule 2 name turst-untrust

action pass

source-zone trust

destination-zone untrust

**测试结果：**

完成以上配置，在MSR2上使用10.0.0.1pingMSR3的1.1.1.2可以ping通，在FW1上可以看到

10.0.0.1到1.1.1.2的ICMP会话

\<MSR2\>ping 1.1.1.2

Ping 1.1.1.2 (1.1.1.2): 56 data bytes, press CTRL+C to break

56 bytes from 1.1.1.2: icmp_seq=0 ttl=254 time=1.000 ms

56 bytes from 1.1.1.2: icmp_seq=1 ttl=254 time=2.000 ms

56 bytes from 1.1.1.2: icmp_seq=2 ttl=254 time=1.000 ms

56 bytes from 1.1.1.2: icmp_seq=3 ttl=254 time=0.000 ms

56 bytes from 1.1.1.2: icmp_seq=4 ttl=254 time=1.000 ms

\[FW1\]display session table ipv4 protocol icmp verbose

Slot 1:

Initiator:

Source IP/port: 10.0.0.1/10990

Destination IP/port: 1.1.1.2/2048

DS-Lite tunnel peer: -

VPN instance/VLAN ID/Inline ID: -/-/-

Protocol: ICMP(1)

Inbound interface: GigabitEthernet1/0/1

Source security zone: Trust

Responder:

Source IP/port: 1.1.1.2/10990

Destination IP/port: 10.0.0.1/0

DS-Lite tunnel peer: -

VPN instance/VLAN ID/Inline ID: -/-/-

Protocol: ICMP(1)

Inbound interface: GigabitEthernet1/0/2

Source security zone: Untrust

State: ICMP_REPLY

Application: ICMP

Rule ID: 2

Rule name: turst-untrust

Start time: 2022-01-21 16:19:10 TTL: 16s

Initiator-\>Responder: 5 packets 420 bytes

Responder-\>Initiator: 5 packets 420 bytes

（4）如果MSR3的1.1.1.2要访问MSR2的10.0.0.1.即FW1接口G1/0/2

所在的安全域到接口G1/0/1接口所在的安全域，untrust-trust，就需要放通

untrust-trust的安全策略

Security-policy ip

rule 3 name untrust-trust

action pass

source-zone untrust

destination-zone trust

**测试结果：**

完成了以上配置，在MSR3上可以ping通MSR2的10.0.0.1,并且在FW1上可以看到

1.1.1.2到10.0.0.1的ICMP会话

\[MSR3\]ping 10.0.0.1

Ping 10.0.0.1 (10.0.0.1): 56 data bytes, press CTRL+C to break

56 bytes from 10.0.0.1: icmp_seq=0 ttl=254 time=2.000 ms

56 bytes from 10.0.0.1: icmp_seq=1 ttl=254 time=1.000 ms

56 bytes from 10.0.0.1: icmp_seq=2 ttl=254 time=0.000 ms

56 bytes from 10.0.0.1: icmp_seq=3 ttl=254 time=2.000 ms

56 bytes from 10.0.0.1: icmp_seq=4 ttl=254 time=1.000 ms

\[FW1\]display session table ipv4 protocol icmp

Slot 1:

Initiator:

Source IP/port: 1.1.1.2/10976

Destination IP/port: 10.0.0.1/2048

DS-Lite tunnel peer: -

VPN instance/VLAN ID/Inline ID: -/-/-

Protocol: ICMP(1)

Inbound interface: GigabitEthernet1/0/2

Source security zone: Untrust

Total sessions found: 1

\[FW1\]display session table ipv4 protocol icmp v

\[FW1\]display session table ipv4 protocol icmp verbose

Slot 1:

Initiator:

Source IP/port: 1.1.1.2/10976

Destination IP/port: 10.0.0.1/2048

DS-Lite tunnel peer: -

VPN instance/VLAN ID/Inline ID: -/-/-

Protocol: ICMP(1)

Inbound interface: GigabitEthernet1/0/2

Source security zone: Untrust

Responder:

Source IP/port: 10.0.0.1/10976

Destination IP/port: 1.1.1.2/0

DS-Lite tunnel peer: -

VPN instance/VLAN ID/Inline ID: -/-/-

Protocol: ICMP(1)

Inbound interface: GigabitEthernet1/0/1

Source security zone: Trust

State: ICMP_REPLY

Application: ICMP

Rule ID: 3

Rule name: untrust-trust

Start time: 2022-01-21 16:23:22 TTL: 18s

Initiator-\>Responder: 5 packets 420 bytes

Responder-\>Initiator: 5 packets 420 bytes

（5）如果MSR3想要访问FW1的1.1.1.1，需要放通untrust到local的安全策略

如果FW1的10.0.0.2想要访问MSR2的10.0.0.1，需要放通local到trust的安全策略

这里不再赘述，测试方法可以看到（1）到（4）

**说明：**

详细配置如下：

MSR2

interface GigabitEthernet0/0

port link-mode route

combo enable copper

ip address 10.0.0.1 255.255.255.0

ip route-static 0.0.0.0 0 10.0.0.2

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

rule 2 name turst-untrust

action pass

source-zone trust

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
