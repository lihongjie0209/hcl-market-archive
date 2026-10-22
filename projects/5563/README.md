# 工程名称
DHCP中继配置举例


## 需求：
交换机作为DHCP Server在vlan 20网段，AC作为DHCP Relay，为vlan 10网段的终端提供IP地址。

(1) 组网需求
· DHCP客户端所在网段为10.10.1.0/24，DHCP服务器的IP地址为10.1.1.1/24；
· 由于DHCP客户端和DHCP服务器不在同一网段，因此，需要在客户端所在网段设置DHCP中继设备，以便客户端可以从DHCP服务器申请到10.10.1.0/24网段的IP地址及相关配置信息；
·  AC作为DHCP中继通过端口（属于VLAN10）连接到DHCP客户端所在的网络，VLAN接口10的IP地址为10.10.1.1/24，VLAN接口20的IP地址为10.1.1.2/24。

(2)组网图

![1](./Media/图片1.png) 


## 实验步骤：

【AC配置】
1. 在AC上配置vlan 10和vlan 20的地址；
2. 配置int vlan 10接口工作在DHCP中继模式，指定DHCP服务器的地址为SWA上的地址：10.1.1.1。

【交换机配置】
1. 在交换机上配置int vlan 20接口为DHCP服务器。

## 测试结果：
在AC上查看注册AP和接入终端都通过AC作为DHCP Relay，从SWB上的DHCP Server获取了IP地址

![2](./Media/图片2.png) 

配置完成后，DHCP客户端可以通过DHCP中继从DHCP服务器获取IP地址及相关配置信息。通过display dhcp relay statistics命令可以显示DHCP中继转发的DHCP报文统计信息；如果在DHCP中继上通过dhcp relay client-information record命令启用了DHCP中继的用户地址表项记录功能，则可以通过display dhcp relay client-information命令可以显示通过DHCP中继获取IP地址的客户端信息。

![3](./Media/图片3.png) 


## 说明： 
(1) 由于DHCP中继连接客户端的接口IP地址与DHCP服务器的IP地址不在同一网段，因此需要在DHCP服务器上通过静态路由或动态路由协议保证两者之间路由可达。

(2) 为了使DHCP客户端能从DHCP服务器获得IP地址，需要在DHCP服务器上进行一些配置。

