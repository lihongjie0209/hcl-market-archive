# 工程名称
Option 52方式建立双链路备份IPv6 CAPWAP典型配置举例 


## 需求：
AP与通过交换机与主备AC相连。需要实现AP能正常在AC上注册在线，具体要求如下：
主备AC属于VLAN 100，AP属于VLAN 300，AP跨三层网络分别与主备AC建立R/M和R/B的IPv6 CAPWAP隧道，交换机使用DHCPv6给AP分配IPv6地址，并通过Option 52给AP下发主备AC的IPv6地址信息 


## 实验步骤：
1、AC1上配置IP地址和路由信息，及AP模板和优先级，并指定备AC地址 
# 
interface Vlan-interface100 
 ipv6 address 1::1:0:0:1/96 
# 
# 
 ipv6 route-static 1::4:0:0:0 96 1::1:0:0:3 
# 
# 
wlan ap ap1 model WA6320-HCL 
 serial-id H3C_AC-0A-AA-02-02-00 
 wlan tunnel-preempt enable 
 priority 7 
 backup-ac ipv6 1::1:0:0:2 
 vlan 1 
 radio 1 
 radio 2 
 gigabitethernet 1 
# 
  
2、AC2上配置IP地址和路由信息，及AP模板和优先级，并指定主AC地址 
# 
interface Vlan-interface100 
 ipv6 address 1::1:0:0:2/96 
# 
# 
 ipv6 route-static 1::4:0:0:0 96 1::1:0:0:3 
# 
# 
wlan ap ap1 model WA6320-HCL 
 serial-id H3C_AC-0A-AA-02-02-00 
 wlan tunnel-preempt enable 
 priority 5 
 backup-ac ipv6 1::1:0:0:1 
 vlan 1 
 radio 1 
 radio 2 
 gigabitethernet 1 
# 
  
3、在交换机上配置vlan 100和vlan 300的网关IPv6地址 
# 
interface Vlan-interface100 
 ipv6 address 1::1:0:0:3/96 
# 
interface Vlan-interface300 
 ipv6 address 1::4:0:0:1/96 
# 
# 
ipv6 dhcp pool 3 
 network 1::4:0:0:0/96 
 option 52 hex 0001000000000000000100000000000100010000000000000001000000000002 
# 


## 测试结果：
![result](./Media/option52result.png) 



## 说明： 
1、本实验用的模拟器为WX5560H-HCL、WA6320-HCL，设置内存为默认。
2、本实验用的无线版本为默认版本。 
3、需要为SWA交换机分配更大的内存空间才能保证实验成功。

