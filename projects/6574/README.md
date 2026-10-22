# 工程名称

Ap组管理典型配置

## 需求：

AC通过交换机与AP1，AP2相连，将AP1加入group1,AP2加入group2。

## 实验步骤：

# 一、AC配置 
  
1.配置AC的接口 
创建VLAN 100及其对应的VLAN接口，并为该接口配置IP地址。AP将获取该IP地址与AC建立CAPWAP隧道 
  
<AC> system-view 
  
[AC] vlan 100 
  
[AC-vlan100] quit 
  
[AC] interface vlan-interface 100 
  
[AC-Vlan-interface100] ip address 192.168.100.1 24 
  
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
  
配置DHCP地址池1为AP动态分配的网段为192.168.100.0/24，网关地址为192.168.100.1。 
  
[AC] dhcp server ip-pool 1 
  
[AC-dhcp-pool-1] network 192.168.100.0 24 
  
[AC-dhcp-pool-1] gateway-list 192.168.100.1 
  
[AC-dhcp-pool-1] quit 
  
3.配置手动AP 
  
[AC] wlan ap ap1 model WA6320-HCL 
  
[AC-wlan-ap-ap1]serial-id H3C_78-BB-76-BA-03-00 
  
4.配置AP组 
  
[AC] wlan ap-group group1 
  
[AC-wlan-ap-group-group1] ap ap1 
  
[AC-wlan-ap-group-group1] quit 
  
[AC] wlan ap-group group2 
  
[AC-wlan-ap-group-group2] ap ap2 
  
[AC-wlan-ap-group-group2] quit 
  
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
![1](./Media/1.png) 



## 说明： 


