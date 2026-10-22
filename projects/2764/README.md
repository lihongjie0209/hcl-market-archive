# 工程名称



## 需求：
1、SW1、SW2、SW3和SW4属于同一自治系统，要求它们之间通过IS-IS协议达到IP网络互连的目的。
2、SW1和SW2为Level-1交换机，SW4为Level-2交换机，SW3作为Level-1-2交换机将两个区域相连。SW1、SW2和SW3的区域号为10，SW4的区域号为20。


## 实验步骤：
1、配置接口ip，以SW4为例
#
interface GigabitEthernet1/0/4
 port link-mode bridge
 port access vlan 40
#
interface Vlan-interface40
 ip address 10.0.34.4 255.255.255.0
#

2、配置IS-IS，以SW4为例
#
isis 1
 is-level level-2
 network-entity 20.0000.0000.0001.00
#
interface Vlan-interface40
 isis enable 1
#

## 测试结果：
1、查看ISIS邻居表，以SW4为例
<SW4>dis isis peer 
                         Peer information for IS-IS(1)
                         -----------------------------
 System ID: 0000.0000.0003
 Interface: Vlan40                  Circuit Id:  0000.0000.0001.01
 State: Up     HoldTime: 24s        Type: L2(L1L2)     PRI: 64
<SW4>

2、查看LSDB数据库，以SW4为例
<SW4>dis isis lsdb 
                       Database information for IS-IS(1)
                       ---------------------------------
                          Level-2 Link State Database
                          ---------------------------
LSPID                 Seq Num      Checksum      Holdtime      Length  ATT/P/OL
-------------------------------------------------------------------------------
0000.0000.0001.00-00* 0x00000003   0x6389        1074          68      0/0/0
0000.0000.0001.01-00* 0x00000001   0xd3b6        1074          55      0/0/0
0000.0000.0003.00-00  0x00000006   0x78d2        1073          100     0/0/0

    *-Self LSP, +-Self LSP(Extended), ATT-Attached, P-Partition, OL-Overload
<SW4>



## 说明： 
1、在配置System ID时，可以由Router ID转换而来，也可以随意指定。将Router ID转换为System ID的方法举例：Router ID为1.1.1.1，先将每一部分扩展为3位：001.001.001.001，再均分为3个部分：0010.0100.1001即可。

2、NET由三部分组成：
·     区域ID：它的长度可变的，为1～13个字节。
·     System ID：用来在区域内唯一标识主机或路由器，它的长度固定为6个字节。
·     SEL：为0，它的长度固定为1个字节。
例如NET为：ab.cdef.1234.5678.9abc.00，则其中区域ID为ab.cdef，System ID为1234.5678.9abc，SEL为00。

