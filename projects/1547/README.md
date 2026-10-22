# SNMP

**标签：**

**SNMP**

## 需求

SNMP（Simple Network Management
Protocol，简单网络管理协议）广泛用于网络设备的远程管理和操作。SNMP允许管理员通过NMS对网络上不同厂商、不同物理特性、采用不同互联技术的设备进行管理，包括状态监控、数据采集和故障处理。

NMS与Agent相连，NMS通过SNMPv2c对Agent进行监控管理。

## 实验步骤：

1、配置各接口的IP地址

2、配置SNMP

\#

snmp-agent

snmp-agent community write private

snmp-agent community read public

snmp-agent sys-info version v2c v3

\#

注意：此时是以团体名称public、private作为演示，实际中不建议使用这两个名称。

## 测试结果：

NMS获取设备的名称：

get 1.3.6.1.2.1.1.5.0

返回结果：

Request binding:

1: sysName.0 (null) null

Response binding:

1: sysName.0 (octet string) RTA \[52.54.41 (hex)\]

RTA即为设备的名称。

通过Set修改设备的名称：

\*\*\*\*\* SNMP SET-RESPONSE START \*\*\*\*\*

1: sysName.0 (octet string) NMS \[4E.4D.53 (hex)\]

\*\*\*\*\* SNMP SET-RESPONSE END \*\*\*\*\*

登录设备查看，设备的名称已经修改：

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
