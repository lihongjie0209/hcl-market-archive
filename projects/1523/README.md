# 开启DHCP Snooping配置举例

**标签：**

**DHCP**

**DHCP Snooping**

## 需求

SW通过以太网端口GigabitEthernet1/0/1连接到合法DHCP服务器，通过GigabitEthernet1/0/2、GigabitEthernet1/0/3连接到DHCP客户端。

要求：

与合法DHCP服务器相连的端口可以转发DHCP服务器的响应报文，而其他端口不转发DHCP服务器的响应报文；记录DHCP-REQUEST报文和信任端口收到的DHCP-ACK报文中DHCP客户端IP地址及MAC地址的绑定信息。

## 实验步骤：

设备参考配置

\#

dhcp snooping enable

\#

interface GigabitEthernet1/0/1

port link-mode bridge

combo enable fiber

dhcp snooping trust

\#

interface GigabitEthernet1/0/2

port link-mode bridge

combo enable fiber

dhcp snooping binding record

\#

## 测试结果：

配置完成后，DHCP客户端只能从合法DHCP服务器获取IP地址和其它配置信息，非法DHCP服务器无法为DHCP客户端分配IP地址和其他配置信息。且使用display
dhcp snooping binding可查询到获取到的DHCP Snooping表项。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
