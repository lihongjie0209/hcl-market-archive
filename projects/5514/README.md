# 工程名称

开启自动AP功能建立CAPWAP隧道配置举例

## 需求：

AC作为DHCP服务器为AP分配IP地址，现要求使用自动AP功能，实现AP与AC自动关联，并且在关联后将AP转化为固化AP。

## 实验步骤：
# 一、AC配置 

1.配置AC的接口
 
创建VLAN 100及其对应的VLAN接口，并为该接口配置IP地址。AP将获取该IP地址与AC建立CAPWAP隧道
<AC> system-view

[AC] vlan 100

[AC-vlan100] quit

[AC] interface vlan-interface 100

[AC-Vlan-interface100] ip address 192.1.0.1 16

[AC-Vlan-interface100] quit

将与Switch相连的接口GigabitEthernet1/0/1的链路类型配置为Trunk，禁止VLAN 1通过，允许VLAN 100通过，当前Trunk口的PVID为100。

[AC] interface gigabitethernet 1/0/1

[AC-GigabitEthernet1/0/1] port link-type trunk

[AC-GigabitEthernet1/0/1] port trunk pvid vlan 100

[AC-GigabitEthernet1/0/1] undo port trunk permit vlan 1

[AC-GigabitEthernet1/0/1] port trunk permit vlan 100

[AC-GigabitEthernet1/0/1] quit

2.配置DHCP功能

开启DHCP服务。

[AC] dhcp enable

配置DHCP地址池1为AP动态分配的网段为192.1.0.0/16，网关地址为192.1.0.1。

[AC] dhcp server ip-pool 1

[AC-dhcp-pool-1] network 192.1.0.0 16

[AC-dhcp-pool-1] gateway-list 192.1.0.1

[AC-dhcp-pool-1] quit

3.配置自动AP功能

开启自动AP功能。

[AC] wlan auto-ap enable

开启自动AP自动固化功能。

[AC] wlan auto-persistent enable
# 二、交换机配置

创建VLAN 100，用于转发AC和AP间CAPWAP隧道内的流量。

<Switch> system-view

[Switch] vlan 100

[Switch-vlan100] quit

配置Switch与AC相连的GigabitEthernet1/0/1接口的属性为Trunk，禁止VLAN 1通过，允许VLAN 100通过，当前Trunk口的PVID为100。

[Switch] interface gigabitethernet 1/0/1

[Switch-GigabitEthernet1/0/1] port link-type trunk

[Switch-GigabitEthernet1/0/1] undo port trunk permit vlan 1

[Switch-GigabitEthernet1/0/1] port trunk permit vlan 100

[Switch-GigabitEthernet1/0/1] port trunk pvid vlan 100

[Switch-GigabitEthernet1/0/1] quit

配置Switch与AP相连的GigabitEthernet1/0/2接口属性为Access，当前Access口允许VLAN 100通过。

[Switch] interface gigabitethernet 1/0/2

[Switch-GigabitEthernet1/0/2] port link-type access

[Switch-GigabitEthernet1/0/2] port access vlan 100

配置Switch与AP相连的GigabitEthernet1/0/2接口使能PoE功能。

[Switch-GigabitEthernet1/0/2] poe enable

[Switch-GigabitEthernet1/0/2] quit

## 测试结果：

在AC上使用命令display wlan ap all,可以看到AP的状态是R/M状态，
![P1](./Media/p1.png) 


## 说明： 


