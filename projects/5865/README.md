# 工程名称

DHCPv6发现方式建立CAPWAP隧道典型配置举例

## 需求：

AC作为DHCPv6服务器为AP分配IPv6,并使用手动AP功能，实现AP与AC的手动关联


## 实验步骤：

# 一、AC配置 
  
1.配置AC的接口 
创建VLAN 100及其对应的VLAN接口，并为该接口配置IPv6地址。AP将获取该IP地址与AC建立CAPWAP隧道 
  
<AC> system-view 
  
[AC] vlan 100 
  
[AC-vlan100] quit 
  
[AC] interface vlan-interface 100 
  
[AC-Vlan-interface100] ipv6 address 1::1:0:0:1/96 
  
[AC-Vlan-interface100] quit 
  
将与Switch相连的接口GigabitEthernet1/0/1的链路类型配置为Trunk，禁止VLAN 1通过，允许VLAN 100通过，当前Trunk口的PVID为100。 
  
[AC] interface gigabitethernet 1/0/1 
  
[AC-GigabitEthernet1/0/1] port link-type trunk 
  
[AC-GigabitEthernet1/0/1] port trunk pvid vlan 100 
  
[AC-GigabitEthernet1/0/1] undo port trunk permit vlan 1 
  
[AC-GigabitEthernet1/0/1] port trunk permit vlan 100 
  
[AC-GigabitEthernet1/0/1] quit 
  
2.配置DHCPv6功能 
  
配置接口Vlan-interface100工作在DHCPv6服务器模式，并配置接口引用DHCP地址池。 
  
[AC] interface vlan-interface 100 
  
[AC-Vlan-interface100] ipv6 dhcp select server 
  
[AC-Vlan-interface100] ipv6 dhcp server apply pool 1 
  
取消设备发布RA消息的抑制功能。配置被管理地址的配置标志位为1，即主机通过DHCPv6服务器获取IPv6地址。配置其他信息配置标志位为1，即主机通过DHCPv6服务器获取除IPv6地址以外的其他信息。 
  
[AC-Vlan-interface100] undo ipv6 nd ra halt 
  
[AC-Vlan-interface100] ipv6 nd autoconfig managed-address-flag 
  
[AC-Vlan-interface100] ipv6 nd autoconfig other-flag 
  
配置DHCPv6地址池1，为1::1:0:0:0/96网的AP分配IPv6地址等参数 
  
[AC] ipv6 dhcp pool 1 
  
[AC-dhcp6-pool-1] network 1::1:0:0:0/96 
  
[AC-dhcp6-pool-1] quit 
  
3.配置手动AP 
  
[AC] wlan ap ap1 model WA6320-HCL 
  
[AC-wlan-ap-ap1]serial-id H3C_78-BB-76-BA-03-00 
  
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

在AC上使用命令display wlan ap all查看AP，可以看到AP的状态是R/M，ap的地址为IPv6地址
![1](./Media/1.png) 


## 说明： 


