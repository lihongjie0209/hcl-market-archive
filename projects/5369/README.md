# 工程名称
Option43发现方式建立CAPWAP隧道配置举例


## 需求：
AP通过交换机与AC相连，交换机做DHCP server为AP分配IP地址。需要实现AP能正常在AC上注册在线，具体要求如下： 
AC属于VLAN 1，AP属于VLAN 2，AC和AP之间跨三层网络建立连接。


## 实验步骤：
1、AC上配置IP地址和路由信息 

2、配置DHCP Server 

3、在AC上配置注册信息 


## 测试结果：
在AC上使用命令display wlan ap all查看AP，可以看到AP的状态是R/M，表明AP已经成功注册到AC。 

![display](./Media/1.png) 

查看AP的IP地址。 

![display](./Media/2.png) 

在AC上查看AP的详细在线信息。
 
![display](./Media/3.png) 


## 说明： 
1、本实验用的模拟器为WX5560H-HCL、WA6320-HCL，设置内存为默认。 
2、本实验用的无线版本为默认版本。 

