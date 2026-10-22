**标签：**

IRF

冗余主备

Reth 口

**需求：**

2台防火墙堆叠，通过Reth1口（冗余口）和上行交换机SW1互联，下行两个三层口和MSR对接，正常情况下业务由MSR的G0/1口上到FW1处理，当FW1故障时业务切换至FW2处理。其中，防火墙G1/0/2口地址为10.10.1.1/24，G2/0/2口地址为10.20.1.1/24；MSR
G0/1口地址为10.10.1.2/24，G0/2口地址为10.20.1.2/24。

**实验步骤：**

1、网络搭建

根据组网图搭建环境，配置2台防火墙堆叠，连接交换机。（略）

完成后防火墙IRF状态如下，建议后续配置冗余主和IRF主都在同一个slot上。

\<FW1\>display irf

MemberID Role Priority CPU-Mac Description

\*+1 Master 32 3a8c-64b5-0104 \-\--

2 Standby 1 3a8c-6d5c-0204 \-\--

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

\* indicates the device is the master.

\+ indicates the device through which the user logs in.

The bridge MAC of the IRF is: 3a8c-64b5-0100

Auto upgrade : yes

Mac persistent : 6 min

Domain ID : 0

2、配置上行口为Reth1

3、将Reth1口加入Untrust安全域，并放通相应安全策略。

4、配置冗余组，将冗余口Reth1加入冗余组aaa，并配置全局track项在冗余组中引用。

5、下行MSR上配置主备双路由。

配置G0/1和G0/2的接口IP地址分别为10.10.1.2/24和10.20.1.2/24。

创建环回口LoopBack 0，IP地址为1.1.1.1/32，作为后续测试地址。

配置MSR的缺省路由，主走G0/1口，备走G0/2口，以路由优先级区分。

**测试结果：**

**由于模拟器防火墙软件问题，Reth口直连不通，上行无法测试连通性。**

完成以上配置后，display redundancy
group查看冗余组状态，可以看到冗余组的主在Slot1上，此时Reth1口的主也在Slot1上，防火墙Slot1处理业务，Slot2热备不处理业务。

\<FW1\>display redundancy group

Redundancy group aaa (ID 1):

Node ID Slot Priority Status Track weight

1 Slot1 1 Primary 255

2 Slot2 1 Secondary 255

Preempt delay time remained : 0 min

Preempt delay timer setting : 1 min

Remaining hold-down time : 0 sec

Hold-down timer setting : 1 sec

Manual switchover request : No

Member interfaces:

Reth1

Node 1:

Node member Physical status

GE1/0/2 UP

Track info:

Track Status Reduced weight Interface

1 Positive 255 GE1/0/1

3 Positive 255 GE1/0/2

Node 2:

Node member Physical status

GE2/0/2 UP

Track info:

Track Status Reduced weight Interface

2 Positive 255 GE2/0/1

4 Positive 255 GE2/0/2

此时在MSR带源地址1.1.1.1长ping
2.2.2.2，查看会话表项，报文从G1/0/2口进入防火墙。

\<FW1\>display session table ipv4 source-ip 1.1.1.1 destination-ip
2.2.2.2 verbose

Slot 1:

Initiator:

Source IP/port: 1.1.1.1/303

Destination IP/port: 2.2.2.2/2048

DS-Lite tunnel peer: -

VPN instance/VLAN ID/Inline ID: -/-/-

Protocol: ICMP(1)

Inbound interface: GigabitEthernet1/0/2

Source security zone: Trust

Responder:

Source IP/port: 2.2.2.2/303

Destination IP/port: 1.1.1.1/0

DS-Lite tunnel peer: -

VPN instance/VLAN ID/Inline ID: -/-/-

Protocol: ICMP(1)

Inbound interface: InLoopBack0

Source security zone: Local

State: ICMP_REPLY

Application: ICMP

Rule ID: 1

Rule name: any

Start time: 2021-03-15 16:55:33 TTL: 26s

Initiator-\>Responder: 5 packets 420 bytes

Responder-\>Initiator: 5 packets 420 bytes

Total sessions found: 1

此时关闭MSR的G0/1口，MSR的缺省路由出口切换到G0/2，查看会话表项，报文从G2/0/2口进入防火墙。

\<FW1\>display session table ipv4 source-ip 1.1.1.1 destination-ip
2.2.2.2 verbose

Slot 1:

Total sessions found: 0

Slot 2:

Initiator:

Source IP/port: 1.1.1.1/301

Destination IP/port: 2.2.2.2/2048

DS-Lite tunnel peer: -

VPN instance/VLAN ID/Inline ID: -/-/-

Protocol: ICMP(1)

Inbound interface: GigabitEthernet2/0/2

Source security zone: Trust

Responder:

Source IP/port: 2.2.2.2/301

Destination IP/port: 1.1.1.1/0

DS-Lite tunnel peer: -

VPN instance/VLAN ID/Inline ID: -/-/-

Protocol: ICMP(1)

Inbound interface: InLoopBack0

Source security zone: Local

State: ICMP_REPLY

Application: ICMP

Rule ID: 1

Rule name: any

Start time: 2021-03-15 16:46:09 TTL: 11s

Initiator-\>Responder: 5 packets 420 bytes

Responder-\>Initiator: 5 packets 420 bytes

Total sessions found: 1

此时G1/0/2口状态为DOWN，Slot1节点权重降低，冗余组的主切换到Slot2上。

\<FW1\>dis re g

Redundancy group aaa (ID 1):

Node ID Slot Priority Status Track weight

1 Slot1 1 Secondary -255

2 Slot2 1 Primary 255

Preempt delay time remained : 0 min

Preempt delay timer setting : 1 min

Remaining hold-down time : 0 sec

Hold-down timer setting : 1 sec

Manual switchover request : No

Member interfaces:

Reth1

Node 1:

Node member Physical status

GE1/0/2 DOWN

Track info:

Track Status Reduced weight Interface

1 Negative 255 GE1/0/1

3 Negative(Faulty) 255 GE1/0/2

Node 2:

Node member Physical status

GE2/0/2 UP

Track info:

Track Status Reduced weight Interface

2 Positive 255 GE2/0/1

4 Positive 255 GE2/0/2

缺省情况下冗余组节点的倒回延时为1分钟，undo shutdown
G0/1之后，MSR的缺省主路由立刻恢复，冗余组1分钟后恢复到之前的状态。

**说明：**

1、本实验用的模拟器为F1060，设置内存为默认。

2、冗余口只能对接Vlan虚接口，对端交换机接口一定不能聚合，否则直连不通。（真机）

3、switchover request命令可以手动切换冗余组的状态。

4、主备状态下一般建议开启会话同步功能，但是模拟器防火墙由于软件问题会话同步功能不生效。
