# 工程名称
V7交换机M-LAG基本功能配置


## 需求：
1、由于用户对于业务的可靠性要求很高，如果SW3和接入设备（SW1和SW2）之间配置链路聚合只能保证链路级的可靠性，接入设备发生故障时则会导致业务中断。这时用户可以采用M-LAG技术，正常工作时链路进行负载分担且任何一台设备故障对业务均没有影响，保证业务的高可靠性。

2、配置三层以太网接口为保留接口，在该三层以太网接口上搭建Keepalive链路，保证Keepalive报文能够正常传输。


## 实验步骤：
1、 系统配置，两台设备的系统mac必须一致，系统优先级必须一致，系统编号不一致(本例sw1为1，sw2为2)
#
 m-lag system-mac 28df-92e5-0100
 m-lag system-number 1
 m-lag system-priority 100
#

2、配置Keepalive报文的目的IP地址和源IP地址
#
 m-lag keepalive ip destination 1.1.1.2 source 1.1.1.1
#

3、配置端口GigabitEthernet1/0/48工作在三层模式，并配置IP地址为Keepalive报文的源IP地址
#
interface GigabitEthernet1/0/48
 port link-mode route
 ip address 1.1.1.1 255.255.255.252
#

4、配置Keepalive链路接口为保留接口。
#
 m-lag mad exclude interface GigabitEthernet1/0/48
#

5、创建二层聚合接口1024，并配置该接口为动态聚合模式。
#
interface Bridge-Aggregation1024
 link-aggregation mode dynamic
#

6、分别将端口Ten-GigabitEthernet1/0/49和Ten-GigabitEthernet1/0/50加入到聚合组3中。
#
interface Ten-GigabitEthernet1/0/49
 port link-mode bridge
 port link-aggregation group 1024
#
interface Ten-GigabitEthernet1/0/50
 port link-mode bridge
 port link-aggregation group 1024
#

7、将二层聚合接口1024配置为peer-link接口。
#
interface Bridge-Aggregation1024
 port m-lag peer-link 1
#

8、创建二层聚合接口1，并配置该接口为动态聚合模式。
#
interface Bridge-Aggregation1
 link-aggregation mode dynamic
#

9、分别将端口GigabitEthernet1/0/1和GigabitEthernet1/0/2加入到聚合组1中。
#
interface GigabitEthernet1/0/1
 port link-mode bridge
 port link-aggregation group 1
#
interface GigabitEthernet1/0/2
 port link-mode bridge
 port link-aggregation group 1
#

10、将二层聚合接口4加入M-LAG组1中。
#
interface Bridge-Aggregation1
 port m-lag group 1
#

## 测试结果：
1、SW1查看相关信息
[SW1]dis m-lag keepalive 
Neighbor keepalive link status (cause): Up
Neighbor is alive for: 825 s 833 ms
Keepalive packet transmission status:
  Sent: Successful
  Received: Successful
Last received keepalive packet information:
  Source IP address: 1.1.1.2
  Time: 2022/10/18 14:31:23
  Action: Accept

M-LAG keepalive parameters:
Destination IP address: 1.1.1.2
Source IP address: 1.1.1.1
Keepalive UDP port : 6400
Keepalive VPN name : N/A
Keepalive interval : 1000 ms
Keepalive timeout  : 5 sec
Keepalive hold time: 3 sec
[SW1]
[SW1]dis m-lag system 
                     System information
Local system number: 1                      Peer system number: 2
Local system MAC: 28df-92e5-0100            Peer system MAC: 28df-92e5-0100
Local system priority: 100                  Peer system priority: 100
Local bridge MAC: 28df-92e5-0100            Peer bridge MAC: 28df-9675-0200
Local effective role: Primary               Peer effective role: Secondary
Health level: 0
Standalone mode on split: Disabled
In standalone mode: No

                     System timer information
