# 工程名称
无线内二层隔离 


## 需求：
在集中转发场景下，Client 1、Client 2分别通过AP 1、AP 2接入无线网络，Client 1和Client 2属于VLAN 20，在AC上开启基于SSID的用户隔离功能：Client 1在VLAN 100内发送广播/组播报文，AC收到广播/组播报文后，不再将广播/组播报文复制及转发给网络中的AP，而是仅将去掉CAPWAP隧道封装的报文通过有线接口转发给Switch；Client 1在VLAN 100内向Client 2发送单播报文，AC收到单播报文后，不将报文转发给AP 2，而是直接丢弃该单播报文。 通过该SSID接入无线服务且处于同一VLAN内的无线用户之间将不能够互相访问。 


## 实验步骤：
1、AC上配置IP地址和路由信息 ；
2、配置DHCP Server ；
3、在AC上配置AP1/2注册信息； 
4、绑定同一个服务模板及业务VLAN 20 ；
5、Client 2分别通过AP 1、AP 2接入无线网络 ；
6、在服务模板下配置用户隔离命令：# user-isolation enable 。


## 测试结果：
![AP1/2注册上线](./Media/图片1.png) 

![Client 1、Client 2分别通过AP 1、AP 2接入无线网络](./Media/图片2.png) 
 
![通过该SSID接入无线服务且处于同一VLAN内的无线用户之间能够互相访问。](./Media/图片3.png) 

![服务模板下配置二层隔离命令](./Media/图片4.png) 

![通过该SSID接入无线服务且处于同一VLAN内的无线用户之间不能够互相访问。](./Media/图片5.png) 



## 说明： 

1、本实验用的模拟器为WX5560H-HCL，设置内存为默认。 
2、本实验用的无线版本为默认版本。 
