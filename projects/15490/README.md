# 工程名称
Option138发现方式建立CAPWAP隧道配置举例 


## 需求：
AP通过交换机与AC相连，交换机做DHCP server为AP分配IP地址。需要实现AP能正常在AC上注册在线，具体要求如下：
AC属于VLAN 100，AP属于VLAN 200，AC和AP之间跨三层网络建立连接。 


## 实验步骤：
1、AC上配置IP地址和路由信息 
# 
 ip route-static 0.0.0.0 0 192.168.1.1 
# 
  
2、在交换机上配置DHCP Server，并配置option 138指定AC的IP地址： 
# 
dhcp server ip-pool ap 
 gateway-list 192.168.2.1 
 network 192.168.2.0 mask 255.255.255.0 
 option 138 ip-address 192.168.1.100 
# 
3、在AC上配置注册信息 


## 测试结果：
![option138result](./Media/option139capwapresult.png) 



## 说明： 
1、本实验用的模拟器为WX5560H-HCL、WA6320-HCL，设置内存为默认。
2、本实验用的无线版本为默认版本。 
3、需要为SWA交换机分配更大的内存空间才能使实验成功。