Timer                      State       Value (s)    Remaining time (s)
Auto recovery              Disabled    -            -
Restore delay              Disabled    30           -
Consistency-check delay    Disabled    15           -
Standalone delay           Disabled    -            -
Role to None delay         Disabled    60           -
[SW1]
[SW1]dis m-lag verbose 
Flags: A -- Home_Gateway, B -- Neighbor_Gateway, C -- Other_Gateway,
       D -- PeerLink_Activity, E -- DRCP_Timeout, F -- Gateway_Sync,
       G -- Port_Sync, H -- Expired

Peer-link interface/Peer-link interface ID: BAGG1024/1
State: UP
Cause: -
Local DRCP flags/Peer DRCP flags: ABDFG/ABDFG
Local Selected ports (index): XGE1/0/49 (50), XGE1/0/50 (51)
Peer Selected ports indexes: 50, 51

M-LAG interface/M-LAG group ID: BAGG1/1
Local M-LAG interface state: UP
Peer M-LAG interface state: UP
M-LAG group state: UP
Local M-LAG interface down cause: -
Remaining M-LAG DOWN time: -
Local M-LAG interface LACP MAC: Config=N/A, Effective=28df-92e5-0100
Peer M-LAG interface LACP MAC: Config=N/A, Effective=28df-92e5-0100
Local M-LAG interface LACP priority: Config=32768, Effective=100
Peer M-LAG interface LACP priority: Config=32768, Effective=100
Local DRCP flags/Peer DRCP flags: ABDFG/ABDFG
Local Selected ports (index): GE1/0/1 (2), GE1/0/2 (3)
Peer Selected ports indexes: 2, 3
[SW1]          
[SW1]dis m-lag summary 
Flags: A -- Aggregate interface down, B -- No peer M-LAG interface configured
       C -- Configuration consistency check failed

Peer-link interface: BAGG1024
Peer-link interface state (cause): UP
Keepalive link state (cause): UP

                     M-LAG interface information
M-LAG IF    M-LAG group  Local state (cause)  Peer state  Remaining down time(s)
BAGG1       1            UP                   UP          -
[SW1]


2、SW3查看二层聚合1的详细状态
[SW3]dis link-aggregation verbose Bridge-Aggregation 1
Loadsharing Type: Shar -- Loadsharing, NonS -- Non-Loadsharing 
Port Status: S -- Selected, U -- Unselected, I -- Individual 
Port: A -- Auto port, M -- Management port, R -- Reference port 
Flags:  A -- LACP_Activity, B -- LACP_Timeout, C -- Aggregation, 
        D -- Synchronization, E -- Collecting, F -- Distributing, 
        G -- Defaulted, H -- Expired 

Aggregate Interface: Bridge-Aggregation1
Creation Mode: Manual
Aggregation Mode: Dynamic
Loadsharing Type: Shar
Management VLANs: None
System ID: 0x8000, 28df-9aa1-0300
Local: 
  Port                Status   Priority Index    Oper-Key               Flag
  GE1/0/1             S        32768    1        1                      {ACDEF}
  GE1/0/2             S        32768    2        1                      {ACDEF}
  GE1/0/3             S        32768    3        1                      {ACDEF}
  GE1/0/4             S        32768    4        1                      {ACDEF}
Remote: 
  Actor               Priority Index    Oper-Key SystemID               Flag   
  GE1/0/1(R)          32768    16387    40001    0x64  , 28df-92e5-0100 {ACDEF}
  GE1/0/2             32768    16388    40001    0x64  , 28df-92e5-0100 {ACDEF}
  GE1/0/3             32768    32771    40001    0x64  , 28df-92e5-0100 {ACDEF}
  GE1/0/4             32768    32772    40001    0x64  , 28df-92e5-0100 {ACDEF}
[SW3]   


## 说明： 
1、SW1和SW2的配置除了m-lag system-number以外基本一致，实验步骤仅列举SW1

2、M-LAG系统中相互配对的M-LAG接口的系统MAC地址必须相同。


3、建议用户将系统MAC地址配置为其中一台M-LAG设备的桥MAC地址。

4、修改M-LAG设备的系统MAC地址将会导致当前设备从已经建立的M-LAG组中分裂。因此M-LAG系统形成后，不建议修改系统MAC地址。
