# 工程名称
接口通过DHCPv6协议有状态获取IP地址配置举例


## 需求：
AC分别为vlan 100和200网段提供DHCPv6服务，AP1和AP2分别获取这两个网段的IPv6地址，然后与AC建立CAPWAP隧道


## 实验步骤：
组网图
![1](./Media/图片1.png) 

1. AC上配置IPv6地址池1和2，分别为vlan 100和200两个网段提供地址，两个地址池分别绑定到int vlan 100和200上，并使能DHCP功能；
2. SWA上起vlan 100和200接口，配置连接AC的口为trunk，放通vlan 100和200，SWA连接AP1和AP2的口分别配置为access vlan 100和200，使AP1获取vlan 100的ipv6地址，而AP2获取vlan 200的ipv6地址。

## 测试结果：
1.AP1和AP2分别获取vlan 100和200网段的IPv6地址，然后在AC上线：

* ![2](./Media/图片2.png) 


2.通过抓包捕获了AP1通过有状态方式获取IPv6地址过程的四个报文交互：

![3](./Media/图片3.png) 
 

## 说明： 


