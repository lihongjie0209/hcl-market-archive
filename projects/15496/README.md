# 工程名称
通过在AP上手工指定AC IPv6地址建立IPv6三层CAPWAP隧道配置举例 

## 需求：
AP通过交换机跨三层与AC相连，AP和AC均手动配置IPv6地址。需要实现AP能正常在AC上注册在线，具体要求如下：
AC属于VLAN 100，AP属于VLAN 200，AC和AP之间跨三层网络建立连接。 

## 实验步骤：
1、AC上配置IPv6地址和路由信息，并开启AP自动注册和自动固化功能 
# 
 wlan auto-ap enable 
 wlan auto-persistent enable 
# 
# 
interface Vlan-interface100 
 ipv6 address 1::1:0:0:1/96 
# 
# 
 ipv6 route-static 1::2:0:0:0 96 1::1:0:0:2 
# 
  
2、在交换机上配置DHCP Server，并配置option 138指定AC的IP地址： 
# 
interface Vlan-interface100 
 ipv6 address 1::1:0:0:2/96 
# 
interface Vlan-interface200 
 ipv6 address 1::2:0:0:1/96 
# 
  
3、在AP上配置手工IPv6地址，静态IPv6路由，并指定AC的IPv6地址 
# 
interface Vlan-interface1 
 ip address dhcp-alloc 
 ipv6 address 1::2:0:0:2/96 
 ipv6 address auto 
 ipv6 address dhcp-alloc 
# 
# 
 ipv6 route-static 1::1:0:0:0 96 1::2:0:0:1 
# 
# 
 wlan ac ipv6 1::1:0:0:1 
# 


## 测试结果：
![result111](./Media/result111.png) 



## 说明： 
1、本实验用的模拟器为WX5560H-HCL、WA6320-HCL，设置内存为默认。
2、本实验用的无线版本为默认版本。 

