# 工程名称

LLB中对LLB-PBR-路由的优先级排查。

## 需求：

测试LLB/PBR/路由三者的优先级关系，看看是否有跳过某一项的情况。

## 实验步骤：

1.配置路由器的IP和路由。

2.配置防火墙地址。

3.配置链路组，链路，和虚服务。其中两个链路创建两个链路组。并且虚服务缺省为MSR3。

4.配置LB策略，匹配源地址为1.1.1.1，动作为转发。

5.配置PBR，匹配源地址1.1.1.1，下一跳为MSR4.应用于内网口。

## 测试结果：

Slot 1:

Initiator:

  Source      IP/port: 1.1.1.1/10963

  Destination IP/port: 10.1.1.1/2048

  DS-Lite tunnel peer: -

  VPN instance/VLAN ID/Inline ID: -/-/-

  Protocol: ICMP(1)

  Inbound interface: GigabitEthernet1/0/2

  Source security zone: Trust

Responder:

  Source      IP/port: 10.1.1.1/10963

  Destination IP/port: 1.1.1.1/0

  DS-Lite tunnel peer: -

  VPN instance/VLAN ID/Inline ID: -/-/-

  Protocol: ICMP(1)

  Inbound interface: **GigabitEthernet1/0/4**

  Source security zone: Trust

State: ICMP_REPLY

Application: ICMP

Rule ID: 0

Rule name: t

Start time: 2022-09-28 16:10:13  TTL: 25s

Initiator->Responder:            0 packets          0 bytes

Responder->Initiator:            0 packets          0 bytes


通过会话可以看到在全部配置都在的情况下，LLB是转发动作，就匹配优先级较低的PBR了，设备上没有路由，如果进入路由就丢包。
## 说明： 
1.按照配置取消PBR就不通。说明LLB走转发,PBR不存在，路由不配置，设备丢包。

2.如果加路由然后取消PBR是可以通的。按照路由转发。说明LLB变成转发，查PBR不存在，查路由正常转发。

3.如果取消LB策略，同时PBR存在，路由不存在，那么转发给是MSR3。说明LLB优先级最高。

